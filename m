From: =?UTF-8?q?Stefan=20S=C3=B8rensen?=
	<stefan.sorensen@spectralink.com>
Subject: [PATCH] mtd:elm: Use correct check on return value of pm_runtime_get_sync
Date: Wed,  5 Feb 2014 14:42:40 +0100
Message-ID: <1391607760-29826-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 213083164162.static.sonofon.dk ([213.83.164.162]:29032 "EHLO
	HORWDSPRD01.spectralink.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750799AbaBEOBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 09:01:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: avinashphilip@ti.com, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <stefan.sorensen@spectralink.com>

The ELM driver incorrectly reagard any non-zero return value from
pm_runtime_get_sync as an error, but it may return 1 if the device
was already active. Fix to only error when return value is negative.

Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com>
---
 drivers/mtd/devices/elm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index d1dd6a3..e2c073c 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -380,7 +380,7 @@ static int elm_probe(struct platform_device *pdev)
 	}
=20
 	pm_runtime_enable(&pdev->dev);
-	if (pm_runtime_get_sync(&pdev->dev)) {
+	if (pm_runtime_get_sync(&pdev->dev) < 0) {
 		ret =3D -EINVAL;
 		pm_runtime_disable(&pdev->dev);
 		dev_err(&pdev->dev, "can't enable clock\n");
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
