From: John Rigby <john.rigby@linaro.org>
Subject: [PATCH] OMAP4: enable smc instruction in new assembler versions
Date: Tue, 30 Nov 2010 22:57:51 -0700
Message-ID: <1291183071-21603-1-git-send-email-john.rigby@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36369 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab0LAF7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 00:59:25 -0500
Received: by ywl5 with SMTP id 5so3197197ywl.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 21:59:25 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, John Rigby <john.rigby@linaro.org>

New assemblers need -march=armv7-a+sec on command line or
.arch_extension sec inline to enable use of the smc instruction.

This patch uses as-instr to check the latter to conditionally
enable the former in AFLAGS for files that use smc.

Checked on both old and new binutils to verify that it does
not break old versions.

Signed-off-by: John Rigby <john.rigby@linaro.org>
---
 arch/arm/mach-omap2/Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..ee9ef4f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -26,8 +26,9 @@ obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
-AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a
-AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
-- 
1.7.3.1.120.g38a18

