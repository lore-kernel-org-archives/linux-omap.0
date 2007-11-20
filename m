From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: MUSB: MUSB fix to work as Module for 24xx/Davinci
Date: Tue, 20 Nov 2007 15:04:26 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003E7FAE3@dbde01.ent.ti.com>
References: <5DF83221BE20114E9C331F665ACBC08003E7F771@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003E7F771@dbde01.ent.ti.com>
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

From: Vikram Pandita <vikram.pandita@ti.com>

Fix to get MUSB working as Module for 2430 and Davinci platform

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---

Index: linux-omap/drivers/usb/musb/musb_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/drivers/usb/musb/musb_core.c	2007-11-20 =
14:24:03.000000000 +0530
+++ linux-omap/drivers/usb/musb/musb_core.c	2007-11-20 =
14:26:22.000000000 +0530
@@ -1336,7 +1336,7 @@
=20
 	/* log core options (read using indexed model) */
 	musb_ep_select(mbase, 0);
-	reg =3D musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
+	reg =3D musb_readb(mbase, MUSB_EP_OFFSET(0, MUSB_CONFIGDATA));
=20
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
 	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
