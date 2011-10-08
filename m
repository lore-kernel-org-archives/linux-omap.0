From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap2+: stub out omap*_volt_data
Date: Sat, 08 Oct 2011 17:23:24 +0200
Message-ID: <1397689.kebELtC4N3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab1JHPXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Oct 2011 11:23:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>

When CONFIG_PM_OPP is not set, the definitions for these variables
are not available, so we should conditionally define them to
NULL.

arch/arm/mach-omap2/built-in.o: In function `omap3xxx_voltagedomains_init':
voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddmpu_volt_data'
voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddmpu_volt_data'
voltagedomains3xxx_data.c:100: undefined reference to `omap36xx_vddcore_volt_data'
voltagedomains3xxx_data.c:100: undefined reference to `omap34xx_vddcore_volt_data'
arch/arm/mach-omap2/built-in.o: In function `omap44xx_voltagedomains_init':
voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_mpu_volt_data'
voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_iva_volt_data'
voltagedomains44xx_data.c:111: undefined reference to `omap44xx_vdd_core_volt_data'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I got this build error only now after pulling in the latest omap series, but
I cannot tell what caused it. It's also not clear to me if this is the correct
solution. Please ack or provide a better fix.

 arch/arm/mach-omap2/omap_opp_data.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..fdbf96b 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -83,7 +83,7 @@ struct omap_opp_def {
 extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 		u32 opp_def_size);
 
-
+#ifdef CONFIG_PM_OPP
 extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap34xx_vddcore_volt_data[];
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
@@ -93,4 +93,15 @@ extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
 
+#else
+#define omap34xx_vddmpu_volt_data	NULL
+#define omap34xx_vddcore_volt_data	NULL
+#define omap36xx_vddmpu_volt_data	NULL
+#define omap36xx_vddcore_volt_data	NULL
+
+#define omap44xx_vdd_mpu_volt_data	NULL
+#define omap44xx_vdd_iva_volt_data	NULL
+#define omap44xx_vdd_core_volt_data	NULL
+#endif
+
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
-- 
1.7.5.4


