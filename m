From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function calls
Date: Thu, 10 Jan 2013 14:53:29 -0600
Message-ID: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3AJUxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 15:53:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

During the migration to the common clock framework, calls to the
functions omap2xxx_clkt_vps_late_init() and
omap2xxx_clkt_vps_check_bootloader_rates() were not preserved for
OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
"curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
following error message to be displayed because the appropriate MPU
clock frequency (derived from sys_ck_rate) cannot be found.

"Could not set MPU rate to 4294MHz"

Fix this by adding back calls to omap2xxx_clkt_vps_late_init() and
omap2xxx_clkt_vps_check_bootloader_rates() in the OMAP2420 and OMAP2430
clock initialisation code.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---

Tested on OMAP2420 H4 board only.

 arch/arm/mach-omap2/cclock2420_data.c |    5 +++++
 arch/arm/mach-omap2/cclock2430_data.c |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 7e5febe..0dadfb9 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -1935,8 +1935,13 @@ int __init omap2420_clk_init(void)
 			omap2_init_clk_hw_omap_clocks(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	omap2_clk_disable_autoidle_all();
 
+	/* XXX Can this be done from the virt_prcm_set clk init function? */
+	omap2xxx_clkt_vps_check_bootloader_rates();
+
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index eda079b..722ff84 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -2050,8 +2050,13 @@ int __init omap2430_clk_init(void)
 			omap2_init_clk_hw_omap_clocks(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	omap2_clk_disable_autoidle_all();
 
+	/* XXX Can this be done from the virt_prcm_set clk init function? */
+	omap2xxx_clkt_vps_check_bootloader_rates();
+
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
-- 
1.7.10.4

