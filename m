From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] usb: musb: core: Fix remote-wakeup resume
Date: Tue, 4 Feb 2014 15:29:33 +0200
Message-ID: <1391520573-26343-1-git-send-email-rogerq@ti.com>
References: <1391520349-26192-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391520349-26192-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

During resume don't touch SUSPENDM/RESUME bits of POWER register
while restoring controller context. These bits might be changed
by the controller during resume operation and so will be different
than what they were during suspend.

e.g. SUSPENDM bit is set by software during USB global suspend but
automatically cleared by the controller during remote wakeup or
during resume. Setting this bit back while restoring context
causes undesired behaviour. i.e. Babble interrupt is generated
and USB is broken.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/musb/musb_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index fc192ad..a501542 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2157,11 +2157,19 @@ static void musb_restore_context(struct musb *musb)
 	void __iomem *musb_base = musb->mregs;
 	void __iomem *ep_target_regs;
 	void __iomem *epio;
+	u8 power;
 
 	musb_writew(musb_base, MUSB_FRAME, musb->context.frame);
 	musb_writeb(musb_base, MUSB_TESTMODE, musb->context.testmode);
 	musb_write_ulpi_buscontrol(musb->mregs, musb->context.busctl);
-	musb_writeb(musb_base, MUSB_POWER, musb->context.power);
+
+	/* Don't affect SUSPENDM/RESUME bits in POWER reg */
+	power = musb_readb(musb_base, MUSB_POWER);
+	power &= MUSB_POWER_SUSPENDM | MUSB_POWER_RESUME;
+	musb->context.power &= ~(MUSB_POWER_SUSPENDM | MUSB_POWER_RESUME);
+	power |= musb->context.power;
+	musb_writeb(musb_base, MUSB_POWER, power);
+
 	musb_writew(musb_base, MUSB_INTRTXE, musb->intrtxe);
 	musb_writew(musb_base, MUSB_INTRRXE, musb->intrrxe);
 	musb_writeb(musb_base, MUSB_INTRUSBE, musb->context.intrusbe);
-- 
1.8.3.2
