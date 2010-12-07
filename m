From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Tue,  7 Dec 2010 16:57:37 +0000
Message-ID: <1291741057-7449-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60588 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0LGQ5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 11:57:53 -0500
Received: by wyb28 with SMTP id 28so113633wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 08:57:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

This makes sense, because Thumb-2 code can't execute on anything
prior to ARMv7.

This will avoid accidentally configuring a broken kernel where the
config otherwise would allow multiple architecture versions to
coexist in the same kernel.

Not adding !CPU_V5 etc., because the chance of anyone trying to
put v5 and v7 in the same kernel is low, and I'm not aware of
any mach which can do this.  These could be added later if it
matters.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: 2.6.37-rc4

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f1d9297..bf1f8db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1311,7 +1311,7 @@ config HZ
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode"
-	depends on CPU_V7 && EXPERIMENTAL
+	depends on CPU_V7 && !CPU_V6 && EXPERIMENTAL
 	select AEABI
 	select ARM_ASM_UNIFIED
 	help
-- 
1.7.1

