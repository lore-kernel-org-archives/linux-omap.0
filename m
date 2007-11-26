From: "Carl Benson" <Carl.Benson@combra.se>
Subject: 3430SDP USB driver
Date: Mon, 26 Nov 2007 09:38:35 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFC@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi. Unable to compile support for USB on 3430SDP ES1.0. Seems like the =
struct urb has changed somewhere between 2.6.22 and 2.6.23 and that the =
driver is lagging behind?

regards,
/Carl

  CC [M]  drivers/usb/musb/musb_host.o
drivers/usb/musb/musb_host.c: In function '__musb_giveback':
drivers/usb/musb/musb_host.c:277: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c:281: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c:307: error: too few arguments to function =
'usb_hcd_giveback_urb'
drivers/usb/musb/musb_host.c: In function 'musb_urb_dequeue':
drivers/usb/musb/musb_host.c:1970: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c:1983: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c: In function 'musb_h_disable':
drivers/usb/musb/musb_host.c:2085: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c:2088: error: 'struct urb' has no member =
named 'lock'
drivers/usb/musb/musb_host.c: At top level:
drivers/usb/musb/musb_host.c:2163: warning: initialization from =
incompatible pointer type
drivers/usb/musb/musb_host.c:2164: warning: initialization from =
incompatible pointer type
make[2]: *** [drivers/usb/musb/musb_host.o] Error 1
make[1]: *** [drivers/usb/musb] Error 2
make: *** [drivers] Error 2
