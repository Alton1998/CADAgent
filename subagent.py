import os

from prompts import OPENSCAD_SYSTEM_PROMPT
from tools import generate_openscad_code

openscad_subagent = {
    "name": "openscad_subagent",
    "description": """Use this agent to generate openscad code by providing a description of an object. 
    For example:
     I want to create an aerodynamic  car.
     I want to create a tree.
    """,
    "system_prompt": OPENSCAD_SYSTEM_PROMPT,
    "tools":[generate_openscad_code],
    "model":os.getenv("MODEL","openai:gpt-4.1-2025-04-14")
}