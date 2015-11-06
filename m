From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 6/7] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Fri,  6 Nov 2015 16:14:48 +0100
Message-ID: <6f37d70dcec32b3d13eb811b240f1f2556db9120.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Fix module table so that the driver is loaded if compiled
as module and requested by DT.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/ads7846.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4525f00..04d00e8 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1559,6 +1559,17 @@ static int ads7846_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id ads7846_idtable[] = {
+	{ "tsc2046", 0 },
+	{ "ads7843", 0 },
+	{ "ads7845", 0 },
+	{ "ads7846", 0 },
+	{ "ads7873", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, ads7846_idtable);
+
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name	= "ads7846",
-- 
2.5.1
