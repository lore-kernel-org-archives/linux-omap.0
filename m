From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 6/6] OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
Date: Tue, 16 Nov 2010 21:08:06 +0530
Message-ID: <1289921886-5139-7-git-send-email-rnayak@ti.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
 <1289921886-5139-2-git-send-email-rnayak@ti.com>
 <1289921886-5139-3-git-send-email-rnayak@ti.com>
 <1289921886-5139-4-git-send-email-rnayak@ti.com>
 <1289921886-5139-5-git-send-email-rnayak@ti.com>
 <1289921886-5139-6-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45834 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab0KPPiT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 10:38:19 -0500
In-Reply-To: <1289921886-5139-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4430 ES2 has additional bitfields in PWRSTST register which help
identify the previous power state entered by the powerdomain.
Add pwrdm_clear_all_prev_pwrst api to support this.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomains44xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
index 79be2cd..0414e6a 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.c
+++ b/arch/arm/mach-omap2/powerdomains44xx.c
@@ -45,6 +45,14 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
+static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+			0x3 << OMAP4430_LASTPOWERSTATEENTERED_SHIFT,
+			pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+	return 0;
+}
+
 static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
 	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
@@ -154,6 +162,7 @@ struct pwrdm_functions omap4_pwrdm_functions = {
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
-- 
1.7.0.4

