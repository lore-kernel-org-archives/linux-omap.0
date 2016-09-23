From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 7/8] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Fri, 23 Sep 2016 14:41:15 +0200
Message-ID: <c8368b2c93431981686b1f31e31571f08e39f535.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Fix module table so that the driver is loaded if compiled
as module and requested by DT.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/ads7846.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 400e421..9a5d84d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1532,6 +1532,17 @@ static int ads7846_remove(struct spi_device *spi)
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
2.7.3
