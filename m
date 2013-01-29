From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v3 4/9] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
Date: Tue, 29 Jan 2013 16:45:03 +0530
Message-ID: <1359458108-8489-5-git-send-email-vaibhav.bedia@ti.com>
References: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab3A2LPs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 06:15:48 -0500
In-Reply-To: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Third Party Transfer Controller (TPTC0) needs to be idled and
put to standby under SW control. Add the appropriate flags in
the TPTC0 hwmod entry.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
v3: Add Peter's Acked-by
v2: Drop unnecessary parens

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 8280f11..94254e8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.mpu_irqs	= am33xx_tptc0_irqs,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-- 
1.8.1

