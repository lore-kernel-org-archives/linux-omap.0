From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] OMAP: USB: Fix compile warnings in board-2430sdp-usb.c
Date: Fri, 23 Nov 2007 21:10:34 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804E3D369@dbde01.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Fixes warnings during compilation with CONFIG_USB_GADGET_MUSB_HDRC=3Dy

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp-usb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6-NOV23/arch/arm/mach-omap2/board-2430sdp-usb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-2.6-NOV23.orig/arch/arm/mach-omap2/board-2430sdp-usb.c	=
2007-11-23 11:36:45
+++ linux-omap-2.6-NOV23/arch/arm/mach-omap2/board-2430sdp-usb.c	=
2007-11-23 11:41:41
@@ -37,9 +37,9 @@
 static struct musb_hdrc_platform_data musb_plat =3D {
 #ifdef CONFIG_USB_MUSB_OTG
 	.mode		=3D MUSB_OTG,
-#elif CONFIG_USB_MUSB_HDRC_HCD
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
 	.mode		=3D MUSB_HOST,
-#elif CONFIG_USB_GADGET_MUSB_HDRC
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		=3D MUSB_PERIPHERAL,
 #endif
 	.multipoint	=3D 1,
