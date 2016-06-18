From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 01/19] HSI: omap_ssi_port: remove useless newline
Date: Sat, 18 Jun 2016 18:26:51 +0200
Message-ID: <1466267229-25012-2-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 6b8f7739768a..38388442e310 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1018,8 +1018,7 @@ static irqreturn_t ssi_wake_isr(int irq __maybe_unused, void *ssi_port)
 	return IRQ_HANDLED;
 }
 
-static int ssi_port_irq(struct hsi_port *port,
-						struct platform_device *pd)
+static int ssi_port_irq(struct hsi_port *port, struct platform_device *pd)
 {
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
 	int err;
@@ -1040,8 +1039,7 @@ static int ssi_port_irq(struct hsi_port *port,
 	return err;
 }
 
-static int ssi_wake_irq(struct hsi_port *port,
-						struct platform_device *pd)
+static int ssi_wake_irq(struct hsi_port *port, struct platform_device *pd)
 {
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
 	int cawake_irq;
-- 
2.8.1
