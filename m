From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] OMAP1 clock: fix section mismatch on clk_init
Date: Mon, 26 Apr 2010 01:04:22 -0600
Message-ID: <20100426070420.9743.33754.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52228 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0DZHHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:33 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

remove the section annotation from omap1_clk_disable_unused()
to kill the section mismatch warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c |    2 +-
 arch/arm/mach-omap1/clock.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index e0aec10..6bbb1b8 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -578,7 +578,7 @@ int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 
-void __init omap1_clk_disable_unused(struct clk *clk)
+void omap1_clk_disable_unused(struct clk *clk)
 {
 	__u32 regval32;
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index a4190af..75d0d7d 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -39,7 +39,7 @@ extern long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
 extern unsigned long omap1_watchdog_recalc(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
-extern void __init omap1_clk_disable_unused(struct clk *clk);
+extern void omap1_clk_disable_unused(struct clk *clk);
 #else
 #define omap1_clk_disable_unused	NULL
 #endif


