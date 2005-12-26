From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: USB Flash Disk on OSK
Date: Mon, 26 Dec 2005 19:51:26 +0800
Message-ID: <20051226115126.370D543844@ws5-1.us4.outblaze.com>
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
To: Kanagesh R <kanagesh@india.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>=20
> Hello,
>=20
> I am trying to get a Linksys USB-to-Wireless adapter working with=20
> the OSK.  I started
> off by trying to check if the USB Master interface works using a=20
> Flash disk.  When I
> plug in the USB disk, I see that usb interrupts do not occur.
>=20
> I'm using a linux-2.4.16 kernel, patched with omap1 patch from=20
> www.muru.com.  I've
> configured and built the kernel for OSK with the USB support=20
> according to the document
> at OSK for dummies:
>=20
> Device Drivers --->
> USB support --->
>   <*> Support for host-side USB ( CONFIG_USB )
>   <*> OHCI HCD support( CONFIG_USB_OHCI_HCD )
>   <*> USB Mass Storage Support( CONFIG_USB_STORAGE )
>=20
> SCSI device support --->( CONFIG_SCSI )
>   <*> SCSI disk support( CONFIG_BLK_DEV_SD )
>=20
> "File systems" --->
> "DOS/FAT/NT Filesystems" --->( CONFIG_FAT_FS)
>   <*> MSDOS fs support( CONFIG_MSDOS_FS )
>   <*> VFAT ( Windows-95 fs support)( CONFIG_VFAT_FS )
>=20
> "File systems" --->
> "Partition Types"  --->
>   [*] Advanced partition selection( CONFIG_PARTITION_ADVANCED )
>   [*] PC BIOS (MSDOS partition table)( CONFIG_MSDOS_PARTITION )
>=20
> "File systems" --->
> "Native Language Support" --->( CONFIG_NLS )
>   <*> Code Page 437 (United States...)( CONFIG_NLS_CODEPAGE_437 )
>   <*> NLS ISO8859 (Latan 1...)( CONFIG_NLS_ISO8859_1 )
>=20
> As far as my understanding goes, irrespective of whether the
> device has been configured for USB Mass storage or not, if the
> device is recognized, USB interrupts should occur, which is not
> happening.
>=20
> cat /proc/interrupt returns:
>=20
> CPU0
>   19:          0   DMA
>   20:          0   DMA
>   21:          0   DMA
>   22:          0   DMA
>   23:          0   DMA
>   24:          0   DMA
>   25:          0   LCD DMA
>   31:          3   omap-lcdc
>   33:          1   omap-keypad
>   36:          0   i2c_omap
>   38:          0   ohci_hcd:usb1
>   46:        548   serial
>   54:     158278   32KHz timer
>   85:          0   DMA
>   86:          0   DMA
>   87:          0   DMA
>   88:          0   DMA
>   89:          0   DMA
>   90:          0   DMA
>   91:          0   DMA
>   92:          0   DMA
>   93:          0   DMA
>   94:          0   DMA
> 160:       1399   eth0
> 197:          0   serial wakeup
> 222:          0   omap_cf
>=20
>=20
> Has anyone successfully got the USB Master interface on the OSK5912
> to work fine?
>=20
> Thanks in advance,
>=20
> Regards,
> Kanagesh

Hello,

My apologies, the kernel that I am using right now is linux-2.6.13-omap1 (a=
nd not
linux-2.4.16 as mentioned).=20=20

Further, I found from the list archives that there was a USB clock malfunct=
ion
in kernels 2.6.12 - 2.6.14.  I backported my work to 2.6.11-omap1 and I sti=
ll
see the same problem.  However, when the system comes up, I see some stray =
USB
interrupts (even though there is no device plugged in).

When I plug in a memory disk or any other USB device, there're no USB inter=
rupts.

Can anyone point me to what am doing wrong?

Thanks in advance
regards,
Kanagesh



--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
