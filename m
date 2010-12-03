From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 6/6] OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
Date: Fri,  3 Dec 2010 17:08:53 +0530
Message-ID: <1291376333-13603-7-git-send-email-rnayak@ti.com>
References: <1291376333-13603-1-git-send-email-rnayak@ti.com>
 <1291376333-13603-2-git-send-email-rnayak@ti.com>
 <1291376333-13603-3-git-send-email-rnayak@ti.com>
 <1291376333-13603-4-git-send-email-rnayak@ti.com>
 <1291376333-13603-5-git-send-email-rnayak@ti.com>
 <1291376333-13603-6-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51056 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758477Ab0LCLjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 06:39:06 -0500
In-Reply-To: <1291376333-13603-6-git-send-email-rnayak@ti.com>
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
 arch/arm/mach-omap2/powerdomain44xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 4c828b9..33d1b69 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -55,6 +55,14 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
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
@@ -155,6 +163,7 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
 	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
+	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
-- 
1.7.0.4

