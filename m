From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-v2.6.34 1/9] arm: omap: musb: remove unused data
Date: Wed, 30 Dec 2009 00:59:19 +0200
Message-ID: <1262127567-15202-2-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

eps_bits wasn't being used anywhere, let's
remove it.

Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/usb-musb.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 884336f..57589ff 100644
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
