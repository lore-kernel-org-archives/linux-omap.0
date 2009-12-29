From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.33-rc2+ 09/12] arm: omap: kill compile warning on board-4430-sdp.c
Date: Wed, 30 Dec 2009 00:51:29 +0200
Message-ID: <1262127092-14878-10-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58963 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbZL2W4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:56:40 -0500
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

sdp4430_uart_config isn't used anywhere, so remove it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0c6be6b..a7788b4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,10 +38,6 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 };
 
-static struct omap_uart_config sdp4430_uart_config __initdata = {
-	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
-};
-
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
-- 
1.6.6.35.g1d85d

