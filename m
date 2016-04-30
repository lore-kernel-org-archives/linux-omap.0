From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4/6] HSI: omap_ssi: fix removal of port platform device
Date: Sat, 30 Apr 2016 04:09:11 +0200
Message-ID: <1461982153-19139-5-git-send-email-sre@kernel.org>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461982153-19139-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This avoids removal of the HSI port device when
only the platform port device should be removed
and clears the POPULATED bit in the DT node, so
that a new platform device is created when the
driver is probed again.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi.c
index ffb921482e76..68dfdaa19938 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi.c
@@ -451,6 +451,10 @@ static int ssi_remove_ports(struct device *dev, void *c)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 
+	if (!dev->of_node)
+		return 0;
+
+	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_device_unregister(pdev);
 
 	return 0;
-- 
2.8.1
