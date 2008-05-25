From: trickie@gmail.com
Subject: [PATCH] Fix n800 build - Remove kernel config conditional declaration of TSC2005 device config structures
Date: Sun, 25 May 2008 10:45:41 +0200
Message-ID: <1211705141-12878-1-git-send-email-trickie@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:44200 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYEYIpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 May 2008 04:45:44 -0400
Received: by ug-out-1314.google.com with SMTP id h2so187816ugf.16
        for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 01:45:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nick Loeve <trickie@gmail.com>


Signed-off-by: Nick Loeve <trickie@gmail.com>
---
 arch/arm/mach-omap2/board-n800.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index ae85c2c..f902482 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -372,7 +372,6 @@ static struct omap2_mcspi_device_config cx3110x_mcspi_config = {
 	.single_channel = 1,
 };
 
-#ifdef CONFIG_TOUCHSCREEN_TSC2005
 static struct tsc2005_platform_data tsc2005_config = {
 	.reset_gpio = 94,
 	.dav_gpio = 106
@@ -382,7 +381,6 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel = 1,
 };
-#endif
 
 static struct spi_board_info n800_spi_board_info[] __initdata = {
 	{
-- 
1.5.5.1

