From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 11/14] ARM: omap2: use clkdev_create()
Date: Fri, 03 Apr 2015 18:13:19 +0100
Message-ID: <E1Ye59j-0001Bd-0T@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Rather than open coding the clkdev allocation, initialisation and
addition, use the clkdev_create() helper.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 85e0b0c06718..b64d717bfab6 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -232,14 +232,12 @@ void omap2xxx_clkt_vps_init(void)
 	struct clk_hw_omap *hw = NULL;
 	struct clk *clk;
 	const char *parent_name = "mpu_ck";
-	struct clk_lookup *lookup = NULL;
 
 	omap2xxx_clkt_vps_late_init();
 	omap2xxx_clkt_vps_check_bootloader_rates();
 
 	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
-	lookup = kzalloc(sizeof(*lookup), GFP_KERNEL);
-	if (!hw || !lookup)
+	if (!hw)
 		goto cleanup;
 	init.name = "virt_prcm_set";
 	init.ops = &virt_prcm_set_ops;
@@ -249,15 +247,9 @@ void omap2xxx_clkt_vps_init(void)
 	hw->hw.init = &init;
 
 	clk = clk_register(NULL, &hw->hw);
-
-	lookup->dev_id = NULL;
-	lookup->con_id = "cpufreq_ck";
-	lookup->clk = clk;
-
-	clkdev_add(lookup);
+	clkdev_create(clk, "cpufreq_ck", NULL);
 	return;
 cleanup:
 	kfree(hw);
-	kfree(lookup);
 }
 #endif
-- 
1.8.3.1
