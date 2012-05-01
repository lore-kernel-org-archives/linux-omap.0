From: jean.pihet@newoldbits.com
Subject: [PATCH 5/5] ARM: OMAP2+: PM debug: use the power domains registers caching API
Date: Tue,  1 May 2012 15:07:43 +0200
Message-ID: <1335877663-32649-6-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45236 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2EANIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:16 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1464892wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:15 -0700 (PDT)
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Use the caching API instead of using the internal pwrdm->state field
for PM debug statistics display.

Note: some power domains states mismatch messages can be printed out with
the power domains states statstics, indicating that the power domains are
not controlled by any driver or that the invalidate API is not correctly
used.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 13c00fb..ed9846e 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -96,19 +96,20 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
-	int i;
+	int i, pwrst;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
 		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
 		strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
-	if (pwrdm->state != pwrdm_read_func_pwrst(pwrdm))
-		printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
-		       pwrdm->name, pwrdm->state, pwrdm_read_func_pwrst(pwrdm));
+	pwrst = pwrdm_read_func_pwrst(pwrdm);
+	if (pwrdm->state != pwrst)
+		printk(KERN_ERR "pwrdm state mismatch(%s): last saved %d != current %d\n",
+		       pwrdm->name, pwrdm->state, pwrst);
 
 	seq_printf(s, "%s (%s)", pwrdm->name,
-			pwrdm_state_names[pwrdm->state]);
+			pwrdm_state_names[pwrst]);
 	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
@@ -126,7 +127,7 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
-	int i;
+	int i, pwrst;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
 		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
@@ -134,9 +135,10 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 		return 0;
 
 	pwrdm_state_switch(pwrdm);
+	pwrst = pwrdm_read_func_pwrst(pwrdm);
 
 	seq_printf(s, "%s (%s)", pwrdm->name,
-		pwrdm_state_names[pwrdm->state]);
+		pwrdm_state_names[pwrst]);
 
 	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
-- 
1.7.7.6

