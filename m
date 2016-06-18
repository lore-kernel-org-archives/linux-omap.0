From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 19/19] HSI: omap_ssi: drop pm_runtime_irq_safe
Date: Sat, 18 Jun 2016 18:27:09 +0200
Message-ID: <1466267229-25012-20-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

pm_runtime_irq_safe increases the parents runtime usage
counter effectively keeping the OMAP SoC from idling.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_core.c | 1 -
 drivers/hsi/controllers/omap_ssi_port.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 506a9f1ef7ad..9a29b34ed2c8 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -543,7 +543,6 @@ static int ssi_probe(struct platform_device *pd)
 	if (err < 0)
 		goto out1;
 
-	pm_runtime_irq_safe(&pd->dev);
 	pm_runtime_enable(&pd->dev);
 
 	err = ssi_hw_init(ssi);
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index f95efabc27b0..7765de2f1ef1 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1236,8 +1236,6 @@ static int ssi_port_probe(struct platform_device *pd)
 	spin_lock_init(&omap_port->wk_lock);
 	omap_port->dev = &port->device;
 
-	pm_runtime_irq_safe(omap_port->pdev);
-
 	pm_runtime_use_autosuspend(omap_port->pdev);
 	pm_runtime_set_autosuspend_delay(omap_port->pdev, 250);
 	pm_runtime_enable(omap_port->pdev);
-- 
2.8.1
