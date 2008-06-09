From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/3] tea5761 tuner: fix registers utilization
Date: Mon,  9 Jun 2008 16:05:42 -0400
Message-ID: <1213041943-31218-3-git-send-email-edubezval@gmail.com>
References: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
 <1213041943-31218-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46459 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbYFIUKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 16:10:04 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m59JtTZ2022316
	for <linux-omap@vger.kernel.org>; Mon, 9 Jun 2008 15:10:02 -0500
In-Reply-To: <1213041943-31218-2-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Fix registers utilization.
tnctrl register was supposed to be used but it was
right shifted. frqset also was being configured using
incorrect equation.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/common/tuners/tea5761.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/tuners/tea5761.c b/drivers/media/common/tuners/tea5761.c
index 8e86cb2..b3d4786 100644
--- a/drivers/media/common/tuners/tea5761.c
+++ b/drivers/media/common/tuners/tea5761.c
@@ -101,6 +101,8 @@ struct tea5761_priv {
 
 	/* All zero = no test mode */
 
+#define TEA5761_TESTREG_TRIGFR		0x08
+
 /* MANID - Read: bytes 12 and 13 */
 
 	/* First byte - should be 0x10 */
@@ -147,20 +149,21 @@ static int set_radio_freq(struct dvb_frontend *fe,
 
 	if (params->mode == T_STANDBY) {
 		tuner_dbg("TEA5761 set to standby mode\n");
-		buffer[5] |= TEA5761_TNCTRL_MU;
+		buffer[4] |= TEA5761_TNCTRL_MU;
 	} else {
-		buffer[4] |= TEA5761_TNCTRL_PUPD_0;
+		buffer[3] |= TEA5761_TNCTRL_PUPD_0;
 	}
 
+	buffer[5] = TEA5761_TESTREG_TRIGFR;
 
 	if (params->audmode == V4L2_TUNER_MODE_MONO) {
 		tuner_dbg("TEA5761 set to mono\n");
-		buffer[5] |= TEA5761_TNCTRL_MST;
+		buffer[4] |= TEA5761_TNCTRL_MST;
 	} else {
 		tuner_dbg("TEA5761 set to stereo\n");
 	}
 
-	div = (1000 * (frq * 4 / 16 + 700 + 225) ) >> 15;
+	div = (frq * 125 / 2 - 225000) >> 13;
 	buffer[1] = (div >> 8) & 0x3f;
 	buffer[2] = div & 0xff;
 
-- 
1.5.6.rc0.84.g06f60.dirty

