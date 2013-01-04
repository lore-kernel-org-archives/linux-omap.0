From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2+: powerdomain updates after the
 functional power state conversion
Date: Fri, 4 Jan 2013 16:26:34 +0200
Message-ID: <1357309594.2221.112.camel@sokoban>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631Ab3ADO0j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 09:26:39 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

Tested this whole set on omap3beagle and omap4panda. The only regression
I noticed was that cpu0 debug counters do not increment on omap4 after
this set. The patch at the end fixes this problem. Other than that, you
can add acked-by tag from me if you want, I went the code through
quickly and don't have any comments to it.

-Tero

From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 3 Jan 2013 20:07:27 +0200
Subject: [PATCH] ARM: OMAP4: PM: fix cpu0 statistics update during idle

Cpu0 PM counters do not update, as the  cpu0 fpwrst is set to ON before
calling pwrdm_post_transition. The optimized code checks whether the
fpwrst is ON, and skips any further checks if this is the case. Fixed
by re-ordering the code within omap4_mpuss_enter_lowpower function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 9acd52a..1bdd59e 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -269,10 +269,16 @@ int omap4_mpuss_enter_lowpower(unsigned int cpu,
u8 fpwrst)
 	 * domain transition
 	 */
 	wakeup_cpu = smp_processor_id();
-	WARN_ON(pwrdm_set_next_fpwrst(pm_info->pwrdm, PWRDM_FUNC_PWRST_ON));
 
+	/*
+	 * Due to optimizations to the code, pwrdm_post_transition
+	 * must be called prior to resetting cpu0 pwrst to ON,
+	 * otherwise cpu0 powerstate statistics don't update properly
+	 */
 	pwrdm_post_transition(NULL);
 
+	WARN_ON(pwrdm_set_next_fpwrst(pm_info->pwrdm, PWRDM_FUNC_PWRST_ON));
+
 	return 0;
 }
 
-- 
1.7.4.1


