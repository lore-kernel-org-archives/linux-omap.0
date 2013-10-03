From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] ARM: OMAP: Move DT wake-up event handling over to use
 pinctrl-single-omap
Date: Wed, 02 Oct 2013 22:42:29 -0700
Message-ID: <20131003054229.8941.5056.stgit@localhost>
References: <20131003054104.8941.88857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19074 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757347Ab3JCFmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 01:42:32 -0400
In-Reply-To: <20131003054104.8941.88857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Now pinctrl-single-omap can handle the wake-up events for us now
as long as the events are configured in the .dts files.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Prakash Manjunathappa <prakash.pm@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi       |    4 ++++
 arch/arm/boot/dts/omap4.dtsi       |    4 ++++
 arch/arm/mach-omap2/mux.c          |    8 ++++++--
 arch/arm/mach-omap2/pdata-quirks.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h      |    8 +++++++-
 arch/arm/mach-omap2/prm44xx_54xx.h |    8 +++++++-
 arch/arm/mach-omap2/prm_common.c   |   11 +++++++++++
 7 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b41bd57..6e928e8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -107,6 +107,8 @@
 			reg = <0x48002030 0x05cc>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0xff1f>;
 		};
@@ -116,6 +118,8 @@
 			reg = <0x48002a00 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0xff1f>;
 		};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..0415d5e 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -114,6 +114,8 @@
 			reg = <0x4a100040 0x0196>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
@@ -122,6 +124,8 @@
 			reg = <0x4a31e040 0x0038>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0x7fff>;
 		};
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index f82cf87..48094b58 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -811,6 +811,12 @@ int __init omap_mux_late_init(void)
 		}
 	}
 
+	omap_mux_dbg_init();
+
+	/* see pinctrl-single-omap for the wake-up interrupt handling */
+	if (of_have_populated_dt())
+		return 0;
+
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
 			"hwmod_io", omap_mux_late_init);
@@ -818,8 +824,6 @@ int __init omap_mux_late_init(void)
 	if (ret)
 		pr_warning("mux: Failed to setup hwmod io irq %d\n", ret);
 
-	omap_mux_dbg_init();
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c739631..1f047f4 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -14,6 +14,8 @@
 #include <linux/of_platform.h>
 #include <linux/wl12xx.h>
 
+#include <linux/platform_data/pinctrl-single.h>
+
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
@@ -100,7 +102,23 @@ static void __init omap5_uevm_legacy_init(void)
 }
 #endif
 
+static struct pcs_pdata pcs_pdata;
+
+void omap_pcs_legacy_init(int irq, void (*rearm)(void))
+{
+	pcs_pdata.irq = irq;
+	pcs_pdata.rearm = rearm;
+}
+
 struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+#ifdef CONFIG_ARCH_OMAP3
+	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
+#endif
+#ifdef CONFIG_ARCH_OMAP4
+	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
+#endif
 	{ /* sentinel */ },
 };
 
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 277f717..f8eb833 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -144,7 +144,13 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-extern void omap3xxx_prm_reconfigure_io_chain(void);
+#ifdef CONFIG_ARCH_OMAP3
+void omap3xxx_prm_reconfigure_io_chain(void);
+#else
+static inline void omap3xxx_prm_reconfigure_io_chain(void)
+{
+}
+#endif
 
 /* PRM interrupt-related functions */
 extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 7cd22ab..a085d9c 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -42,7 +42,13 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-extern void omap44xx_prm_reconfigure_io_chain(void);
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+void omap44xx_prm_reconfigure_io_chain(void);
+#else
+static inline void omap44xx_prm_reconfigure_io_chain(void)
+{
+}
+#endif
 
 /* PRM interrupt-related functions */
 extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 228b850..a2e1174 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
+#include "soc.h"
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
@@ -322,6 +323,16 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 		prcm_irq_chips[i] = gc;
 	}
 
+	if (of_have_populated_dt()) {
+		int irq = omap_prcm_event_to_irq("io");
+		if (cpu_is_omap34xx())
+			omap_pcs_legacy_init(irq,
+				omap3xxx_prm_reconfigure_io_chain);
+		else
+			omap_pcs_legacy_init(irq,
+				omap44xx_prm_reconfigure_io_chain);
+	}
+
 	return 0;
 
 err:

