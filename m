From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: MUSB: MUSB gadget fix
Date: Mon, 19 Nov 2007 18:33:23 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003E7F771@dbde01.ent.ti.com>
References: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
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

From: Vikram Pandita <vikram.pandita@ti.com>

This fix gets MUSB Gadget Isochronous IN transfers working for File =
Storage Gadget

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---

Index: linux-omap/drivers/usb/musb/musb_gadget.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/drivers/usb/musb/musb_gadget.c	2007-11-19 =
17:49:41.000000000 +0530
+++ linux-omap/drivers/usb/musb/musb_gadget.c	2007-11-19 =
17:50:31.000000000 +0530
@@ -499,7 +499,7 @@
=20
 					DBG(4, "sending zero pkt\n");
 					musb_writew(epio, MUSB_TXCSR,
-							MUSB_TXCSR_MODE
+							csr | MUSB_TXCSR_MODE
 							| MUSB_TXCSR_TXPKTRDY);
 					request->zero =3D 0;
 				}
