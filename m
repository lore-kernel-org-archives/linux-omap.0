From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm associated to a pwrdm
Date: Thu, 13 Jun 2013 15:38:43 +0530
Message-ID: <1371118124-15910-2-git-send-email-rnayak@ti.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45740 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3FMKJb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 06:09:31 -0400
In-Reply-To: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

The powerdomain framework expects all powerdomains to be associated with
a corresponding voltagedomain. For some SoCs' (like the already existing AM33xx
family, or for the upcoming AM437x and DRA7 SoCs') which
do not have a Voltage controller/Voltage Processor (neither the SR I2C
bus to communicate with the PMIC) there is no need for a Powerdomain to have
a voltage domain association (since they are really non scaleable, even
though the voltage domains exist in place).

Extend the arch operations to add an api which the powerdomain core can
then use to identify if a voltdm lookup and association for a powerdomain
is really needed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    5 +++++
 arch/arm/mach-omap2/powerdomain.h |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 86babd7..e233dfc 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -102,6 +102,10 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	if (_pwrdm_lookup(pwrdm->name))
 		return -EEXIST;
 
+	if (arch_pwrdm && arch_pwrdm->pwrdm_has_voltdm)
+		if (!arch_pwrdm->pwrdm_has_voltdm())
+			goto skip_voltdm;
+
 	voltdm = voltdm_lookup(pwrdm->voltdm.name);
 	if (!voltdm) {
 		pr_err("powerdomain: %s: voltagedomain %s does not exist\n",
@@ -111,6 +115,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	pwrdm->voltdm.ptr = voltdm;
 	INIT_LIST_HEAD(&pwrdm->voltdm_node);
 	voltdm_add_pwrdm(voltdm, pwrdm);
+skip_voltdm:
 	spin_lock_init(&pwrdm->_lock);
 
 	list_add(&pwrdm->node, &pwrdm_list);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 140c360..8ed89de 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -166,6 +166,7 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ * @pwrdm_has_voltdmi: Check if a voltdm association is needed
  *
  * Regarding @pwrdm_set_lowpwrstchange: On the OMAP2 and 3-family
  * chips, a powerdomain's power state is not allowed to directly
@@ -196,6 +197,7 @@ struct pwrdm_ops {
 	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
 	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
+	int	(*pwrdm_has_voltdm)(void);
 };
 
 int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
-- 
1.7.9.5

