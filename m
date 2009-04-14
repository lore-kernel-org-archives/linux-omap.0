From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] ARM: OMAP2: possible division by 0
Date: Tue, 14 Apr 2009 14:57:03 -0700
Message-ID: <20090414215703.9878.96593.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51558 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbZDNV5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:57:12 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

In linus' git tree the functions can be found at:
vi arch/arm/mach-omap2/usb-tusb6010.c +200	- tusb6010_platform_retime()
vi arch/arm/mach-omap2/gpmc.c +94		- gpmc_get_fclk_period()
vi arch/arm/mach-omap2/usb-tusb6010.c +53	- tusb_set_async_mode()
vi arch/arm/mach-omap2/usb-tusb6010.c +111	- tusb_set_sync_mode()

is -ENODEV appropriate when sysclk_ps == 0?

This was found by code analysis, please review.
------------------------------>8-------------8<---------------------------------
gpmc_get_fclk_period() may return 0 when gpmc_l3_clk is not enabled. This is
not checked in tusb6010_platform_retime() nor in tusb_set_async_mode() it
seems. In tusb_set_sync_mode() this may result in a division by zero.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 15e5090..8df55f4 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -187,7 +187,7 @@ int tusb6010_platform_retime(unsigned is_refclk)
 	unsigned	sysclk_ps;
 	int		status;
 
-	if (!refclk_psec)
+	if (!refclk_psec || sysclk_ps == 0)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;

