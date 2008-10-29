From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 02/04] PM debug: do not print out status for meta powerdomains (dpll*)
Date: Wed, 29 Oct 2008 13:31:22 +0200
Message-ID: <1225279884-30668-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1225279884-30668-1-git-send-email-tero.kristo@nokia.com>
 <1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48019 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYJ2Jrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 05:47:52 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9T9lOvR009049
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:47:49 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9T9lc6V021465
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:47:41 +0200
In-Reply-To: <1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index c903c55..d21af83 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -197,7 +197,8 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 	struct seq_file *s = (struct seq_file *)user;
 
 	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
-		strcmp(clkdm->name, "wkup_clkdm") == 0)
+		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
+		strncmp(clkdm->name, "dpll", 4) == 0)
 		return 0;
 
 	seq_printf(s, "%s->%s (%d)", clkdm->name,
@@ -214,7 +215,8 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 	int i;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
-		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
+		strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
 	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
-- 
1.5.4.3

