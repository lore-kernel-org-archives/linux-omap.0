From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Tue, 16 Aug 2011 19:50:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108161949400.9948@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1107150152590.16606@utopia.booyaka.com> <4E213DB3.1080809@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53960 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBue (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 21:50:34 -0400
In-Reply-To: <4E213DB3.1080809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi everyone

I've tweaked this patch a little bit.  Please let me know if you have any 
issues with it ASAP,

thanks,

- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 16 Aug 2011 15:22:58 -0600
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states as ON
 at init

Program all powerdomain target state as ON; this is to prevent domains
from hitting low power states (if bootloader has target states set to
something other than ON) and potentially even losing context while PM
is not fully initialized, which can cause the system to crash.  The PM
late init code can then program the desired target state for all the
power domains.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[paul@pwsan.com: dropped comment typo hunk; fixed comment indent and moved
 to kerneldoc; moved code to pwrdm_init(); changed pwrdm_init() argument name
 to prevent clash; cleaned up patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9af0847..ef71fdd 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -195,28 +195,35 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 
 /**
  * pwrdm_init - set up the powerdomain layer
- * @pwrdm_list: array of struct powerdomain pointers to register
+ * @pwrdms: array of struct powerdomain pointers to register
  * @custom_funcs: func pointers for arch specific implementations
  *
- * Loop through the array of powerdomains @pwrdm_list, registering all
- * that are available on the current CPU. If pwrdm_list is supplied
- * and not null, all of the referenced powerdomains will be
- * registered.  No return value.  XXX pwrdm_list is not really a
- * "list"; it is an array.  Rename appropriately.
+ * Loop through the array of powerdomains @pwrdms, registering all
+ * that are available on the current CPU.  Also, program all
+ * powerdomain target state as ON; this is to prevent domains from
+ * hitting low power states (if bootloader has target states set to
+ * something other than ON) and potentially even losing context while
+ * PM is not fully initialized.  The PM late init code can then program
+ * the desired target state for all the power domains.  No return
+ * value.
  */
-void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs)
+void pwrdm_init(struct powerdomain **pwrdms, struct pwrdm_ops *custom_funcs)
 {
 	struct powerdomain **p = NULL;
+	struct powerdomain *temp_p;
 
 	if (!custom_funcs)
 		WARN(1, "powerdomain: No custom pwrdm functions registered\n");
 	else
 		arch_pwrdm = custom_funcs;
 
-	if (pwrdm_list) {
-		for (p = pwrdm_list; *p; p++)
+	if (pwrdms) {
+		for (p = pwrdms; *p; p++)
 			_pwrdm_register(*p);
 	}
+
+	list_for_each_entry(temp_p, &pwrdm_list, node)
+		pwrdm_set_next_pwrst(temp_p, PWRDM_POWER_ON);
 }
 
 /**
-- 
1.7.5.4

