From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP3 PM: convert open-coded iterator to use
	pwrdm_for_each_clkdm()
Date: Thu, 22 May 2008 11:33:54 -0600
Message-ID: <20080522173347.1292.43995.stgit@localhost.localdomain>
References: <20080522173035.1292.74243.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41390 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405AbYEVRgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 13:36:10 -0400
In-Reply-To: <20080522173035.1292.74243.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Convert iterators of the list of clockdomains in a powerdomain to use
pwrdm_for_each_clkdm(), rather than an open-coded for-loop.

This also fixes a bug when the D2D clockdomain is added to the 3430ES2
chip.  The open-coded for-loop tested for a NULL pointer in pwrdm_clkdms[]
to determine when to end the loop.  This causes the iterator to fall
off the end of the array when the powerdomain contains the maximum number
of clockdomains per powerdomain (currently 3).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/pm34xx.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a1bfb30..7e775cc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -179,6 +179,22 @@ static int omap3_can_sleep(void)
 	return 1;
 }
 
+/* _clkdm_deny_idle - private callback function used by set_pwrdm_state() */
+static int _clkdm_deny_idle(struct powerdomain *pwrdm,
+			    struct clockdomain *clkdm)
+{
+	omap2_clkdm_deny_idle(clkdm);
+	return 0;
+}
+
+/* _clkdm_allow_idle - private callback function used by set_pwrdm_state() */
+static int _clkdm_allow_idle(struct powerdomain *pwrdm,
+			     struct clockdomain *clkdm)
+{
+	omap2_clkdm_allow_idle(clkdm);
+	return 0;
+}
+
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
@@ -186,7 +202,6 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
 	int ret = 0;
-	int i = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
 		return -EINVAL;
@@ -196,8 +211,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (cur_state == state)
 		return ret;
 
-	for (i = 0; pwrdm->pwrdm_clkdms[i]; i++)
-		omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[i]);
+	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
 
 	ret = pwrdm_set_next_pwrst(pwrdm, state);
 	if (ret) {
@@ -206,8 +220,7 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		goto err;
 	}
 
-	for (i = 0; pwrdm->pwrdm_clkdms[i]; i++)
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
+	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
 
 err:
 	return ret;


