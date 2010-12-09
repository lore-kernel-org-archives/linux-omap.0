From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 1/2] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Thu,  9 Dec 2010 11:59:41 +0000
Message-ID: <1291895982-4775-2-git-send-email-dave.martin@linaro.org>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64504 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0LIMAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 07:00:09 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so2366568wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 04:00:09 -0800 (PST)
In-Reply-To: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

This makes sense, because Thumb-2 code can't execute on plain
ARMv6 processors.

This will avoid accidentally configuring a broken kernel where the
config otherwise would allow multiple architecture versions to
coexist in the same kernel.

Not adding !CPU_V5 etc., because the chance of anyone trying to
put v5 and v7 in the same kernel is low, and I'm not aware of
any mach which can do this.  These could be added later if it
matters.

Note that the rules may need to be refined if support for the
ARM1156J(F)-S processor is later added to the kernel, since this
processor supports the rare ARMv6T2 extensions, which add support
for Thumb-2 and a few other ARMv7 features.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..f9ca7f3 100644
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

