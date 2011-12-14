From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 6/7] omap: dss: use clk_prepare in dss reset
Date: Tue, 13 Dec 2011 20:11:57 -0800
Message-ID: <1323835918-2371-7-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53963 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756682Ab1LNEQR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:16:17 -0500
Received: by ghrr14 with SMTP id r14so381686ghr.26
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:16:16 -0800 (PST)
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/display.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index dce9905..21f8fcc 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -297,8 +297,10 @@ int omap_dss_reset(struct omap_hwmod *oh)
 	}
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
-		if (oc->_clk)
+		if (oc->_clk) {
+			clk_prepare(oc->_clk);
 			clk_enable(oc->_clk);
+		}
 
 	dispc_disable_outputs();
 
-- 
1.7.5.4

