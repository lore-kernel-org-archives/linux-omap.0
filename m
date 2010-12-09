From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on !CONFIG_THUMB2_KERNEL
Date: Thu,  9 Dec 2010 11:59:42 +0000
Message-ID: <1291895982-4775-3-git-send-email-dave.martin@linaro.org>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34140 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0LIMAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 07:00:18 -0500
Received: by wyb28 with SMTP id 28so2190121wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 04:00:17 -0800 (PST)
In-Reply-To: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Because the nwfpe support is unlikely to be used on new platforms
and requires CONFIG_OABI_COMPAT, which is not generally used with
ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
kernel.

At present, nwfpe contains assembly code which isn't Thumb-2
compatible, and for now it doesn't appear useful to port this
code.

All ARMv7-A/R platforms necessarily have VFPv3 hardware floating-
point natively, making emulation unnecessary.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f9ca7f3..7e825c3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1759,7 +1759,7 @@ comment "At least one emulation must be selected"
 
 config FPE_NWFPE
 	bool "NWFPE math emulation"
-	depends on !AEABI || OABI_COMPAT
+	depends on (!AEABI || OABI_COMPAT) && !THUMB2_KERNEL
 	---help---
 	  Say Y to include the NWFPE floating point emulator in the kernel.
 	  This is necessary to run most binaries. Linux does not currently
-- 
1.7.1

