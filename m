From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 34/45] ARM: OMAP2+: timer: fix boot crash with DT only boot and DT clocks
Date: Thu, 29 Aug 2013 16:16:26 +0300
Message-ID: <1377782197-10611-35-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48086 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899Ab3H2NSx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:53 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Timer failed to init properly with DT clock data, as it still tried
to use clock info from hwmod. Changed init order slightly so that
timer hwmod is initialized earlier, which also makes sure the
timer clock is initialized and can be referenced from the driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/timer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1e77f11..bf8467c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -276,8 +276,13 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!timer->io_base)
 		return -ENXIO;
 
+	omap_hwmod_setup_one(oh_name);
+
 	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+	if (oh->_clk)
+		timer->fclk = oh->_clk;
+	else
+		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
 		return PTR_ERR(timer->fclk);
 
@@ -297,7 +302,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	clk_put(src);
 
-	omap_hwmod_setup_one(oh_name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
-- 
1.7.9.5

