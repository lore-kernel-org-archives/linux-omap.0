From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] ARM: OMAP: rx51: Fix a section mismatch warn
Date: Wed, 12 Sep 2012 20:07:04 +0530
Message-ID: <1347460624-25259-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41224 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab2ILOhP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 10:37:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

rx51_si4713_dev is referenced only from rx51_init_si4713.
So the memory for rx51_si4713_dev can be safely freed after init.
Also it references rx51_si4713_board_info which is __initdata_or_module.

fixes the below warning.

WARNING: vmlinux.o(.data+0x30958): Section mismatch in reference from the variable rx51_si4713_dev to the (unknown reference) .init.data:(unknown)
The variable rx51_si4713_dev references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Reported-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index df2534d..e2e1148 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -743,7 +743,7 @@ static struct radio_si4713_platform_data rx51_si4713_data __initdata_or_module =
 	.subdev_board_info = &rx51_si4713_board_info,
 };
 
-static struct platform_device rx51_si4713_dev = {
+static struct platform_device rx51_si4713_dev __initdata_or_module = {
 	.name	= "radio-si4713",
 	.id	= -1,
 	.dev	= {
-- 
1.7.5.4

