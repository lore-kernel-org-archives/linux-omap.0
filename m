From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: pending patch
Date: Fri, 25 Apr 2008 10:52:47 +0300
Message-ID: <20080425075245.GX23350@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17292 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbYDYHx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 03:53:57 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: david-b@pacbell.net

Hi Tony and Dave,

there's this one pending patch [1]. Do you guys have any comments on that
one?

Author: Felipe Balbi <felipe.balbi@nokia.com>
Date:   Thu Apr 17 17:34:20 2008 +0300

    USB: MUSB: Don't ignore disconnect on suspend
    
    As soon as a usb device is disconnect we should
    fall into a_wait_bcon state, ignoring disconnect
    irq will prevent this behaviour.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c5816a2..019898a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -659,7 +659,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
                        switch (musb->xceiv.state) {
 #ifdef CONFIG_USB_OTG
                        case OTG_STATE_A_SUSPEND:
-                               musb->ignore_disconnect = 1;
+                               musb->ignore_disconnect = 0;
                                musb_g_reset(musb);
                                /* FALLTHROUGH */
                        case OTG_STATE_A_WAIT_BCON:     /* OPT TD.4.7-900ms */

[1] http://marc.info/?l=linux-omap&m=120844324526642&w=2
-- 
	- Balbi
