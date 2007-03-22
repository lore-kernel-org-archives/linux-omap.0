From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/4] TSC2301 touchscreen: fix error path in driver probe
 function
Date: Thu, 22 Mar 2007 11:14:47 +0200
Message-ID: <20070322111447.5379b54c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__22_Mar_2007_11_14_47_+0200_VGRc_=m634_Xg1Dp"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__22_Mar_2007_11_14_47_+0200_VGRc_=m634_Xg1Dp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Patch from Imre.

--Multipart=_Thu__22_Mar_2007_11_14_47_+0200_VGRc_=m634_Xg1Dp
Content-Type: text/plain;
	name="0001-TSC2301-touchscreen-fix-error-path-in-driver-probe-function.txt"
Content-Disposition: attachment;
	filename="0001-TSC2301-touchscreen-fix-error-path-in-driver-probe-function.txt"
Content-Transfer-Encoding: 7bit

>From a24e92946d20026e7d982c53abf816d5bf142df7 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Mon, 12 Mar 2007 17:46:25 +0200
Subject: [PATCH] TSC2301 touchscreen: fix error path in driver probe function

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/spi/tsc2301-ts.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/tsc2301-ts.c b/drivers/spi/tsc2301-ts.c
index da91736..8657b56 100644
--- a/drivers/spi/tsc2301-ts.c
+++ b/drivers/spi/tsc2301-ts.c
@@ -629,19 +629,23 @@ int __devinit tsc2301_ts_init(struct tsc2301 *tsc,
 	}
 	set_irq_wake(ts->irq, 1);
 
-	device_create_file(&tsc->spi->dev, &dev_attr_pen_down);
-	device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	if (device_create_file(&tsc->spi->dev, &dev_attr_pen_down) < 0)
+		goto err4;
+	if (device_create_file(&tsc->spi->dev, &dev_attr_disable_ts) < 0)
+		goto err5;
 
 	r = input_register_device(idev);
 	if (r < 0) {
 		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
-		goto err4;
+		goto err6;
 	}
 
 	return 0;
-err4:
+err6:
 	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+err5:
 	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+err4:
 	free_irq(ts->irq, tsc);
 err3:
 	tsc2301_ts_stop_scan(tsc);
-- 
1.4.4.4


--Multipart=_Thu__22_Mar_2007_11_14_47_+0200_VGRc_=m634_Xg1Dp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Multipart=_Thu__22_Mar_2007_11_14_47_+0200_VGRc_=m634_Xg1Dp--
