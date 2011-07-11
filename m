From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 21/22] cbus: tahvo: drop backlight interfaces
Date: Mon, 11 Jul 2011 14:17:34 +0300
Message-ID: <1310383055-20211-22-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43169 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1GKLTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:30 -0400
Received: by mail-yw0-f49.google.com with SMTP id 9so1660814ywf.36
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:30 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

they aren't used by anyone and they should
be, anyways, on a child LED driver not on
core Tahvo.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   51 +-------------------------------------------------
 drivers/cbus/tahvo.h |    3 --
 2 files changed, 1 insertions(+), 53 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 12d95ac..784431c 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -51,7 +51,6 @@ struct tahvo {
 	int		ack;
 	int		mask;
 
-	unsigned int	wide_backlight:1;
 	unsigned int	mask_pending:1;
 	unsigned int	ack_pending:1;
 	unsigned int	is_betty:1;
@@ -133,42 +132,6 @@ void tahvo_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
 	mutex_unlock(&tahvo->mutex);
 }
 
-int tahvo_get_backlight_level(void)
-{
-	struct tahvo		*tahvo = the_tahvo;
-	int			mask;
-
-	if (tahvo->wide_backlight)
-		mask = 0x7f;
-	else
-		mask = 0x0f;
-	return __tahvo_read_reg(tahvo, TAHVO_REG_LEDPWMR) & mask;
-}
-EXPORT_SYMBOL(tahvo_get_backlight_level);
-
-int tahvo_get_max_backlight_level(void)
-{
-	struct tahvo		*tahvo = the_tahvo;
-
-	if (tahvo->wide_backlight)
-		return 0x7f;
-	else
-		return 0x0f;
-}
-EXPORT_SYMBOL(tahvo_get_max_backlight_level);
-
-void tahvo_set_backlight_level(int level)
-{
-	struct tahvo		*tahvo = the_tahvo;
-	int			max_level;
-
-	max_level = tahvo_get_max_backlight_level();
-	if (level > max_level)
-		level = max_level;
-	__tahvo_write_reg(tahvo, TAHVO_REG_LEDPWMR, level);
-}
-EXPORT_SYMBOL(tahvo_set_backlight_level);
-
 static irqreturn_t tahvo_irq_handler(int irq, void *_tahvo)
 {
 	struct tahvo		*tahvo = _tahvo;
@@ -379,20 +342,8 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 
 	id = (rev >> 8) & 0xff;
 
-	switch (id) {
-	case 0x03:
-		if ((rev & 0xff) >= 0x50)
-			tahvo->wide_backlight = true;
-		break;
-	case 0x0b:
+	if (id == 0x0b)
 		tahvo->is_betty = true;
-		tahvo->wide_backlight = true;
-		break;
-	default:
-		dev_err(&pdev->dev, "Tahvo/Betty chip not found");
-		ret = -ENODEV;
-		goto err2;
-	}
 
 	ret = tahvo_allocate_children(&pdev->dev, tahvo->irq_base);
 	if (ret < 0) {
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index 1281710..f151a43 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -54,8 +54,5 @@ int tahvo_read_reg(struct device *child, unsigned reg);
 void tahvo_write_reg(struct device *child, unsigned reg, u16 val);
 void tahvo_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
 		u16 clear);
-int tahvo_get_backlight_level(void);
-int tahvo_get_max_backlight_level(void);
-void tahvo_set_backlight_level(int level);
 
 #endif /* __DRIVERS_CBUS_TAHVO_H */
-- 
1.7.6

