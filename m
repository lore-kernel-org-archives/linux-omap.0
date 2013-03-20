From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 07/10] gpio: gpio-stp-xway.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:16:01 +0100
Message-ID: <1363781764-17330-8-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-stp-xway.c:220: ERROR: trailing whitespace

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-stp-xway.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index c20e051..04882a9 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -217,7 +217,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	chip->virt = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(chip->virt))
 		return PTR_ERR(chip->virt);
-	
+
 	chip->gc.dev = &pdev->dev;
 	chip->gc.label = "stp-xway";
 	chip->gc.direction_output = xway_stp_dir_out;
-- 
1.7.10.4
