From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: am33xx: Fix the timer fck clock naming convention
Date: Mon, 16 Jul 2012 23:39:18 +0530
Message-ID: <1342462158-15998-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43323 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2GPSJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 14:09:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>

With commit ae6df418a21f3a361c5f9b878e32a8aba4e17692
Sub: ARM: OMAP2+: dmtimer: cleanup fclk usage)
The Timer functional clock naming convention has changed from
gptX_fck => timerXfck, and so as the timer init function
in mach-omap2/timer.c.
OMAP4 clocktree also has changed accordingly.

AM33xx Clock Tree has been merged during rc3-4 timeframe,
before above commit got merged, so similar change is required
for AM33xx as well (Change the gptX_fck => timerX_fck).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 25bbcc7..ae27de8 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1036,13 +1036,13 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
 	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
 	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt1_fck",		&timer1_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt2_fck",		&timer2_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt3_fck",		&timer3_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt4_fck",		&timer4_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt5_fck",		&timer5_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt6_fck",		&timer6_fck,	CK_AM33XX),
-	CLK(NULL,	"gpt7_fck",		&timer7_fck,	CK_AM33XX),
+	CLK(NULL,	"timer1_fck",		&timer1_fck,	CK_AM33XX),
+	CLK(NULL,	"timer2_fck",		&timer2_fck,	CK_AM33XX),
+	CLK(NULL,	"timer3_fck",		&timer3_fck,	CK_AM33XX),
+	CLK(NULL,	"timer4_fck",		&timer4_fck,	CK_AM33XX),
+	CLK(NULL,	"timer5_fck",		&timer5_fck,	CK_AM33XX),
+	CLK(NULL,	"timer6_fck",		&timer6_fck,	CK_AM33XX),
+	CLK(NULL,	"timer7_fck",		&timer7_fck,	CK_AM33XX),
 	CLK(NULL,	"usbotg_fck",		&usbotg_fck,	CK_AM33XX),
 	CLK(NULL,	"ieee5000_fck",		&ieee5000_fck,	CK_AM33XX),
 	CLK(NULL,	"wdt1_fck",		&wdt1_fck,	CK_AM33XX),
-- 
1.7.0.4

