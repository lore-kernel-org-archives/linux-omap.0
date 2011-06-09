From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/8] OMAP2+: clockdomain: Add an api to read idle mode
Date: Thu, 9 Jun 2011 16:24:06 +0530
Message-ID: <1307616853-28395-2-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49949 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757210Ab1FIKyc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:32 -0400
In-Reply-To: <1307616853-28395-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Add a clockdomain api to check if hardware supervised
idle transitions are enabled on a clockdomain.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h |    3 +++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6cb6c03..2ab3686 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -795,6 +795,27 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 	arch_clkdm->clkdm_deny_idle(clkdm);
 }
 
+/**
+ * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
+ * @clkdm: struct clockdomain *
+ *
+ * Returns true if the clockdomain is in hardware-supervised
+ * idle mode, or 0 otherwise.
+ *
+ */
+int clkdm_is_idle(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return -EINVAL;
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_is_idle)
+		return -EINVAL;
+
+	pr_debug("clockdomain: reading idle state for %s\n", clkdm->name);
+
+	return arch_clkdm->clkdm_is_idle(clkdm);
+}
+
 
 /* Clockdomain-to-clock framework interface code */
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 5823584..085ed82 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -138,6 +138,7 @@ struct clockdomain {
  * @clkdm_wakeup: Force a clockdomain to wakeup
  * @clkdm_allow_idle: Enable hw supervised idle transitions for clock domain
  * @clkdm_deny_idle: Disable hw supervised idle transitions for clock domain
+ * @clkdm_is_idle: Check if hw supervised idle transitions are enabled
  * @clkdm_clk_enable: Put the clkdm in right state for a clock enable
  * @clkdm_clk_disable: Put the clkdm in right state for a clock disable
  */
@@ -154,6 +155,7 @@ struct clkdm_ops {
 	int	(*clkdm_wakeup)(struct clockdomain *clkdm);
 	void	(*clkdm_allow_idle)(struct clockdomain *clkdm);
 	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
+	int	(*clkdm_is_idle)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
 };
@@ -177,6 +179,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
 void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
+int clkdm_is_idle(struct clockdomain *clkdm);
 
 int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
-- 
1.7.0.4

