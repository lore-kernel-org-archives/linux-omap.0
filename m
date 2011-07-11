From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 19/22] cbus: tahvo: drop more unused interfaces
Date: Mon, 11 Jul 2011 14:17:32 +0300
Message-ID: <1310383055-20211-20-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58220 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1GKLTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:20 -0400
Received: by mail-gx0-f181.google.com with SMTP id 9so1684765gxk.12
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:20 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

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
1.7.6

