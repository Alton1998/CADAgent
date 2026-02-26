from typing import Annotated

from langchain.tools import tool
from langchain_core.tools import InjectedToolCallId


@tool
def generate_openscad_code(code: str) -> str:
    """Generates OpenSCAD source code for downstream compilation.

    This tool serves as an interface for producing valid OpenSCAD (.scad)
    code that can later be compiled into 3D formats such as STL using
    an OpenSCAD execution backend. It does not perform validation,
    file writing, or compilation.

    Args:
        code (str): A string containing valid OpenSCAD syntax. The code
            should define one or more 3D objects using primitives
            (e.g., cube, sphere, cylinder), transformations
            (e.g., translate, rotate, scale), or parametric modules.

    Returns:
        str: The OpenSCAD source code string. This output is typically
        passed to a separate compilation tool within a sandboxed
        environment.

    Raises:
        None.

    Example:
        >>> generate_openscad_code("cube([10, 10, 10]);")
        'cube([10, 10, 10]);'
    """
    return code