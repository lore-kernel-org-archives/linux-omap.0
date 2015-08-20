From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 04/18] OMAPDSS: panel-sony-acx565akm: Export OF module alias information
Date: Thu, 20 Aug 2015 09:07:17 +0200
Message-ID: <1440054451-1223-5-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
regardless of the mechanism that was used to register the device
(i.e: OF or board code) and the table that is used later to match
the driver with the device (i.e: SPI id table or OF match table).

So drivers needs to export the SPI id table and this be built into
the module or udev won't have the necessary information to autoload
the needed driver module when the device is added.

But this means that OF-only drivers needs to have both OF and SPI id
tables that have to be kept in sync and also the dev node compatible
manufacturer prefix is stripped when reporting the MODALIAS. Which can
lead to issues if two vendors use the same SPI device name for example.

To avoid the above, the SPI core behavior may be changed in the future
to not require an SPI device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table even when
is unused now to prevent breaking module loading when the core changes.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 90cbc4c3406c..c581231c74a5 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -898,6 +898,7 @@ static const struct of_device_id acx565akm_of_match[] = {
 	{ .compatible = "omapdss,sony,acx565akm", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, acx565akm_of_match);
 
 static struct spi_driver acx565akm_driver = {
 	.driver = {
-- 
2.4.3
