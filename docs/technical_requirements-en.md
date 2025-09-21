# 1. Project Goal

The goal of the project is to develop a program for viewing and editing files responsible for visualizing objects in Supercell games.
# 2. Program Description

The program consists of the following sections:

1. Graphics File Import
    1. SC Format
    2. SC2 Format
2. Texture File Import
    1. KTX Format
    2. ZKTX Format
    3. SCTX Format
3. Object Viewing
4. Object Editing
5. Image and Video Export
6. Graphics File Export

## 2.1. Graphics File Import

This section includes opening a file and loading internal objects. Objects available for viewing must be added to a table list.

### 2.1.1 SC Format

The SC format is a proprietary version of Adobe's SWF format. This modification reduced memory usage.

A proprietary (deserialization) mechanism based on streaming data reading is used for reading and writing files. The game only supports compressed formats (LZMA, LZHAM, ZSTD).

The format has been deprecated in favor of a newer version, also known as SC2. The file extension has not changed.

### 2.1.2 SC2 Format

The SC2 format consists of the same objects (entities) structure, but uses an external library for serialization—Google's FlatBuffers.

The FlatBuffers library is more memory-efficient in reading data (zero-copy parsing), but the advantage of streaming reading is lost: the file must be stored in the device's memory in an uncompressed form.

This caused the company to experience issues where the game would not load if the device did not have the required amount of memory.

The advantages of this format are not visible in the game due to backward compatibility with the previous format: FlatBuffer objects are reassembled into SC format objects.

## 2.2. Importing Texture Files

The program must support the import of texture files of all formats supported by the SC format. Textures must be added to a table list.

### 2.2.1. KTX Format

Developed by The Khronos Group, this format serves as a texture container. It is a standard for mobile games, as it is supported out of the box on most devices.

The format is lossy, making it unsuitable for some purposes (for example, light maps).

It was previously used for most textures in the company's games.

### 2.2.2 ZKTX Format

A KTX file compressed with Zstandard.

### 2.2.3 SCTX Format

The SCTX format is a proprietary texture container; it uses Google's FlatBuffers.

It has its own texture types, allowing it to support uncompressed textures.

## 2.3. Object Viewer

The program should display an object and its information when clicked in the object table, as well as allow movement around the scene and zooming in and out on the object.

The file structure contains the following objects:

1. Shape — a shape with a texture
2. MovieClip — an animation object that contains other objects
3. TextField — a text field
4. SWFTexture — a texture

### 2.3.1. Shape Preview

Along with shape display, it is necessary to specify the grid along which the shape is stretched for viewing "9-slice" shapes. Editing this grid by stretching the object along the edge and corner points is also allowed, but only in preview mode.

The information about this object should contain a description of the commands used to draw the shape.

### 2.3.2. Animation Preview

Frame-by-frame animation display with the ability to select a frame range by "keys" (frame names). Different display options depend on the frame selection type.

The information about this object should include:

1. Children table
2. Frame list table
3. Children table of the current frame
4. Frame selection type
5. Frames per second

### 2.3.3. Text Field Preview

The preview text specified in the settings must be displayed as text in text fields.

Object Information:

1. Font
2. Font Size
3. Original Text
4. Line Wrap Support
5. Text Style: Bold, Italic

### 2.3.4. Texture Preview

Object information contains only the canvas dimensions and pixel format.

It should also be possible to search for Shapes by texture fragment. This will make it easier to find the desired objects.

## 2.4. Editing

Editing involves creating new and editing existing objects. The functionality of this block includes:

1. Creating an object
2. Changing object properties: setting the text field font, text size, animation FPS, and so on
3. Adding "children" to an object by creating a new "Children" table item using a button or by dragging an object from the general list of objects to the object table area or to the scene, deleting existing ones
4. Creating new frames, deleting existing ones
5. Modifying a mesh by points
6. Importing new textures into a graphics file
7. Replacing existing textures
8. Selecting a texture area that is a figure texture
9. Lock elements for editing

## 2.5. Exporting images, video

The program must receive images
