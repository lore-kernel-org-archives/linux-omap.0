From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH] ARM: mach-omap2: Kconfig: select SUSPEND and PM_SLEEP if PM
 for omap3
Date: Sun, 14 Aug 2011 18:41:38 +0200
Message-ID: <CAFULf_wD-qNq5=X5pv=E8+Q2wR-N2n2_z=txL5t7EwF4dQrLYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50258 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab1HNQlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 12:41:39 -0400
Received: by vws1 with SMTP id 1so3472124vws.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 09:41:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

It's conceivable to configure a kernel with CONFIG_PM, but without
CONFIG_PM_SLEEP.

- If CONFIG_PM is defined, pm34xx.c calls cpu_suspend() in line 430.
- cpu_suspend() is a static inline defined in asm/suspend.h, calling
__cpu_suspend() to do the real job.
- But __cpu_suspend (in kernel/sleep.S) is only linked in if
CONFIG_PM_SLEEP is defined.

The result is a link error:
arch/arm/mach-omap2/built-in.o: In function `cpu_suspend':
arch/arm/include/asm/suspend.h:17: undefined reference to `__cpu_suspend'

There is a similar dependency error with a call to cpu_resume() in
sleep34xx.S, line 534.

Since the code obviously assumes that PM_SLEEP should be defined if
PM, change the omap2 Kconfig
to reflect this.  The existing selection of PM_OPP if PM serves as a
precedent for this solution.

When selecting PM_SLEEP, also select SUSPEND, which PM_SLEEP depends on.

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..04a3a83 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -36,6 +36,8 @@ config ARCH_OMAP3
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
+	select SUSPEND if PM
+	select PM_SLEEP if PM

 config ARCH_OMAP4
 	bool "TI OMAP4"
-- 
1.7.1
