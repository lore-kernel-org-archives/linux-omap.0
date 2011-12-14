From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 5/7] omap: panda: use clk_prepare in ehci init
Date: Tue, 13 Dec 2011 20:11:56 -0800
Message-ID: <1323835918-2371-6-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36728 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756682Ab1LNEQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:16:13 -0500
Received: by mail-gy0-f174.google.com with SMTP id z12so370561ghb.5
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:16:12 -0800 (PST)
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a8c2c42..3864d31 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -122,6 +122,7 @@ static void __init omap4_ehci_init(void)
 		return;
 	}
 	clk_set_rate(phy_ref_clk, 19200000);
+	clk_prepare(phy_ref_clk);
 	clk_enable(phy_ref_clk);
 
 	/* disable the power to the usb hub prior to init and reset phy+hub */
-- 
1.7.5.4

