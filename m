From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4/5] HSI: ssi-protocol: Use handshake logic from n950
Date: Sun, 17 Jan 2016 16:49:08 +0100
Message-ID: <1453045749-22642-5-git-send-email-sre@kernel.org>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453045749-22642-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When using the ssi-protocol driver with the Nokia N950, the
following error is thrown during modem powered up sequence.

[13852.274993]  port0: SSI error: 0x01
[13852.279205] ssi-protocol ssi-protocol: RX error detected
[13852.284820] ssi-protocol ssi-protocol: Main state: 1
[13852.290069] ssi-protocol ssi-protocol: Recv state: 0
[13852.295288] ssi-protocol ssi-protocol: Send state: 0
[13852.300537] ssi-protocol ssi-protocol: CMT Offline
[13852.305603] ssi-protocol ssi-protocol: Wake test 1
[13852.310638] ssi-protocol ssi-protocol: Data RX id: 0
[13852.315887] ssi-protocol ssi-protocol: Data TX id: 0
[13856.001464] ssi-protocol ssi-protocol: Watchdog trigerred
[13856.007293] ssi-protocol ssi-protocol: Main state: 1
[13856.012542] ssi-protocol ssi-protocol: Recv state: 0
[13856.017761] ssi-protocol ssi-protocol: Send state: 0
[13856.023010] ssi-protocol ssi-protocol: CMT Offline
[13856.028045] ssi-protocol ssi-protocol: Wake test 0
[13856.033111] ssi-protocol ssi-protocol: Data RX id: 0
[13856.038330] ssi-protocol ssi-protocol: Data TX id: 0

This patch fixes the issue by using the handshake setup from
the Nokia N950 kernel. The new handshake sequence also works
with the N900, so there is no need to differentiate between
both modems.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index a38af68cf326..6595d2091268 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -521,13 +521,7 @@ static void ssip_start_rx(struct hsi_client *cl)
 	 * high transition. Therefore we need to ignore the sencond UP event.
 	 */
 	if ((ssi->main_state != ACTIVE) || (ssi->recv_state == RECV_READY)) {
-		if (ssi->main_state == INIT) {
-			ssi->main_state = HANDSHAKE;
-			spin_unlock(&ssi->lock);
-			ssip_send_bootinfo_req_cmd(cl);
-		} else {
-			spin_unlock(&ssi->lock);
-		}
+		spin_unlock(&ssi->lock);
 		return;
 	}
 	ssip_set_rxstate(ssi, RECV_READY);
@@ -671,6 +665,7 @@ static void ssip_rx_bootinforeq(struct hsi_client *cl, u32 cmd)
 		ssip_error(cl);
 		/* Fall through */
 	case INIT:
+	case HANDSHAKE:
 		spin_lock(&ssi->lock);
 		ssi->main_state = HANDSHAKE;
 		if (!ssi->waketest) {
@@ -688,9 +683,6 @@ static void ssip_rx_bootinforeq(struct hsi_client *cl, u32 cmd)
 		msg->complete = ssip_release_cmd;
 		hsi_async_write(cl, msg);
 		break;
-	case HANDSHAKE:
-		/* Ignore */
-		break;
 	default:
 		dev_dbg(&cl->device, "Wrong state M(%d)\n", ssi->main_state);
 		break;
@@ -939,9 +931,11 @@ static int ssip_pn_open(struct net_device *dev)
 		ssi->waketest = 1;
 		ssi_waketest(cl, 1); /* FIXME: To be removed */
 	}
-	ssi->main_state = INIT;
+	ssi->main_state = HANDSHAKE;
 	spin_unlock_bh(&ssi->lock);
 
+	ssip_send_bootinfo_req_cmd(cl);
+
 	return 0;
 }
 
-- 
2.7.0.rc3
