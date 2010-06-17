From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/8] musb_core: make disconnect and suspend interrupts work again
Date: Thu, 17 Jun 2010 16:10:34 +0530
Message-ID: <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40603 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759867Ab0FQKlZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jun 2010 06:41:25 -0400
In-Reply-To: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Sergei Shtylyov <sshtylyov@ru.mvista.com>, stable@kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle irqs in the
order dictated by programming guide) forgot to get rid of the old 'STAGE0_MASK'
filter for calling musb_stage0_irq(), so now disconnect and suspend interrupts
are effectively ignored...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index fad70bc..f0ff893 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -451,10 +451,6 @@ void musb_hnp_stop(struct musb *musb)
  * @param power
  */
 
-#define STAGE0_MASK (MUSB_INTR_RESUME | MUSB_INTR_SESSREQ \
-		| MUSB_INTR_VBUSERROR | MUSB_INTR_CONNECT \
-		| MUSB_INTR_RESET)
-
 static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
@@ -1597,7 +1593,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	/* the core can interrupt us for multiple reasons; docs have
 	 * a generic interrupt flowchart to follow
 	 */
-	if (musb->int_usb & STAGE0_MASK)
+	if (musb->int_usb)
 		retval |= musb_stage0_irq(musb, musb->int_usb,
 				devctl, power);
 
-- 
1.6.2.4

