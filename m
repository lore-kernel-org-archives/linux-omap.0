From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.34 9/9] arm: omap: musb: get rid of dyn_fifo
Date: Wed, 30 Dec 2009 00:59:27 +0200
Message-ID: <1262127567-15202-10-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50540 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbZL2W7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:59:55 -0500
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org

that's deprecated as we can check dyn_fifo from
CONFIGDATA register.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index f102d5a..57debb2 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -49,7 +49,6 @@ static struct resource musb_resources[] = {
 
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
-	.dyn_fifo	= 1,
 	.num_eps	= 16,
 	.ram_bits	= 12,
 };
-- 
1.6.6.35.g1d85d

