From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] Fix sections for omap-mcbsp platform driver
Date: Wed, 24 Sep 2008 16:47:36 +0300
Message-ID: <20080924134736.GR5222@atomide.com>
References: <1222262955-13599-1-git-send-email-tony@atomide.com> <1222262955-13599-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ghzN8eJ9Qlbqn3iT"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51981 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYIXNrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:47:48 -0400
Content-Disposition: inline
In-Reply-To: <1222262955-13599-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>, Russell King <rmk+kernel@arm.linux.org.uk>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [080924 16:29]:
> From: Uwe Kleine-König <ukleinek@strlen.de>
> 
> 	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/unbind
> 	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/bind
> 
> While at it move the remove function to the .devexit.text section.

Looks like I managed to trash the subject on this one, here's a fixed
version.

Tony

--ghzN8eJ9Qlbqn3iT
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: inline; filename="0001-Don-t-use-__init-but-__devinit-to-define-probe-funct.patch"
Content-Transfer-Encoding: 8bit

>From f4ca1382337bfb1bf612fa07c2bb0207b1a5da37 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@strlen.de>
Date: Wed, 24 Sep 2008 16:13:11 +0300
Subject: [PATCH] Fix sections for omap-mcbsp platform driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Don't use __init but __devinit to define probe function.  A pointer to
omap_mcbsp_probe is passed to the core via platform_driver_register and
so the function must not disappear when the init code is freed.  Using
__init and having HOTPLUG=y the following probably oopses:

	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/unbind
	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/bind

While at it move the remove function to the .devexit.text section.

Signed-off-by: Uwe Kleine-König <ukleinek@strlen.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e63990f..e0803a8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -804,7 +804,7 @@ EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
-static int __init omap_mcbsp_probe(struct platform_device *pdev)
+static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
 	int id = pdev->id - 1;
@@ -868,7 +868,7 @@ exit:
 	return ret;
 }
 
-static int omap_mcbsp_remove(struct platform_device *pdev)
+static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 
@@ -894,7 +894,7 @@ static int omap_mcbsp_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_mcbsp_driver = {
 	.probe		= omap_mcbsp_probe,
-	.remove		= omap_mcbsp_remove,
+	.remove		= __devexit_p(omap_mcbsp_remove),
 	.driver		= {
 		.name	= "omap-mcbsp",
 	},

--ghzN8eJ9Qlbqn3iT--
