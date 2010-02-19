From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] omap: musb: remove unused data
Date: Fri, 19 Feb 2010 15:30:24 -0800
Message-ID: <20100219233024.10559.18440.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63278 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab0BSX3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:31 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

eps_bits wasn't being used anywhere, let's remove it.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 2ddc316..7e2ee01 100644
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

