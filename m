From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Sat, 20 Sep 2008 02:51:40 -0400
Message-ID: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:28358 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYITGvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2008 02:51:42 -0400
Received: by ti-out-0910.google.com with SMTP id b6so414210tic.23
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 23:51:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

without this the below error messages were coming continuously

TWL4030 module irq 369 is disabled but can't be masked!
<2>TWL4030 module irq 369 is disabled but can't be masked!

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
index 92f70ce..f9fd06b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -22,6 +22,7 @@
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/i2c/twl4030.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -176,6 +177,7 @@ static struct omap_kp_platform_data omap3evm_kp_data = {
 	.keymap 	= omap3evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
 	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
 };

 static struct platform_device omap3evm_kp_device = {
-- 
1.5.3.4
