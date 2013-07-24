From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCHv4 00/33] ARM: OMAP: clock conversion to DT
Date: Wed, 24 Jul 2013 17:16:52 +0300
Message-ID: <51EFE1D4.8090307@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000004030206050807050103"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48260 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab3GXORZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 10:17:25 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

--------------000004030206050807050103
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 07/23/2013 10:19 AM, Tero Kristo wrote:
> Hi,
> 
> Changes compared to previous version:
> 
> - Clock init files moved from mach-omap2/ to drivers/clk/omap/
> - AM33xx support added [patches 15-20]
> - OMAP3 support added [patches 21-29]
> - DRA7 APLL support added (thanks Keerthy) [patches 30-33]
> 
> Test branch on top of 3.11-rc1 available here:
> 
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.11-rc1-omap-dt-clks
> 
> Testing done:
> 
> - boot + suspend tested on OMAP3 beagle C4 (omap3530)
> - boot + suspend tested on OMAP4 panda ES (omap4460)
> - boot tested on beagle bone (am335x)
> 
> A boot test was also executed for DRA7 and OMAP5 on a separate branch
> (mainline does not have OMAP5 / DRA7 support so far.)

Thanks to your hints, I was able to get this to work with 3.11-rc1 on omap5 uevm
using the following 3 patches. Please include them in your series. Thanks.

cheers,
-roger

--------------000004030206050807050103
Content-Type: text/x-patch;
	name="0001-ARM-dts-OMAP5-Provide-clock-tree-data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ARM-dts-OMAP5-Provide-clock-tree-data.patch"

>From f7e38deadead5f584c9de4f2f19bb5ab50a2641d Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Wed, 24 Jul 2013 17:02:56 +0300
Subject: [PATCH 1/3] ARM: dts: OMAP5: Provide clock tree data

Include the clock tree data for OMAP5

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..bc31022 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -45,6 +45,13 @@
 		};
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap54xx-clocks.dtsi"
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ */
-- 
1.7.4.1


--------------000004030206050807050103
Content-Type: text/x-patch;
	name="0002-CLK-omap5-Call-clock-init-function-at-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-CLK-omap5-Call-clock-init-function-at-boot.patch"

>From 810920058782e4d51c0aab5694fc7cffc53e9758 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Wed, 24 Jul 2013 17:05:00 +0300
Subject: [PATCH 2/3] CLK: omap5: Call clock init function at boot

omap5xxx_clk_init() needs to be called at boot.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 include/linux/clk/omap.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f3b7876..7d42e26 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -653,6 +653,7 @@ void __init omap5_init_early(void)
 	omap54xx_clockdomains_init();
 	omap54xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_init = omap5xxx_clk_init;
 }
 #endif
 
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index 0d70cd1..4b82485 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -197,6 +197,8 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 
 void omap3_clk_lock_dpll5(void);
 
+int omap5xxx_clk_init(void);
+
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
-- 
1.7.4.1


--------------000004030206050807050103
Content-Type: text/x-patch;
	name="0003-CLK-omap5-Initialize-USB_DPLL-at-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0003-CLK-omap5-Initialize-USB_DPLL-at-boot.patch"

>From 8836bc00aea3c97206244c3f8a66e2726c835854 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Wed, 24 Jul 2013 16:30:55 +0300
Subject: [PATCH 3/3] CLK: omap5: Initialize USB_DPLL at boot

USB_DPLL must be initialized and locked at boot so that
USB modules can work.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/clk/omap/clk-54xx.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/omap/clk-54xx.c b/drivers/clk/omap/clk-54xx.c
index ade0481..a0b3c14 100644
--- a/drivers/clk/omap/clk-54xx.c
+++ b/drivers/clk/omap/clk-54xx.c
@@ -19,6 +19,12 @@
 
 #define OMAP5_DPLL_ABE_DEFFREQ				98304000
 
+/*
+ * OMAP543x TRM, section "3.6.3.9.5 DPLL_USB Preferred Settings"
+ * states it must be at 960MHz
+ */
+#define OMAP5_DPLL_USB_DEFFREQ				960000000
+
 static struct omap_dt_clk omap54xx_clks[] = {
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
 	DT_CLK("omap_timer.1", "sys_ck", "sys_clkin"),
@@ -37,7 +43,7 @@ static struct omap_dt_clk omap54xx_clks[] = {
 int __init omap5xxx_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
 
 	dt_omap_clk_init();
 
@@ -54,5 +60,10 @@ int __init omap5xxx_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
+	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
+	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+
 	return 0;
 }
-- 
1.7.4.1


--------------000004030206050807050103--
