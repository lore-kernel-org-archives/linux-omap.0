From: radha k <radha_kodirekka@yahoo.com>
Subject: regarding USB
Date: Thu, 20 Sep 2007 23:42:59 -0700 (PDT)
Message-ID: <910697.71510.qm@web60919.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

I configured the OSK5912 for supporting USB FLASH
according to the follwing procedure

USb Flash has been detected.
But when i am trying to mount USB(step 3) it is
showing this error

mount: Mounting /dev/sda1 on /mnt/usb failed: No such
device or address

Kindly help me in this regard

Using USB Flash memory with the OSK5912

   1. Compile the kernel with following options
enabled.

Device Drivers --->
USB support --->
 <*> Support for host-side USB 		( CONFIG_USB )
 <*> OHCI HCD support			( CONFIG_USB_OHCI_HCD )
 <*> USB Mass Storage Support		( CONFIG_USB_STORAGE )

SCSI device support --->			( CONFIG_SCSI )
 <*> SCSI disk support			( CONFIG_BLK_DEV_SD )

      At least one file system must be enabled. The
below describes vfat file system as an example
(compatible with Windows).

"File systems" --->
"DOS/FAT/NT Filesystems" --->		( CONFIG_FAT_FS)
 <*> MSDOS fs support			( CONFIG_MSDOS_FS )
 <*> VFAT ( Windows-95 fs support)		( CONFIG_VFAT_FS )

"File systems" --->
"Partition Types"  --->
 [*] Advanced partition selection		(
CONFIG_PARTITION_ADVANCED )
 [*] PC BIOS (MSDOS partition table)		(
CONFIG_MSDOS_PARTITION )

"File systems" --->
"Native Language Support" --->		( CONFIG_NLS )
 <*> Code Page 437 (United States...)	(
CONFIG_NLS_CODEPAGE_437 )
 <*> NLS ISO8859 (Latan 1...)		( CONFIG_NLS_ISO8859_1
)

   2. Register the usb

      Add the following line in OSK's '/etc/fstab'
file.

/dev/sda1    /mnt/usb    vfat    defaults    0 0

   3. Mount the file system

# mkdir /mnt/usb
# mknod /dev/sda1 b 8 1
# mount /dev/sda1 /mnt/usb -t vfat

   4. Access the USB Flash.

      Now, you can access the USB Flash contents under
/mnt/usb directory.

# ls /mnt/usb

   5. Remove the USB Flash

      Ensure umount before removing the device.

# umount /mnt/usb


      ____________________________________________________________________________________
Don't let your dream ride pass you by. Make it a reality with Yahoo! Autos.
http://autos.yahoo.com/index.html
 
