From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 14/19] HSI: omap_ssi_port: avoid calling runtime_pm_*_sync inside spinlock
Date: Sat, 18 Jun 2016 18:27:04 +0200
Message-ID: <1466267229-25012-15-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

runtime_pm_*_sync can block when irq_safe flag is removed
from omap-ssi driver, so it may not be called while a
spinlock is held.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index f7ed59ba3b2c..92064221dbab 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -767,13 +767,12 @@ static int ssi_release(struct hsi_client *cl)
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
 	struct hsi_controller *ssi = to_hsi_controller(port->device.parent);
 
-	spin_lock_bh(&omap_port->lock);
 	pm_runtime_get_sync(omap_port->pdev);
+	spin_lock_bh(&omap_port->lock);
 	/* Stop all the pending DMA requests for that client */
 	ssi_cleanup_gdd(ssi, cl);
 	/* Now cleanup all the queues */
 	ssi_cleanup_queues(cl);
-	pm_runtime_put_sync(omap_port->pdev);
 	/* If it is the last client of the port, do extra checks and cleanup */
 	if (port->claimed <= 1) {
 		/*
@@ -782,15 +781,16 @@ static int ssi_release(struct hsi_client *cl)
 		 */
 		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags))
 			pm_runtime_put_sync(omap_port->pdev);
-		pm_runtime_get_sync(omap_port->pdev);
+		pm_runtime_get(omap_port->pdev);
 		/* Stop any SSI TX/RX without a client */
 		ssi_set_port_mode(omap_port, SSI_MODE_SLEEP);
 		omap_port->sst.mode = SSI_MODE_SLEEP;
 		omap_port->ssr.mode = SSI_MODE_SLEEP;
-		pm_runtime_put_sync(omap_port->pdev);
+		pm_runtime_put(omap_port->pdev);
 		WARN_ON(omap_port->wk_refcount != 0);
 	}
 	spin_unlock_bh(&omap_port->lock);
+	pm_runtime_put_sync(omap_port->pdev);
 
 	return 0;
 }
-- 
2.8.1
