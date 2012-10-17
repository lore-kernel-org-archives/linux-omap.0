From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: AM33XX: Fix configuration of dmtimer parent clock by dmtimer driver
Date: Wed, 17 Oct 2012 13:55:55 -0500
Message-ID: <1350500155-22525-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757623Ab2JQS4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 14:56:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add dmtimer clock aliases for AM33XX devices so that the parent clock for
the dmtimer can be set correctly by the dmtimer driver. Without these clock
aliases the dmtimer driver will fail to find the parent clocks for the dmtimer.

Verified that DMTIMERs can be successfully requested on AM335x beagle bone.

Original patch was provided by Vaibhav Hiremath [1]. Changelog and
additional verification performed by Jon Hunter.

[1] http://marc.info/?l=linux-omap&m=134693631608018&w=2

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 114ab4b..1a45d6b 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1073,6 +1073,8 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"gfx_fck_div_ck",	&gfx_fck_div_ck,	CK_AM33XX),
 	CLK(NULL,	"sysclkout_pre_ck",	&sysclkout_pre_ck,	CK_AM33XX),
 	CLK(NULL,	"clkout2_ck",		&clkout2_ck,	CK_AM33XX),
+	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
+	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
 };
 
 int __init am33xx_clk_init(void)
-- 
1.7.9.5

