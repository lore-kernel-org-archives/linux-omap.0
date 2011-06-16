From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
Date: Fri, 17 Jun 2011 02:01:00 +0530
Message-ID: <1308256260-15597-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1FPUbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 16:31:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Fix the section mismatch warning:

  WARNING: vmlinux.o(.text+0x21118): Section mismatch
  in reference from the function pm_dbg_init() to the
  function .init.text:pwrdms_setup()
  The function pm_dbg_init() references
  the function __init pwrdms_setup().
  This is often because pm_dbg_init lacks a __init
  annotation or the annotation of pwrdms_setup is wrong.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 Applies to current linux-omap master

 arch/arm/mach-omap2/pm-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e01da45..ef33273 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -595,7 +595,7 @@ static int option_set(void *data, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
 
-static int pm_dbg_init(void)
+static int __init pm_dbg_init(void)
 {
 	int i;
 	struct dentry *d;
-- 
1.7.2.2

