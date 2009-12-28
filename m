From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/8] arm: omap: musb: remove unused soft_con field
Date: Mon, 28 Dec 2009 13:09:45 +0200
Message-ID: <1261998590-6639-4-git-send-email-felipe.balbi@nokia.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61556 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbZL1LLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:11:53 -0500
In-Reply-To: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

remove unused data.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5a55c12..ceee958 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -50,7 +50,6 @@ static struct resource musb_resources[] = {
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
-	.soft_con	= 1,
 	.dma		= 1,
 	.num_eps	= 16,
 	.dma_channels	= 7,
-- 
1.6.6.rc0

