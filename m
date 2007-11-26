From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: 3430SDP USB driver
Date: Mon, 26 Nov 2007 14:24:33 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003ED7342@dbde01.ent.ti.com>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carl Benson <Carl.Benson@combra.se>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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

3430 Support for MUSB has not been added to GIT yet though 2430 works =
fine.
Patches will be sent soon to get MUSB working for 3430.

>somewhere between 2.6.22 and 2.6.23 and that the driver is lagging =
behind?
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
