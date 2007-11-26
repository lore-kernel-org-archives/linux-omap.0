From: "Carl Benson" <Carl.Benson@combra.se>
Subject: RE: 3430SDP USB driver
Date: Mon, 26 Nov 2007 12:07:56 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88DFE@zeus.Combra.se>
References: <5DF83221BE20114E9C331F665ACBC08003ED733D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi. Thanks for your reply. My TI contact tells me not to enable driver =
support for TUSB6010 but if I do that I get:
  CC [M]  drivers/usb/musb/musb_host.o
drivers/usb/musb/musb_host.c: In function 'musb_urb_dequeue':
drivers/usb/musb/musb_host.c:1956: warning: unused variable 'tmp'
  LD [M]  drivers/usb/musb/musb_hdrc.o
  Building modules, stage 2.
  MODPOST 67 modules
ERROR: "musb_platform_init" [drivers/usb/musb/musb_hdrc.ko] undefined!
ERROR: "musb_platform_disable" [drivers/usb/musb/musb_hdrc.ko] =
undefined!
ERROR: "musb_platform_exit" [drivers/usb/musb/musb_hdrc.ko] undefined!
ERROR: "musb_platform_enable" [drivers/usb/musb/musb_hdrc.ko] undefined!
ERROR: "dma_controller_destroy" [drivers/usb/musb/musb_hdrc.ko] =
undefined!
ERROR: "dma_controller_create" [drivers/usb/musb/musb_hdrc.ko] =
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

With support the driver is compiled but not loadable:
# modprobe musb_hdrc
<6>usbcore: registered new interface driver usbfs
usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
usbcore: registered new device driver usb
<6>musb_hdrc: version 6.0, tusb-omap-dma, host, debug=3D0
musb_hdrc: version 6.0, tusb-omap-dma, host, debug=3D0
insmod: cannot insert =
'/lib/modules/2.6.23-omap1/kernel/drivers/usb/musb/musb_hdrc.ko': No =
such device (-1): No such device
modprobe: failed to load module musb_hdrc

What do I need to enable? Inventra Dual Role controller of course, and =
then what? USB Host/Gadget/OTG? With OTG I get

# modprobe musb_hdrc
<4>usbcore: Unknown symbol refrigerator
usbcore: Unknown symbol refrigerator
insmod: cannot insert =
'/lib/modules/2.6.23-omap1/kernel/drivers/usb/core/usbcore.ko': Unknown =
symbol in module (-1): No such file or directory
<4>musb_hdrc: Unknown symbol usb_hcd_resume_root_hub
musb_hdrc: Unknown symbol usb_hcd_resume_root_hub
<4>musb_hdrc: Unknown symbol usb_hcd_unlink_urb_from_ep
musb_hdrc: Unknown symbol usb_hcd_unlink_urb_from_ep
<4>musb_hdrc: Unknown symbol usb_disabled
musb_hdrc: Unknown symbol usb_disabled
<4>musb_hdrc: Unknown symbol usb_hcd_check_unlink_urb
musb_hdrc: Unknown symbol usb_hcd_check_unlink_urb
<4>musb_hdrc: Unknown symbol usb_hcd_link_urb_to_ep
musb_hdrc: Unknown symbol usb_hcd_link_urb_to_ep
<4>musb_hdrc: Unknown symbol otg_set_transceiver
musb_hdrc: Unknown symbol otg_set_transceiver
<4>musb_hdrc: Unknown symbol usb_put_hcd
musb_hdrc: Unknown symbol usb_put_hcd
<4>musb_hdrc: Unknown symbol usb_hcd_giveback_urb
musb_hdrc: Unknown symbol usb_hcd_giveback_urb
<4>musb_hdrc: Unknown symbol usb_hcd_poll_rh_status
musb_hdrc: Unknown symbol usb_hcd_poll_rh_status
<4>musb_hdrc: Unknown symbol usb_create_hcd
musb_hdrc: Unknown symbol usb_create_hcd
<4>musb_hdrc: Unknown symbol usb_remove_hcd
musb_hdrc: Unknown symbol usb_remove_hcd
<4>musb_hdrc: Unknown symbol usb_add_hcd
musb_hdrc: Unknown symbol usb_add_hcd
insmod: cannot insert =
'/lib/modules/2.6.23-omap1/kernel/drivers/usb/musb/musb_hdrc.ko': =
Unknown symbol in module (-1): No such file or directory
modprobe: failed to load module musb_hdrc

>-----Original Message-----
>From: =
linux-omap-open-source-bounces+vikram.pandita=3Dti.com@linux.omap.com =
[mailto:linux-omap-open-
>source-bounces+vikram.pandita=3Dti.com@linux.omap.com] On Behalf Of =
Carl Benson
>Sent: Monday, November 26, 2007 2:09 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: 3430SDP USB driver
>
>Hi. Unable to compile support for USB on 3430SDP ES1.0. Seems like the =
struct urb has changed
>somewhere between 2.6.22 and 2.6.23 and that the driver is lagging =
behind?


Please check the patch from Tony on 31/10/2007 Subject: Re: [PATCH] =
initial musb urb fixes to make it work again

Attached to the mail as well for your reference.


>
>regards,
>/Carl
>
>  CC [M]  drivers/usb/musb/musb_host.o
>drivers/usb/musb/musb_host.c: In function '__musb_giveback':
>drivers/usb/musb/musb_host.c:277: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c:281: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c:307: error: too few arguments to function =
'usb_hcd_giveback_urb'
>drivers/usb/musb/musb_host.c: In function 'musb_urb_dequeue':
>drivers/usb/musb/musb_host.c:1970: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c:1983: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c: In function 'musb_h_disable':
>drivers/usb/musb/musb_host.c:2085: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c:2088: error: 'struct urb' has no member =
named 'lock'
>drivers/usb/musb/musb_host.c: At top level:
>drivers/usb/musb/musb_host.c:2163: warning: initialization from =
incompatible pointer type
>drivers/usb/musb/musb_host.c:2164: warning: initialization from =
incompatible pointer type
>make[2]: *** [drivers/usb/musb/musb_host.o] Error 1
>make[1]: *** [drivers/usb/musb] Error 2
>make: *** [drivers] Error 2
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
