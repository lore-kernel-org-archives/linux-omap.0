From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] omap: musb: remove unnecessary return
Date: Fri, 19 Feb 2010 15:30:34 -0800
Message-ID: <20100219233034.10559.33410.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52295 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329Ab0BSX3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:40 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 4dfb66a..2221a6c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -103,10 +103,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
 
-	if (platform_device_register(&musb_device) < 0) {
+	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-		return;
-	}
 }
 
 #else

