From: "Kanagesh R" <kanagesh@india.com>
Subject: USB Flash Disk on OSK
Date: Fri, 23 Dec 2005 22:03:28 +0800
Message-ID: <20051223140328.3071B7B524@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I am trying to get a Linksys USB-to-Wireless adapter working with the OSK. =
 I started=20
off by trying to check if the USB Master interface works using a Flash disk=
.  When I
plug in the USB disk, I see that usb interrupts do not occur.=20=20

I'm using a linux-2.4.16 kernel, patched with omap1 patch from www.muru.com=
.  I've=20
configured and built the kernel for OSK with the USB support according to t=
he document=20
at OSK for dummies:

Device Drivers --->
USB support --->
 <*> Support for host-side USB ( CONFIG_USB )
 <*> OHCI HCD support( CONFIG_USB_OHCI_HCD )
 <*> USB Mass Storage Support( CONFIG_USB_STORAGE )

SCSI device support --->( CONFIG_SCSI )
 <*> SCSI disk support( CONFIG_BLK_DEV_SD )

"File systems" --->
"DOS/FAT/NT Filesystems" --->( CONFIG_FAT_FS)
 <*> MSDOS fs support( CONFIG_MSDOS_FS )
 <*> VFAT ( Windows-95 fs support)( CONFIG_VFAT_FS )

"File systems" --->
"Partition Types"  --->
 [*] Advanced partition selection( CONFIG_PARTITION_ADVANCED )
 [*] PC BIOS (MSDOS partition table)( CONFIG_MSDOS_PARTITION )

"File systems" --->
"Native Language Support" --->( CONFIG_NLS )
 <*> Code Page 437 (United States...)( CONFIG_NLS_CODEPAGE_437 )
 <*> NLS ISO8859 (Latan 1...)( CONFIG_NLS_ISO8859_1 )

As far as my understanding goes, irrespective of whether the=20
device has been configured for USB Mass storage or not, if the=20
device is recognized, USB interrupts should occur, which is not
happening.=20=20

cat /proc/interrupt returns:

CPU0
 19:          0   DMA
 20:          0   DMA
 21:          0   DMA
 22:          0   DMA
 23:          0   DMA
 24:          0   DMA
 25:          0   LCD DMA
 31:          3   omap-lcdc
 33:          1   omap-keypad
 36:          0   i2c_omap
 38:          0   ohci_hcd:usb1
 46:        548   serial
 54:     158278   32KHz timer
 85:          0   DMA
 86:          0   DMA
 87:          0   DMA
 88:          0   DMA
 89:          0   DMA
 90:          0   DMA
 91:          0   DMA
 92:          0   DMA
 93:          0   DMA
 94:          0   DMA
160:       1399   eth0
197:          0   serial wakeup
222:          0   omap_cf


Has anyone successfully got the USB Master interface on the OSK5912=20
to work fine?=20=20

Thanks in advance,

Regards,
Kanagesh

--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
