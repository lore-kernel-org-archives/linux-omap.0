From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/12] ARM: OMAP2+: PM debug: trace the functional power
 domains states
Date: Sun, 09 Dec 2012 10:53:09 -0700
Message-ID: <20121209175301.6933.81855.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39976 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab2LIRyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:44 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <jean.pihet@newoldbits.com>

Trace the power domain transitions using the functional power states,
which include the power and logic states.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
[paul@pwsan.com: split the fix that was originally part of this patch into a
 separate patch]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 18f33de..2c732b6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -881,13 +881,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: %s: setting next powerstate to %0x\n",
 		 pwrdm->name, pwrst);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
-		/* Trace the pwrdm desired target state */
-		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
-		/* Program the pwrdm desired target state */
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
-	}
 
 	return ret;
 }
@@ -1571,6 +1566,9 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
 	pr_debug("%s: set fpwrst %0x to pwrdm %s\n", __func__, fpwrst,
 		 pwrdm->name);
 
+	/* Trace the pwrdm desired target state */
+	trace_power_domain_target(pwrdm->name, fpwrst, smp_processor_id());
+
 	pwrdm_lock(pwrdm);
 	ret = _set_logic_retst_and_pwrdm_pwrst(pwrdm, logic, pwrst);
 	pwrdm_unlock(pwrdm);
@@ -1658,6 +1656,10 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
 	if (next_fpwrst == fpwrst)
 		goto psf_out;
 
+	/* Trace the pwrdm desired target state */
+	trace_power_domain_target(pwrdm->name, next_fpwrst,
+				  smp_processor_id());
+
 	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
 							    &hwsup);
 


