From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 19/27] cbus: tahvo: drop more unused interfaces
Date: Thu, 13 Oct 2011 11:34:54 +0300
Message-ID: <1318494902-13093-19-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:58766 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904Ab1JMIfp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:45 -0400
Received: by bkat2 with SMTP id t2so1426004bka.18
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:43 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we have the IRQ chip which is the standard
way of handling IRQs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 2597672..8192a24 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -129,40 +129,6 @@ void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 	mutex_unlock(&tahvo->mutex);
 }
 
-void tahvo_disable_irq(int id)
-{
-	struct tahvo		*tahvo = the_tahvo;
-	u16			mask;
-
-	mutex_lock(&tahvo->mutex);
-	mask = __tahvo_read_reg(tahvo, TAHVO_REG_IMR);
-	mask |= 1 << id;
-	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, mask);
-	mutex_unlock(&tahvo->mutex);
-}
-EXPORT_SYMBOL(tahvo_disable_irq);
-
-void tahvo_enable_irq(int id)
-{
-	struct tahvo		*tahvo = the_tahvo;
-	u16			mask;
-
-	mutex_lock(&tahvo->mutex);
-	mask = __tahvo_read_reg(tahvo, TAHVO_REG_IMR);
-	mask &= ~(1 << id);
-	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, mask);
-	mutex_unlock(&tahvo->mutex);
-}
-EXPORT_SYMBOL(tahvo_enable_irq);
-
-void tahvo_ack_irq(int id)
-{
-	struct tahvo		*tahvo = the_tahvo;
-
-	__tahvo_write_reg(tahvo, TAHVO_REG_IDR, 1 << id);
-}
-EXPORT_SYMBOL(tahvo_ack_irq);
-
 int tahvo_get_backlight_level(void)
 {
 	struct tahvo		*tahvo = the_tahvo;
-- 
1.7.6.396.ge0613

