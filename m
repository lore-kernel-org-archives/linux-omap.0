From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
Date: Wed,  5 Jan 2011 16:27:00 +0530
Message-ID: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40945 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab1AEK5S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 05:57:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

struct clockdomain member clktrctrl_mask is available for only for OMAP2
and OMAP3 architectures. Technially it is also used only for these archs
but this breaks the build with custom OMAP4 configuration.

 CC      arch/arm/mach-omap2/clockdomain.o
arch/arm/mach-omap2/clockdomain.c: In function '_enable_hwsup':
arch/arm/mach-omap2/clockdomain.c:251: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:254: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function '_disable_hwsup':
arch/arm/mach-omap2/clockdomain.c:277: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:280: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_sleep':
arch/arm/mach-omap2/clockdomain.c:744: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_wakeup':
arch/arm/mach-omap2/clockdomain.c:789: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_clk_enable':
arch/arm/mach-omap2/clockdomain.c:922: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:926: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_clk_disable':
arch/arm/mach-omap2/clockdomain.c:994: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:998: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Fix the build break by dropping the #ifdef as suggested by Paul Walmsley

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index de3faa2..9b459c2 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -103,9 +103,7 @@ struct clockdomain {
 		const char *name;
 		struct powerdomain *ptr;
 	} pwrdm;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	const u16 clktrctrl_mask;
-#endif
 	const u8 flags;
 	const u8 dep_bit;
 	const u8 prcm_partition;
-- 
1.6.0.4

