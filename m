From: trickie@gmail.com
Subject: [PATCH] Remove config conditional tcm825x_regs_* declarations
Date: Sat, 24 May 2008 22:20:44 +0200
Message-ID: <1211660444-629-1-git-send-email-trickie@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:56811 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYEXUUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 May 2008 16:20:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so617039nfc.21
        for <linux-omap@vger.kernel.org>; Sat, 24 May 2008 13:20:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nick Loeve <trickie@gmail.com>


Signed-off-by: Nick Loeve <trickie@gmail.com>
---
 arch/arm/mach-omap2/board-n800-camera.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
index b525125..f2bf91c 100644
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -73,7 +73,6 @@ static int frames_after_reset;
 static int saturated_count;
 #endif
 
-#ifdef CONFIG_MACH_NOKIA_N800
 const static struct tcm825x_reg tcm825x_regs_n800[] = {
 	/* initial settings for 2.5 V */
 	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
@@ -106,9 +105,7 @@ const static struct tcm825x_reg tcm825x_regs_n800[] = {
 	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
 	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
 };
-#endif
 
-#ifdef CONFIG_MACH_NOKIA_N810
 const static struct tcm825x_reg tcm825x_regs_n810[] = {
 	/* initial settings for 2.5 V */
 	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
@@ -141,7 +138,6 @@ const static struct tcm825x_reg tcm825x_regs_n810[] = {
 	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
 	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
 };
-#endif
 
 static int tcm825x_is_okay(void)
 {
-- 
1.5.5.1

