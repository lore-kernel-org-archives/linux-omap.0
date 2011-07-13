From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states as ON at init
Date: Wed, 13 Jul 2011 08:56:27 +0530
Message-ID: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40521 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357Ab1GMD0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jul 2011 23:26:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Program all powerdomain target state as ON; This is to
prevent domains from hitting low power states (if bootloader
has target states set to something other than ON) and potentially
even losing context while PM is not fully initilized.
The PM late init code can then program the desired target
state for all the power domains.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e0490bc..e61866c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 
 	list_add(&pwrdm->node, &pwrdm_list);
 
+	/*
+	* Program all powerdomain target state as ON; This is to
+	* prevent domains from hitting low power states (if bootloader
+	* has target states set to something other than ON) and potentially
+	* even losing context while PM is not fully initilized.
+	* The PM late init code can then program the desired target
+	* state for all the power domains.
+	*/
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+
 	/* Initialize the powerdomain's state counter */
 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
@@ -218,7 +228,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 /**
  * pwrdm_init - set up the powerdomain layer
  * @pwrdm_list: array of struct powerdomain pointers to register
- * @custom_funcs: func pointers for arch specific implementations
+ * @custom_funcs: func pointers for arch specfic implementations
  *
  * Loop through the array of powerdomains @pwrdm_list, registering all
  * that are available on the current CPU. If pwrdm_list is supplied
-- 
1.7.4.1

