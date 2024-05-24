## Steps to Manually Edit `vmInventory.xml` to Delete a VM

## Enable SSH and Connect to ESXi Host

1. **Enable SSH on your ESXi host** (if not already enabled).
2. **Use an SSH client** (such as PuTTY) to connect to your ESXi host.
3. **Log in with your root or administrative credentials**.

## Backup `vmInventory.xml`

Before making any changes, create a backup of the `vmInventory.xml` file.

```sh
cp /etc/vmware/hostd/vmInventory.xml /etc/vmware/hostd/vmInventory.xml.bak
```

## Edit `vmInventory.xml`

1. **Open the `vmInventory.xml` file** with a text editor (e.g., `vi` or `nano`).

    ```sh
    vi /etc/vmware/hostd/vmInventory.xml
    ```

2. **Locate the section corresponding to the problematic VM**. It will look something like this:

    ```xml
    <configEntry id="1">
      <vmxCfgPath>[datastore1] check-linux/check-linux.vmx</vmxCfgPath>
      <vmxId>52 02 56 db 6c 1f 72 5a-3f 9c c3 e0 c4 c6 68 2c</vmxId>
    </configEntry>
    ```

3. **Delete the entire `<configEntry>` section** for the problematic VM.

## Save and Close the File

1. **Save the changes** and close the text editor.

    - In `vi`, press `Esc`, type `:wq`, and press `Enter`.
    - In `nano`, press `Ctrl+O` to save and `Ctrl+X` to exit.

## Restart Management Agents

Restart the ESXi management agents to apply the changes.

```sh
/etc/init.d/hostd restart
/etc/init.d/vpxa restart
```

## Delete the VM’s Files from the Datastore

Navigate to the VM’s directory in the datastore and delete its files.

```sh
cd /vmfs/volumes/datastore1/check-linux
rm -rf /vmfs/volumes/datastore1/check-linux
```

## Example

Here's an example of what the `vmInventory.xml` file might look like before and after the edit.

**Before:**

```xml
<configEntry id="1">
  <vmxCfgPath>[datastore1] check-linux/check-linux.vmx</vmxCfgPath>
  <vmxId>52 02 56 db 6c 1f 72 5a-3f 9c c3 e0 c4 c6 68 2c</vmxId>
</configEntry>
<configEntry id="2">
  <vmxCfgPath>[datastore1] another-vm/another-vm.vmx</vmxCfgPath>
  <vmxId>52 02 56 db 6c 1f 72 5a-3f 9c c3 e0 c4 c6 68 2d</vmxId>
</configEntry>
```

**After:**

```xml
<configEntry id="2">
  <vmxCfgPath>[datastore1] another-vm/another-vm.vmx</vmxCfgPath>
  <vmxId>52 02 56 db 6c 1f 72 5a-3f 9c c3 e0 c4 c6 68 2d</vmxId>
</configEntry>
```

## Precautions

- **Backup Data:** Ensure any critical data is backed up before making changes.
- **Verify Changes:** Double-check that you are removing the correct `<configEntry>` section to avoid unintentional data loss.
- **Restarting Management Agents:** Restarting the management agents will temporarily disrupt management tasks, so ensure no critical operations are ongoing.
