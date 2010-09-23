From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 8/8] omap4: powerdomain: Add pwrdm_clear_all_prev_pwrst
Date: Thu, 23 Sep 2010 18:04:51 +0530
Message-ID: <1285245291-26442-9-git-send-email-rnayak@ti.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
 <1285245291-26442-2-git-send-email-rnayak@ti.com>
 <1285245291-26442-3-git-send-email-rnayak@ti.com>
 <1285245291-26442-4-git-send-email-rnayak@ti.com>
 <1285245291-26442-5-git-send-email-rnayak@ti.com>
 <1285245291-26442-6-git-send-email-rnayak@ti.com>
 <1285245291-26442-7-git-send-email-rnayak@ti.com>
 <1285245291-26442-8-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110Ab0IWMfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 08:35:02 -0400
In-Reply-To: <1285245291-26442-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4430 ES2 has additional bitfields in PWRSTST register which help
identify the previous power state entered by the powerdomain.
Add pwrdm_clear_all_prev_pwrst api to support this. The context
register is seperate and needs to be cleared as well

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
index 3c4b060..7248647 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.c
+++ b/arch/arm/mach-omap2/powerdomains44xx.c
@@ -44,6 +44,19 @@ int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
+int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	u32 reg;
+
+	omap4_prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+			0x3 << OMAP4430_LASTPOWERSTATEENTERED_SHIFT,
+				pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+	reg = omap4_prm_read_mod_reg(pwrdm->prcm_offs, pwrdm->context_offset);
+	omap4_prm_write_mod_reg(reg, pwrdm->prcm_offs, pwrdm->context_offset);
+
+	return 0;
+}
+
 int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
 	omap4_prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
@@ -151,6 +164,7 @@ struct pwrdm_functions omap4_pwrdm_functions = {
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
-- 
1.7.0.4

