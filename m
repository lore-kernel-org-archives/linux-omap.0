From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/13] OMAP: omap3_pm_get_suspend_state() error ignored in pwrdm_suspend_get()
Date: Fri,  8 Jan 2010 09:59:29 -0800
Message-ID: <1262973571-25796-12-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-11-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63991 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab0AHR7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:55 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so3897390pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:55 -0800 (PST)
In-Reply-To: <1262973571-25796-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

val is an u64 pointer, we need an int to check the error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e9d3993..562d190 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -488,9 +488,11 @@ int pm_dbg_regset_init(int reg_set)
 
 static int pwrdm_suspend_get(void *data, u64 *val)
 {
-	*val = omap3_pm_get_suspend_state((struct powerdomain *)data);
+	int ret;
+	ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
+	*val = ret;
 
-	if (*val >= 0)
+	if (ret >= 0)
 		return 0;
 	return *val;
 }
-- 
1.6.6.rc2.1.g42108

