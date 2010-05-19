From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/PATCH] arm: oprofile: remove locking from suspend/resume
Date: Tue, 18 May 2010 17:13:01 -0700
Message-ID: <1274227981-20130-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64175 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab0ESANH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 20:13:07 -0400
Received: by pwi5 with SMTP id 5so1255474pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 17:13:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Since oprofile is a sysdev, its suspend/resume methods are called with
interrupts disabled.  Using a mutex (which might sleep) in this atomic
context is not safe.

Since these methods are already called in atomic context, simply
remove the locking in the suspend/resume methods.

Found using lockdep on OMAP3 (Cortex-A8)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/oprofile/common.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 3fcd752..ea005d8 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -79,19 +79,15 @@ static void op_arm_stop(void)
 #ifdef CONFIG_PM
 static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
 {
-	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled)
 		op_arm_model->stop();
-	mutex_unlock(&op_arm_mutex);
 	return 0;
 }
 
 static int op_arm_resume(struct sys_device *dev)
 {
-	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled && op_arm_model->start())
 		op_arm_enabled = 0;
-	mutex_unlock(&op_arm_mutex);
 	return 0;
 }
 
-- 
1.7.0.2

