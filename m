From: "Kanagesh R" <kanagesh@india.com>
Subject: RE: USB functionality on OMAP2430 SDP
Date: Tue, 3 Jul 2007 19:05:00 +0800
Message-ID: <20070703110500.A2C3043C4F@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> ----- Original Message -----
> From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
> To: "Kanagesh R" <kanagesh@india.com>, linux-omap-open-source@linux.omap.=
com
> Subject: RE: USB functionality on OMAP2430 SDP
> Date: Mon, 2 Jul 2007 21:08:35 -0500
>=20
>=20
> Hi Kanagesh,
>=20
> > May I know if anyone has tested any USB functionality or USB gadget
> > functionality on the OMAP2430 SDP board?  The kernels that I am using f=
or
> > testing the USB eth functionality has been downloaded from
> > http://linux.omap.com/pub/kernel/2430sdp/source/ (Linux-2.6.14-omap2-v2=
 and
> > Linux-2.6.14-omap2-v3).
> >
>=20
> We tested USB Ethernet gadget on ISP 1301 on SDP2430 V4.0 (on the=20
> same kernel drop from linux.omap.com), it worked properly, below=20
> are the commands that were executed.
>=20
>

Hello,

Thank you very much for the log, Khasim.=20=20

I configured the Linux kernel as per settings in 'omap_2430sdp_2430_defconf=
ig' file and found that the kernel was not using the OMAP USB Device Contro=
ller. ISP1301 was not enabled too.  I then configured the kernel for USB Ga=
dget functionality as follows, changing those settings.  I have turned off =
all USB Host functions.  My .config file specific to USB looks like:

# Miscellaneous I2C Chip support
#
CONFIG_ISP1301_OMAP=3Dm

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy

CONFIG_USB_OMAP24XX_FS_PORT0=3Dy

#
# USB Gadget Support
#
CONFIG_USB_GADGET=3Dy
CONFIG_USB_GADGET_DEBUG_FILES=3Dy
CONFIG_USB_GADGET_SELECTED=3Dy

CONFIG_USB_GADGET_OMAP=3Dy
CONFIG_USB_OMAP=3Dy

CONFIG_USB_ETH=3Dm
CONFIG_USB_ETH_RNDIS=3Dy

However, with these configurations, I am having problems loading module g_e=
ther.ko driver at run time.  While loading, it fails with the following err=
or:

[root@OMAP2430SDP /]#modprobe g_ether
FATAL: Error inserting g_ether (/lib/modules/2.6.14.7-arm1-omap2-V3/kernel/=
drivers/usb/gadget/g_ether.ko): No such device

I am able to load the ISP1301 driver but though g_ether.ko is present in th=
e specified path, it does not load.  Attempts to load the driver with insmo=
d also gives the same error.

Initially I was using insmod from busybox and I noticed that I was not able=
 to register any module with this kernel.  I have built module-init-tools (=
version 3.2) and am using it on the SDP to load the modules.=20=20

May I have the .config file for the kernel or the configurations for the US=
B and ISP1301 that you made to get the kernel working with USB Gadget on th=
e SDP?=20=20

Could you also tell me the positions of Switch 6 (HSUSB_nFS) and Switch 7 (=
HSVBUS_nFS) in Dip Switch S6 on the SDP?

Thanks again for your time.

Regards,
Kanagesh

=3D


--=20
_______________________________________________
Search for products and services at:=20
http://search.mail.com
