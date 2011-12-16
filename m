From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 REPOST 3/5] omap4: Unconditionally require l2x0 L2 cache controller support
Date: Fri, 16 Dec 2011 16:35:30 +0000
Message-ID: <1324053332-6431-4-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54728 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab1LPQfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 11:35:46 -0500
Received: by faar15 with SMTP id r15so3090623faa.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:35:45 -0800 (PST)
In-Reply-To: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

If running in the Normal World on a TrustZone-enabled SoC, Linux
does not have complete control over the L2 cache controller
configuration.  The kernel cannot work reliably on such platforms
without the l2x0 cache support code built in.

This patch unconditionally enables l2x0 support for the OMAP4 SoCs.

Thanks to Rob Herring for this suggestion.  [1]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bb1b670..94e568a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -41,11 +41,11 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	default y
 	depends on ARCH_OMAP2PLUS
+	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
 	select LOCAL_TIMERS if SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
-- 
1.7.4.1

