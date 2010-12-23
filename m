From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap: tusb6010: add name for MUSB IRQ
Date: Thu, 23 Dec 2010 10:50:31 +0200
Message-ID: <1293094231-3270-2-git-send-email-balbi@ti.com>
References: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
 <1293094231-3270-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40558 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027Ab0LWIuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 03:50:40 -0500
Received: by ewy23 with SMTP id 23so3715549ewy.25
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 00:50:38 -0800 (PST)
In-Reply-To: <1293094231-3270-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

commit fcf173e4511193b1efeccb0f22a8c641b464353b
(add names for IRQs in structure resource)
forgot to take care of tusb6010 making it
fail to probe due to a missing resource.

Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 1e998ea..30f112b 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -216,6 +216,7 @@ static struct resource tusb_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{ /* IRQ */
+		.name	= "mc",
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.3.4.598.g85356

