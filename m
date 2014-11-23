From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/1] video: fbdev-OMAP2: Deletion of unnecessary checks before
 the function call "i2c_put_adapter"
Date: Sun, 23 Nov 2014 14:14:10 +0100
Message-ID: <5471DDA2.1060000@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:51592 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaKWNOe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Nov 2014 08:14:34 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 23 Nov 2014 14:07:22 +0100

The i2c_put_adapter() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap2/displays-new/connector-dvi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
index 74de2bc..196c61a 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
@@ -262,8 +262,7 @@ static int dvic_probe_pdata(struct platform_device *pdev)
 
 	in = omap_dss_find_output(pdata->source);
 	if (in == NULL) {
-		if (ddata->i2c_adapter)
-			i2c_put_adapter(ddata->i2c_adapter);
+		i2c_put_adapter(ddata->i2c_adapter);
 
 		dev_err(&pdev->dev, "Failed to find video source\n");
 		return -EPROBE_DEFER;
@@ -352,8 +351,7 @@ static int dvic_probe(struct platform_device *pdev)
 err_reg:
 	omap_dss_put_device(ddata->in);
 
-	if (ddata->i2c_adapter)
-		i2c_put_adapter(ddata->i2c_adapter);
+	i2c_put_adapter(ddata->i2c_adapter);
 
 	return r;
 }
@@ -371,8 +369,7 @@ static int __exit dvic_remove(struct platform_device *pdev)
 
 	omap_dss_put_device(in);
 
-	if (ddata->i2c_adapter)
-		i2c_put_adapter(ddata->i2c_adapter);
+	i2c_put_adapter(ddata->i2c_adapter);
 
 	return 0;
 }
-- 
2.1.3

