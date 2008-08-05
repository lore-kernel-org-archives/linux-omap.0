From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.26-omap-git] beagle LED fixes
Date: Mon, 4 Aug 2008 23:56:15 -0700
Message-ID: <200808042356.16674.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:34255 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753245AbYHEG4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 02:56:18 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Update and fix Beagle LED declarations:  gpios for USR0 and USR1
were swapped, and their names don't match docs or silksreen.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04 22:08:16.000000000 -0700
+++ b/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-04 22:08:36.000000000 -0700

@@ -75,14 +76,14 @@ static struct omap_lcd_config omap3_beag
 
 struct gpio_led gpio_leds[] = {
 	{
-		.name			= "beagleboard::led0",
+		.name			= "beagleboard::usr0",
 		.default_trigger	= "none",
-		.gpio			= 149,
+		.gpio			= 150,
 	},
 	{
-		.name			= "beagleboard::led1",
+		.name			= "beagleboard::usr1",
 		.default_trigger	= "none",
-		.gpio			= 150,
+		.gpio			= 149,
 	},
 };
 
