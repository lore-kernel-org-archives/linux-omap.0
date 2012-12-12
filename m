From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC 5/5] ARM: OMAP4: Add AMBA APB Clock
Date: Wed, 12 Dec 2012 15:43:08 -0600
Message-ID: <1355348588-22318-6-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47059 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab2LLVov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 16:44:51 -0500
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>, Jon Hunter <jon-hunter@ti.com>

For OMAP4 devices, ARM AMBA peripherals such as program trace module
(PTM) or cross trigger interface (CTI) require that the DEBUG Sub-system
power and clock domain is turned on. Normally, the OMAP device and HMWOD
frameworks would be used to enable the power and clock domains, but
currently these frameworks only support platform devices and not AMBA
devices. Therefore, add a clock alias for the AMBA APB clock for OMAP4
devices to turn on the DEBUGSS power and clock domain.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index aa56c3e..1ac3dc5 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1940,6 +1940,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"apb_pclk",		&trace_clk_div_ck,	CK_443X),
 };
 
 static const char *enable_init_clks[] = {
-- 
1.7.10.4

