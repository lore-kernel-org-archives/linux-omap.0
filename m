From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/8] arm: omap: musb: remove unused data
Date: Mon, 28 Dec 2009 13:09:43 +0200
Message-ID: <1261998590-6639-2-git-send-email-felipe.balbi@nokia.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61566 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbZL1LMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:12:00 -0500
In-Reply-To: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Felipe Balbi <me@felipebalbi.com>

eps_bits wasn't being used anywhere, let's
remove it.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 arch/arm/mach-omap2/usb-musb.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..de7ae49 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -68,39 +68,6 @@ static int musb_set_clock(struct clk *clk, int state)
 	return 0;
 }
 
-static struct musb_hdrc_eps_bits musb_eps[] = {
-	{	"ep1_tx", 10,	},
-	{	"ep1_rx", 10,	},
-	{	"ep2_tx", 9,	},
-	{	"ep2_rx", 9,	},
-	{	"ep3_tx", 3,	},
-	{	"ep3_rx", 3,	},
-	{	"ep4_tx", 3,	},
-	{	"ep4_rx", 3,	},
-	{	"ep5_tx", 3,	},
-	{	"ep5_rx", 3,	},
-	{	"ep6_tx", 3,	},
-	{	"ep6_rx", 3,	},
-	{	"ep7_tx", 3,	},
-	{	"ep7_rx", 3,	},
-	{	"ep8_tx", 2,	},
-	{	"ep8_rx", 2,	},
-	{	"ep9_tx", 2,	},
-	{	"ep9_rx", 2,	},
-	{	"ep10_tx", 2,	},
-	{	"ep10_rx", 2,	},
-	{	"ep11_tx", 2,	},
-	{	"ep11_rx", 2,	},
-	{	"ep12_tx", 2,	},
-	{	"ep12_rx", 2,	},
-	{	"ep13_tx", 2,	},
-	{	"ep13_rx", 2,	},
-	{	"ep14_tx", 2,	},
-	{	"ep14_rx", 2,	},
-	{	"ep15_tx", 2,	},
-	{	"ep15_rx", 2,	},
-};
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
@@ -110,7 +77,6 @@ static struct musb_hdrc_config musb_config = {
 	.dma_channels	= 7,
 	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 	.ram_bits	= 12,
-	.eps_bits	= musb_eps,
 };
 
 static struct musb_hdrc_platform_data musb_plat = {
-- 
1.6.6.rc0

