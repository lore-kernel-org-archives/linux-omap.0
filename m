From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 17/21] OMAP: PM debug: do not print out status for meta powerdomains (dpll*)
Date: Wed,  4 Feb 2009 18:06:03 -0800
Message-ID: <1233799567-22250-18-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-16-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-17-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:8129 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762532AbZBECHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:33 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2118065rnd.17
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:33 -0800 (PST)
In-Reply-To: <1233799567-22250-17-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6cf0e9a..b0d75b3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -195,7 +195,8 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 	struct seq_file *s = (struct seq_file *)user;
 
 	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
-		strcmp(clkdm->name, "wkup_clkdm") == 0)
+		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
+		strncmp(clkdm->name, "dpll", 4) == 0)
 		return 0;
 
 	seq_printf(s, "%s->%s (%d)", clkdm->name,
@@ -212,7 +213,8 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 	int i;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
-		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
+		strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
 	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
-- 
1.6.1

