From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 11/19] HSI: omap_ssi_core: remove pm_runtime_get_sync call from tasklet
Date: Sat, 18 Jun 2016 18:27:01 +0200
Message-ID: <1466267229-25012-12-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

We may not call pm_runtime_get_sync() from tasklet, since
it can block once pm_runtime_irq_safe is removed for omap-ssi.

Since irq can should only be created for a running device,
we assume, that the device is already running and use non-
synchronous API instead.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 618db80577c3..79562ce65579 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -255,7 +255,13 @@ static void ssi_gdd_tasklet(unsigned long dev)
 	unsigned int lch;
 	u32 status_reg;
 
-	pm_runtime_get_sync(ssi->device.parent);
+	pm_runtime_get(ssi->device.parent);
+
+	if (!pm_runtime_active(ssi->device.parent)) {
+		dev_warn(ssi->device.parent, "ssi_gdd_tasklet called without runtime PM!\n");
+		pm_runtime_put(ssi->device.parent);
+		return;
+	}
 
 	status_reg = readl(sys + SSI_GDD_MPU_IRQ_STATUS_REG);
 	for (lch = 0; lch < SSI_MAX_GDD_LCH; lch++) {
-- 
2.8.1
