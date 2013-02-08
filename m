From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP2+: Remove duplicate omap4430_init_late() declaration
Date: Fri, 8 Feb 2013 20:41:45 +0530
Message-ID: <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946062Ab3BHPLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:11:07 -0500
In-Reply-To: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>

Commit bbd707ac {ARM: omap2: use machine specific hook for late init}
accidentally added two declarations for omap4430_init_late().

Remove the duplicate declaration.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 948bcaa..e0f9ea7 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -108,7 +108,6 @@ void omap35xx_init_late(void);
 void omap3630_init_late(void);
 void am35xx_init_late(void);
 void ti81xx_init_late(void);
-void omap4430_init_late(void);
 int omap2_common_pm_late_init(void);
 
 #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
-- 
1.7.9.5

