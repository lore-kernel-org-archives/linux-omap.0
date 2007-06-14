From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 11 / 12] OMAP34xx header file
Date: Thu, 14 Jun 2007 00:03:23 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E609A@dlee13.ent.ti.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

OMAP 34xx header file

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 include/asm-arm/arch-omap/omap34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/include/asm-arm/arch-omap/omap34xx.h =
val_3430_GIT/include/asm-arm/arch-omap/omap34xx.h
--- linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-05-25 =
15:52:27.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/omap34xx.h	2007-06-13 =
17:16:56.000000000 -0500
@@ -1,3 +1,26 @@
+/*
+ * include/asm-arm/arch-omap/omap34xx.h
+ *
+ * This file contains the processor specific definitions of the TI =
OMAP34XX.
+ *
+ * Copyright (C) 2007 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
+ */
+
 #ifndef __ASM_ARCH_OMAP34XX_H
 #define __ASM_ARCH_OMAP34XX_H
=20
@@ -6,6 +29,17 @@
  * specific headers.
  */
=20
+#define L4_34XX_BASE		0x48000000
+#define L4_OMAP_BASE		L4_34XX_BASE
+#define L4_WK_34XX_BASE	 0x48300000
+#define L4_WK_OMAP_BASE	 L4_WK_OMAP_BASE
+#define L4_PER_34XX_BASE	0x49000000
+#define L4_PER_OMAP_BASE	L4_PER_34XX_BASE
+#define L4_34XX_EMU_BASE	0x54000000
+#define L4_EMU_BASE		 L4_34XX_EMU_BASE
+#define L3_34XX_BASE		0x68000000
+#define L3_OMAP_BASE		L3_34XX_BASE
+
 #define OMAP3430_32KSYNCT_BASE	0x48320000
 #define OMAP3430_CM_BASE	0x48004800
 #define OMAP3430_PRM_BASE	0x48306800
@@ -22,23 +56,21 @@
=20
 #if defined(CONFIG_ARCH_OMAP3430)
=20
-#define OMAP2_32KSYNCT_BASE	OMAP3430_32KSYNCT_BASE
-#define OMAP2_CM_BASE		OMAP3430_CM_BASE
-#define OMAP2_PRM_BASE		OMAP3430_PRM_BASE
-#define OMAP2_SDRC_BASE		OMAP343X_SDRC_BASE
-#define OMAP2_SMS_BASE		OMAP343X_SMS_BASE
-#define OMAP2_L4_BASE		L4_34XX_BASE
-#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP2_CTRL_BASE		OMAP3430_CTRL_BASE
+#define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
+#define OMAP2_CM_BASE			OMAP3430_CM_BASE
+#define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
+#define OMAP2_SDRC_BASE			OMAP343X_SDRC_BASE
+#define OMAP2_SMS_BASE			OMAP343X_SMS_BASE
+#define OMAP2_L4_BASE			L4_34XX_BASE
+#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
+#define OMAP24XX_CONTROL_DEVCONF	(L4_34XX_BASE + 0x274)
=20
 #endif
=20
-
 #define OMAP34XX_DSP_BASE	0x58000000
 #define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
 #define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
 #define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
-
-
 #endif /* __ASM_ARCH_OMAP34XX_H */
