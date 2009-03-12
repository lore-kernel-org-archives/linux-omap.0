From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 85/86] [ARM] omap: ensure that failing power domain lookups produce errors
Date: Thu, 12 Mar 2009 11:28:35 -0700
Message-ID: <1236882516-29403-86-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-80-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-83-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-84-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-85-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:57846 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbZCLSeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:50 -0400
Received: by gxk7 with SMTP id 7so461445gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:48 -0700 (PDT)
In-Reply-To: <1236882516-29403-85-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Use pr_err() for errors rather than pr_debug().  pr_debug() are
compiled away unless -DDEBUG is used.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clockdomain.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ae0c53a..0e7d501 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -74,14 +74,11 @@ static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
 
 	pwrdm = pwrdm_lookup(autodep->pwrdm.name);
 	if (!pwrdm) {
-		pr_debug("clockdomain: _autodep_lookup: powerdomain %s "
-			 "does not exist\n", autodep->pwrdm.name);
-		WARN_ON(1);
+		pr_err("clockdomain: autodeps: powerdomain %s does not exist\n",
+			 autodep->pwrdm.name);
 		pwrdm = ERR_PTR(-ENOENT);
 	}
 	autodep->pwrdm.ptr = pwrdm;
-
-	return;
 }
 
 /*
@@ -211,8 +208,8 @@ int clkdm_register(struct clockdomain *clkdm)
 
 	pwrdm = pwrdm_lookup(clkdm->pwrdm.name);
 	if (!pwrdm) {
-		pr_debug("clockdomain: clkdm_register %s: powerdomain %s "
-			 "does not exist\n", clkdm->name, clkdm->pwrdm.name);
+		pr_err("clockdomain: %s: powerdomain %s does not exist\n",
+			clkdm->name, clkdm->pwrdm.name);
 		return -EINVAL;
 	}
 	clkdm->pwrdm.ptr = pwrdm;
@@ -222,7 +219,7 @@ int clkdm_register(struct clockdomain *clkdm)
 	if (_clkdm_lookup(clkdm->name)) {
 		ret = -EEXIST;
 		goto cr_unlock;
-	};
+	}
 
 	list_add(&clkdm->node, &clkdm_list);
 
-- 
1.6.1.2

