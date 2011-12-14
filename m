From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 7/7] HACK: comment WARN_ON in _clkdm_clk_hwmod_disable
Date: Tue, 13 Dec 2011 20:11:58 -0800
Message-ID: <1323835918-2371-8-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53299 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756682Ab1LNEQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:16:20 -0500
Received: by mail-yw0-f54.google.com with SMTP id q46so1055649yhf.41
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:16:19 -0800 (PST)
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ad07689..825248b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -941,7 +941,7 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 		return -EINVAL;
 
 	if (atomic_read(&clkdm->usecount) == 0) {
-		WARN_ON(1); /* underflow */
+		//WARN_ON(1); /* underflow */
 		return -ERANGE;
 	}
 
-- 
1.7.5.4

