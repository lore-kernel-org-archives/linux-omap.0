From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: [PATCH]omap:mux.c waring removal
Date: Wed, 5 May 2010 17:40:16 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3165175@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634Ab0EEMKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 08:10:25 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>


=46rom: Keshava Munegowda <a0393220@ti.com>

This patch removes the below warning=20
arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
The definition of variable mux_phys should be enclosed in the macro CON=
=46IG_ARCH_OMAP3=20

Signed-off-by: Keshava Munegowda <a0393220@ti.com>
Index: linux-2.6/arch/arm/mach-omap2/mux.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 05:28:47.000000=
000 +0530
+++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-05 05:29:02.000000000 +=
0530
@@ -49,7 +49,9 @@
 	struct list_head	node;
 };
=20
+#ifdef CONFIG_ARCH_OMAP3
 static unsigned long mux_phys;
+#endif
 static void __iomem *mux_base;
=20
 u16 omap_mux_read(u16 reg)

Regards,
Keshava Munegowda


=A0
=A0
=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
