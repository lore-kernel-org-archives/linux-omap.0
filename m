From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] OMAPDSS: Add terminating entry for picodlp_i2c_id table
Date: Fri, 30 Nov 2012 12:30:45 +0800
Message-ID: <1354249845.18712.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Mythri P K <mythripk@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The i2c_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/omap2/displays/panel-picodlp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index e3a6c19..1b94018 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -50,6 +50,7 @@ struct picodlp_i2c_data {
 
 static struct i2c_device_id picodlp_i2c_id[] = {
 	{ "picodlp_i2c_driver", 0 },
+	{ }
 };
 
 struct picodlp_i2c_command {
-- 
1.7.9.5
