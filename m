From: <shyamal.sadanshio@wipro.com>
Subject: USB OTG build problem
Date: Sun, 15 Jan 2006 20:11:31 +0530
Message-ID: <A532B29682CD634080ABC65F9A1BFB4202546015@BLR-EC-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi All,

I am facing USB module build issue with 2.6.15 kernel as below:

drivers/built-in.o(.text+0x3f744): In function `omap_otg_irq':
drivers/i2c/chips/isp1301_omap.c:851: undefined reference to
`usb_bus_start_enum
make: *** [.tmp_vmlinux1] Error 1

My USB module config is as below:
=20
# USB support

CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dm

CONFIG_USB_SUSPEND=3Dy
CONFIG_USB_OTG=3Dy
CONFIG_USB_OTG_WHITELIST=3Dy

CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy

CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_USBAT=3Dy
=20
CONFIG_USB_MON=3Dy
=20
CONFIG_USB_GADGET=3DyCONFIG_USB_GADGET_OMAP=3Dy
CONFIG_USB_OMAP=3Dy
CONFIG_USB_ZERO=3Dm
CONFIG_USB_ETH=3Dm
CONFIG_USB_GADGETFS=3Dm
CONFIG_USB_G_SERIAL=3Dm

CONFIG_USB_GADGET_SELECTED=3Dy
************************************************************************
****************************************
=20
I checked the old archived mails and found that this issue was present
in earlier patches (2.6.8, 2.6.10).
Is there any patch available with the problem fixed?
=20
Thanks and Regards,
Shyamal
=20
=20
=20
