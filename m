From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH v2 3/5] ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
Date: Wed, 9 Jan 2013 16:03:09 +0100
Message-ID: <1357743792-13917-4-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757987Ab3AIPD3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 10:03:29 -0500
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

=46rom: Paul Walmsley <paul@pwsan.com>

Enable the AESS auto-gating control bit during AESS hwmod setup.  This
fixes the following boot warning on OMAP4:

omap_hwmod: aess: _wait_target_disable failed

Without this patch, the AESS IP block does not indicate to the PRCM
that it is idle after it is reset.  This prevents some types of SoC
power management until something sets the auto-gating control bit.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h           |    6 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_reset.c     |   52 ++++++++++++++++++++=
++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 947cafe..d88788f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -8,7 +8,7 @@ obj-y :=3D id.o io.o control.o mux.o devices.o fb.o ser=
ial.o gpmc.o timer.o pm.o \
 	 omap_device.o sram.o
=20
 omap-2-3-common				=3D irq.o
-hwmod-common				=3D omap_hwmod.o \
+hwmod-common				=3D omap_hwmod.o omap_hwmod_reset.o \
 					  omap_hwmod_common_data.o
 clock-common				=3D clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/oma=
p_hwmod.h
index 41066b4..6ec73cb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -673,6 +673,12 @@ extern void __init omap_hwmod_init(void);
 const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
=20
 /*
+ *
+ */
+
+extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
+
+/*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
  */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 584acf9..13e397f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -322,6 +322,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_a=
ess_sysc =3D {
 static struct omap_hwmod_class omap44xx_aess_hwmod_class =3D {
 	.name	=3D "aess",
 	.sysc	=3D &omap44xx_aess_sysc,
+	.enable_preprogram =3D omap_hwmod_aess_preprogram,
 };
=20
 /* aess */
diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-oma=
p2/omap_hwmod_reset.c
new file mode 100644
index 0000000..bba43fa
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -0,0 +1,52 @@
+/*
+ * OMAP IP block custom reset and preprogramming stubs
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * A small number of IP blocks need custom reset and preprogramming
+ * functions.  The stubs in this file provide a standard way for the
+ * hwmod code to call these functions, which are to be located under
+ * drivers/.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+#include <linux/kernel.h>
+
+#include <sound/aess.h>
+
+#include "omap_hwmod.h"
+
+/**
+ * omap_hwmod_aess_preprogram - enable AESS internal autogating
+ * @oh: struct omap_hwmod *
+ *
+ * The AESS will not IdleAck to the PRCM until its internal autogating
+ * is enabled.  Since internal autogating is disabled by default after
+ * AESS reset, we must enable autogating after the hwmod code resets
+ * the AESS.  Returns 0.
+ */
+int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
+{
+	void __iomem *va;
+
+	va =3D omap_hwmod_get_mpu_rt_va(oh);
+	if (!va)
+		return -EINVAL;
+
+	aess_enable_autogating(va);
+
+	return 0;
+}
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
