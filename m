From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 16/19] HSI: omap_ssi_port: ensure clocks are kept enabled during transfer
Date: Sat, 18 Jun 2016 18:27:06 +0200
Message-ID: <1466267229-25012-17-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

ensure, that clocks remain enabled, when a transfer is started.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index aef5a8666d48..f91c6a4bb1a5 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -645,6 +645,7 @@ static void ssi_transfer(struct omap_ssi_port *omap_port,
 	struct hsi_msg *msg;
 	int err = -1;
 
+	pm_runtime_get(omap_port->pdev);
 	spin_lock_bh(&omap_port->lock);
 	while (err < 0) {
 		err = ssi_start_transfer(queue);
@@ -659,6 +660,7 @@ static void ssi_transfer(struct omap_ssi_port *omap_port,
 		}
 	}
 	spin_unlock_bh(&omap_port->lock);
+	pm_runtime_put(omap_port->pdev);
 }
 
 static void ssi_cleanup_queues(struct hsi_client *cl)
-- 
2.8.1
