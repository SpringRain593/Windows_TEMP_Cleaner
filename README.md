# 🧹 Windows Temp Cleaner Tool – Documentation

## 📄 File Name:
`CleanTempTool.bat`

---

## 🔍 Purpose

This batch script is designed to automatically:

- Clean temporary files from the user’s Temp folder
- Clean the system Temp folder (`C:\Windows\Temp`)
- Clean the Windows Update cache
- Clean Google Chrome cache directories
- Display a simulated progress bar during execution
- Estimate and report the total amount of space freed
- Show a final popup message with a summary
- Track and report any cleanup errors

---

## ✅ Key Features

| Feature               | Description                                                |
|-----------------------|------------------------------------------------------------|
| 🔧 Auto Cleanup        | Deletes junk from common temp and cache directories        |
| 📏 Size Calculation    | Estimates how much space will be freed (in MB)             |
| 📊 Text Progress Bar   | Visual progress indicator for each cleanup stage           |
| ❗ Error Detection     | Counts and displays errors (e.g., files in use)             |
| 💬 Popup Summary       | Final message box showing results and errors (if any)      |

---

## 📁 Cleanup Locations

The script removes temporary data from:

1. `%TEMP%` – User temp folder
2. `C:\Windows\Temp` – System-wide temp folder
3. `C:\Windows\SoftwareDistribution\Download` – Windows Update cache
4. Google Chrome cache folders:
   - `Cache`
   - `Code Cache`
   - `GPUCache`

---

## 🧪 How It Works

1. **Estimates File Size**
   - Uses PowerShell to recursively calculate total file size
   - Converts the result from bytes to MB

2. **Performs Cleanup**
   - Force-closes Chrome
   - Deletes temp/cache folders using `del` and `rd`
   - Tracks any errors during the process

3. **Simulates Progress**
   - Shows an ASCII-style loading bar using `#` characters

4. **Displays Results**
   - Pops up a message box indicating:
     - Total space freed (in MB)
     - Error count (if any)

---

## 🧑‍💻 Usage Instructions

### Requirements:
- Windows 10 or later
- Administrator privileges required

### How to Use:

1. Open the script in **Visual Studio Code**
2. Save the file as `CleanTempTool.bat`
   - **Encoding: `UTF-8 with BOM`**
3. Right-click the `.bat` file and select  
   > **Run as Administrator**
4. Let the process run and check the popup at the end

---

## ⚠️ What It Does NOT Delete

- User documents or files
- Saved passwords or cookies
- Browser history or bookmarks
- App settings or user profiles

✅ It is safe for daily/weekly cleanup of temporary system junk.

---

## 💬 Error Handling

- Errors are tracked using built-in checks
- Common reasons for failure:
  - Files are currently in use
  - Permissions are restricted
- A summary popup will show the number of errors

---

## 🧰 Customization Ideas

This script can be extended to:

- Clean Firefox and Edge cache
- Write cleanup logs to `.txt` or `.log`
- Include Task Scheduler automation
- Wrap into `.exe` with a GUI (PowerShell or other tools)

---

## 📝 Change Log

| Version | Date       | Description                              |
|---------|------------|------------------------------------------|
| 1.0     | 2025-04-22 | Initial version with progress bar, space calculation, and error reporting |

---

## 📂 License

This tool is provided as-is, with no warranties. Use at your own discretion.