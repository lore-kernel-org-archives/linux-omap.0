From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/6] HSI: omap_ssi: fix module unloading
Date: Sat, 30 Apr 2016 04:09:09 +0200
Message-ID: <1461982153-19139-3-git-send-email-sre@kernel.org>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461982153-19139-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Removal of ssi controller debugfs directory must
happen after the clients have been removed from
it.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi.c
index c582229d1cd2..2dd46b219af2 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi.c
@@ -526,6 +526,9 @@ static int __exit ssi_remove(struct platform_device *pd)
 {
 	struct hsi_controller *ssi = platform_get_drvdata(pd);
 
+	/* cleanup of of_platform_populate() call */
+	device_for_each_child(&pd->dev, NULL, ssi_remove_ports);
+
 #ifdef CONFIG_DEBUG_FS
 	ssi_debug_remove_ctrl(ssi);
 #endif
@@ -534,9 +537,6 @@ static int __exit ssi_remove(struct platform_device *pd)
 
 	pm_runtime_disable(&pd->dev);
 
-	/* cleanup of of_platform_populate() call */
-	device_for_each_child(&pd->dev, NULL, ssi_remove_ports);
-
 	return 0;
 }
 
-- 
2.8.1
