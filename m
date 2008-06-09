From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/3] tea5761: Add init and sleep callbacks on tea5761 tuner
Date: Mon,  9 Jun 2008 16:05:41 -0400
Message-ID: <1213041943-31218-2-git-send-email-edubezval@gmail.com>
References: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46422 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYFIUJx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 16:09:53 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m59K9gqr001702
	for <linux-omap@vger.kernel.org>; Mon, 9 Jun 2008 15:09:50 -0500
In-Reply-To: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Add init and sleep callbacks on tea5761 tuner

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/common/tuners/tea5761.c |   44 +++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/media/common/tuners/tea5761.c b/drivers/media/common/tuners/tea5761.c
index b93cdef..8e86cb2 100644
--- a/drivers/media/common/tuners/tea5761.c
+++ b/drivers/media/common/tuners/tea5761.c
@@ -175,6 +175,48 @@ static int set_radio_freq(struct dvb_frontend *fe,
 	return 0;
 }
 
+static int tea5761_init(struct dvb_frontend *fe)
+{
+	struct tea5761_priv *priv = fe->tuner_priv;
+	unsigned char buffer[] = {0, 0, 0, 0, 0, 0, 0 };
+	int rc;
+
+	tuner_dbg("Power up radio\n");
+
+	buffer[3] = TEA5761_TNCTRL_PUPD_0;
+
+	if (debug)
+		tea5761_status_dump(buffer);
+
+	rc = tuner_i2c_xfer_send(&priv->i2c_props, buffer, ARRAY_SIZE(buffer));
+	if (rc != ARRAY_SIZE(buffer))
+		tuner_warn("i2c i/o error: rc == %d (should be %d)\n", rc,
+				ARRAY_SIZE(buffer));
+
+	return 0;
+}
+
+static int tea5761_sleep(struct dvb_frontend *fe)
+{
+	struct tea5761_priv *priv = fe->tuner_priv;
+	unsigned char buffer[] = {0, 0, 0, 0, 0, 0, 0 };
+	int rc;
+
+	tuner_dbg("Power down radio\n");
+
+	buffer[3] &= ~TEA5761_TNCTRL_PUPD_0;
+
+	if (debug)
+		tea5761_status_dump(buffer);
+
+	rc = tuner_i2c_xfer_send(&priv->i2c_props, buffer, ARRAY_SIZE(buffer));
+	if (rc != ARRAY_SIZE(buffer))
+		tuner_warn("i2c i/o error: rc == %d (should be %d)\n", rc,
+				ARRAY_SIZE(buffer));
+
+	return 0;
+}
+
 static int tea5761_read_status(struct dvb_frontend *fe, char *buffer)
 {
 	struct tea5761_priv *priv = fe->tuner_priv;
@@ -287,6 +329,8 @@ static struct dvb_tuner_ops tea5761_tuner_ops = {
 	.get_frequency     = tea5761_get_frequency,
 	.get_status        = tea5761_get_status,
 	.get_rf_strength   = tea5761_get_rf_strength,
+	.init              = tea5761_init,
+	.sleep             = tea5761_sleep,
 };
 
 struct dvb_frontend *tea5761_attach(struct dvb_frontend *fe,
-- 
1.5.6.rc0.84.g06f60.dirty

