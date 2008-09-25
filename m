From: Paul Walmsley <paul@pwsan.com>
Subject: RE: clk_disable_unused() is bugged
Date: Thu, 25 Sep 2008 01:44:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809250144090.10647@utopia.booyaka.com>
References: <00c701c91eca$a16afc20$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33329 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbYIYHol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:44:41 -0400
In-Reply-To: <00c701c91eca$a16afc20$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero.Kristo@nokia.com, linux-omap@vger.kernel.org

Hi Rajendra,

On Thu, 25 Sep 2008, Rajendra Nayak wrote:

> I tried this patch on top of the pm-1 branch. On the 3430SDP I see idle being able to
> hit CORE RET, but system suspend seems to crash. See the crash log below.

thanks for the report.  Does this patch fix it?


- Paul

OMAP3 clock: fix dss1_alwon_fck

From: Paul Walmsley <paul@pwsan.com>

Commit a63efb1547ac35dcb0f007090396a3c7510eb691 broke the dss1_alwon_fck
clock enable on 3430ES2+.  The clock code was not waiting for the module
to come out of idle.

Problem reported by Rajendra Nayak <rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8ce7097..4722277 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2304,7 +2304,7 @@ static struct clk dss1_alwon_fck_3430es1 = {
 	.prcm_mod	= OMAP3430_DSS_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm		= { .name = "dss_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2317,7 +2317,7 @@ static struct clk dss1_alwon_fck_3430es2 = {
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
 	.idlest_bit	= OMAP3430ES2_ST_DSS_IDLE_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "dss_clkdm" },
 	.recalc		= &followparent_recalc,
 };
