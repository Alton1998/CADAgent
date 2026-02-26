import os
import uuid

from deepagents import create_deep_agent
from dotenv import load_dotenv
from langgraph.checkpoint.memory import MemorySaver
from deepagents.backends import LocalShellBackend
from prompts import COORDINATOR_SYSTEM_PROMPT
from subagent import openscad_subagent
from utils import format_message

if __name__ == '__main__':
    load_dotenv()
    checkpointer = MemorySaver()
    thread_id = uuid.uuid4()
    config = {"configurable": {"thread_id": thread_id}}
    subagents = [openscad_subagent]
    main_agent = create_deep_agent(
        model=os.getenv("MODEL","openai:gpt-4.1-2025-04-14"),
        system_prompt=COORDINATOR_SYSTEM_PROMPT,
        backend=LocalShellBackend(root_dir="/Users/dsouz/PycharmProjects/CADAgent",env={
        "PATH": os.environ["PATH"] + r";C:\Program Files\OpenSCAD"
    }),
        checkpointer=checkpointer,
        subagents=subagents,
    )
    while True:
        try:
            message = input("Enter your message: ").strip()
            image_url = input("Enter image url: ").strip()
            print(message)
            if message == "exit":
                break
            content_block = []
            content_block.append({"type": "text", "text": message},)
            if image_url:
                content_block.append({"type": "image_url", "image_url": {"url": image_url}})
            messages = []
            messages.append({
                "role":"user",
                "content": content_block,
            })
            result = main_agent.invoke(
            {
                "messages":messages
            },config=config
        )
            format_message(result["messages"])
        except Exception as e:
            print(e)