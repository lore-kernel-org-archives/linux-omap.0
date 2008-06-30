From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: [PATCH] CBUS: A workaround for ADC S/H HW bug: always keep ch 8 selected when S/H is used
Date: Mon, 30 Jun 2008 16:28:17 +0300
Message-ID: <1214832497-23911-1-git-send-email-mikko.k.ylinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20905 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413AbYF3N2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 09:28:33 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5UDSKZo019229
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 16:28:30 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>
---
 drivers/cbus/retu.c |   12 ++++++++++++
 drivers/cbus/retu.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 715b88d..4849841 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -114,9 +114,21 @@ int retu_read_adc(int channel)
 		return -EINVAL;
 
 	spin_lock_irqsave(&retu_lock, flags);
+
+	if ((channel == 8) && retu_is_vilma) {
+		int scr = retu_read_reg(RETU_REG_ADCSCR);
+		int ch = (retu_read_reg(RETU_REG_ADCR) >> 10) & 0xf;
+		if (((scr & 0xff) != 0) && (ch != 8))
+			retu_write_reg (RETU_REG_ADCSCR, (scr & ~0xff));
+	}
+
 	/* Select the channel and read result */
 	retu_write_reg(RETU_REG_ADCR, channel << 10);
 	res = retu_read_reg(RETU_REG_ADCR) & 0x3ff;
+
+	if (retu_is_vilma)
+		retu_write_reg(RETU_REG_ADCR, (1 << 13));
+
 	/* Unlock retu */
 	spin_unlock_irqrestore(&retu_lock, flags);
 
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index 49f23e6..c9e044c 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -34,6 +34,7 @@
 #define RETU_REG_RTCHMAR	0x05	/* RTC hours and minutes alarm and time set register */
 #define RETU_REG_RTCCALR	0x06	/* RTC calibration register */
 #define RETU_REG_ADCR		0x08	/* ADC result */
+#define RETU_REG_ADCSCR		0x09	/* ADC sample ctrl */
 #define RETU_REG_CC1		0x0d	/* Common control register 1 */
 #define RETU_REG_CC2		0x0e	/* Common control register 2 */
 #define RETU_REG_CTRL_CLR	0x0f	/* Regulator clear register */
-- 
1.5.5.2

