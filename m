From: <jgq516@gmail.com>
Subject: [PATCHv2 3/3] watchdog: omap_wdt: add device tree support
Date: Fri, 1 Jun 2012 12:44:16 +0800
Message-ID: <1338525856-4359-4-git-send-email-jgq516@gmail.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, wim@iguana.be, jon-hunter@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

Add device table for omap_wdt to support dt.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 drivers/watchdog/omap_wdt.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 8285d65..02ebfd5 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -430,6 +430,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
 #define	omap_wdt_resume		NULL
 #endif
 
+static const struct of_device_id omap_wdt_of_match[] = {
+	{ .compatible = "ti,omap3-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
+
 static struct platform_driver omap_wdt_driver = {
 	.probe		= omap_wdt_probe,
 	.remove		= __devexit_p(omap_wdt_remove),
@@ -439,6 +445,7 @@ static struct platform_driver omap_wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "omap_wdt",
+		.of_match_table = omap_wdt_of_match,
 	},
 };
 
-- 
1.7.3

