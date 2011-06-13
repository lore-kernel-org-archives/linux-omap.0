From: "Vadillo, Miguel" <vadillo@ti.com>
Subject: [PATCH] omap4: fix build error when undefining CONFIG_SMP
Date: Mon, 13 Jun 2011 01:25:53 -0500
Message-ID: <BANLkTimf9D55OZ+-sOMPw2_WgG3QO_RooQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56697 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab1FMG0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 02:26:14 -0400
Received: by iyb39 with SMTP id 39so5530769iyb.8
        for <linux-omap@vger.kernel.org>; Sun, 12 Jun 2011 23:26:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

>From 0cffeab240c6009fbc81783cec16d35dc240196a Mon Sep 17 00:00:00 2001
From: Miguel Vadillo <vadillo@ti.com>
Date: Fri, 10 Jun 2011 16:06:20 -0500
Subject: [PATCH] omap4: fix build error when undefining CONFIG_SMP

Function omap_smc2 is undeclared when disabling SMP

Signed-off-by: Miguel Vadillo <vadillo@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
b/arch/arm/mach-omap2/include/mach/omap4-common.h
index f9769d3..1923b4e 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -74,7 +74,7 @@ extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state);
 extern void omap4_cpu_resume(void);
-extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+extern u32 omap_smc2(u32 id, u32 flag, u32 pargs);
 extern u32 omap4_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
                               u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 #else
@@ -99,6 +99,10 @@ static inline void omap4_cpu_resume(void)
 {
 }

+static inline u32 omap_smc2(u32 id, u32 flag, u32 pargs)
+{
+       return 0;
+}
 #endif
 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP4_COMMON_H */
--
1.7.1
