From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 5/5] HSI: ssi-protocol: clear carrier flag on open
Date: Sun, 31 Jan 2016 02:19:47 +0100
Message-ID: <1454203187-688-6-git-send-email-sre@kernel.org>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If the interface is just being enabled, the modem is not
yet ready to be used, so clear the carrier flag (which is
e.g. set by ifconfig and ofono).

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 3fb5b98b2c63..264f81cfa095 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -916,6 +916,8 @@ static int ssip_pn_open(struct net_device *dev)
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 	int err;
 
+	netif_carrier_off(ssi->netdev);
+
 	err = hsi_claim_port(cl, 1);
 	if (err < 0) {
 		dev_err(&cl->device, "SSI port already claimed\n");
-- 
2.7.0.rc3
