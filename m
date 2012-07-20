From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 3/4] ARM: OMAP: powerdomain: Add .power_on/.power_down hooks for powerdomains
Date: Fri, 20 Jul 2012 11:34:43 +0530
Message-ID: <1342764284-8143-4-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab2GTGFs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 02:05:48 -0400
In-Reply-To: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>

With usecounting added to Powerdomains, its now possible to track Powerdomain
transitions, including when a Powerdomain is turned on and turned down.
Add support for hooking up callbacks for such events, which can be used to
do things like context save/restore etc. which today is mostly stuffed within
CPUidle and Suspend code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 +++++++++++-
 arch/arm/mach-omap2/powerdomain.h |    4 ++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index f435819..d2c096c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -992,10 +992,16 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
  */
 void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
 {
+	int prev_state;
+
 	if (!pwrdm)
 		return;
 
 	if (atomic_inc_return(&pwrdm->usecount) == 1) {
+		if (pwrdm->power_on) {
+			prev_state = pwrdm_read_prev_pwrst(pwrdm);
+			pwrdm->power_on(pwrdm, prev_state);
+		}
 		pwrdm_post_transition(pwrdm);
 		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
 	}
@@ -1010,7 +1016,7 @@ void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
  */
 void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 {
-	int val;
+	int val, next_state;
 
 	if (!pwrdm)
 		return;
@@ -1020,6 +1026,10 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 	if (!val) {
 		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
 		pwrdm_pre_transition(pwrdm);
+		if (pwrdm->power_down) {
+			next_state = pwrdm_read_next_pwrst(pwrdm);
+			pwrdm->power_down(pwrdm, next_state);
+		}
 	}
 
 	BUG_ON(val < 0);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 52a99cf..a6e09cf 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,8 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @power_on: callback function before powerdomain is turned on
+ * @power_down: callback function after powerdomain is turned down
  * @state:
  * @state_counter:
  * @timer:
@@ -121,6 +123,8 @@ struct powerdomain {
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
 	atomic_t usecount;
+	int (*power_on)(struct powerdomain *pwrdm, int prev_state);
+	int (*power_down)(struct powerdomain *pwrdm, int next_state);
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
-- 
1.7.1

