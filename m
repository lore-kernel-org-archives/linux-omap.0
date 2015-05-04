From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] HSI: nokia-modem: Reduce missing driver message to debug level
Date: Mon,  4 May 2015 16:00:17 +0200
Message-ID: <1430748017-17755-1-git-send-email-sre@kernel.org>
References: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:34031 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbEDOAd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 10:00:33 -0400
In-Reply-To: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

Reduce message priority from dev_err to dev_dbg for missing cmt-speech
or ssi-protocol drivers, since they will be probed again and it may
result in spamming the boot log.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/nokia-modem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index bbb1923..f50d110 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -208,7 +208,7 @@ static int nokia_modem_probe(struct device *dev)
 
 	err = device_attach(&modem->ssi_protocol->device);
 	if (err == 0) {
-		dev_err(dev, "Missing ssi-protocol driver\n");
+		dev_dbg(dev, "Missing ssi-protocol driver\n");
 		err = -EPROBE_DEFER;
 		goto error3;
 	} else if (err < 0) {
@@ -231,7 +231,7 @@ static int nokia_modem_probe(struct device *dev)
 
 	err = device_attach(&modem->cmt_speech->device);
 	if (err == 0) {
-		dev_err(dev, "Missing cmt-speech driver\n");
+		dev_dbg(dev, "Missing cmt-speech driver\n");
 		err = -EPROBE_DEFER;
 		goto error4;
 	} else if (err < 0) {
-- 
2.1.4

