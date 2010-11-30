From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 5/5] OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
Date: Tue, 30 Nov 2010 21:14:08 +0530
Message-ID: <1291131848-31640-6-git-send-email-rnayak@ti.com>
References: <1291131848-31640-1-git-send-email-rnayak@ti.com>
 <1291131848-31640-2-git-send-email-rnayak@ti.com>
 <1291131848-31640-3-git-send-email-rnayak@ti.com>
 <1291131848-31640-4-git-send-email-rnayak@ti.com>
 <1291131848-31640-5-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab0K3PoV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 10:44:21 -0500
In-Reply-To: <1291131848-31640-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

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
 arch/arm/mach-omap2/powerdomain44xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index d9d4f88..10d7e8a 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -53,6 +53,14 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+				OMAP4430_LASTPOWERSTATEENTERED_MASK,
+				pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+	return 0;
+}
+
 static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	u32 v;
@@ -153,6 +161,7 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
 	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
+	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
-- 
1.7.0.4

