From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm associated to a pwrdm
Date: Mon, 17 Jun 2013 18:46:22 +0530
Message-ID: <1371474983-29296-2-git-send-email-rnayak@ti.com>
References: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756286Ab3FQNRQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 09:17:16 -0400
In-Reply-To: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@linaro.org, paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

The powerdomain framework currently expects all powerdomains to be associated with
a corresponding voltagedomain. For some SoCs' (like the already existing AM33xx
family, or for the upcoming AM437x and DRA7 SoCs') which
do not have a Voltage controller/Voltage Processor (neither the SR I2C
bus to communicate with the PMIC) there is no need for a Powerdomain to have
a voltage domain association since there is no auto-scaling of voltages possible
using the voltage FSM.

Extend the arch operations to add an api which the powerdomain core can
then use to identify if a voltdm lookup and association for a powerdomain
is really needed.

Acked-by: Nishanth Menon <nm@ti.com>
Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
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
index 140c360..9701ad5 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -166,6 +166,7 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ * @pwrdm_has_voltdm: Check if a voltdm association is needed
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

