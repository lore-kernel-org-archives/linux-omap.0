From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
Date: Sat, 30 Jun 2018 16:03:14 +0530
Message-ID: <20180630103318.25355-2-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently tscadc MFD is marked as wakeup capable which incorrect
because, its actually touch event by child TSC device that wakes up the
system. Therefore, remove device_init_wakeup() call that marks TSCADC
device as wakeup capable in favor of moving to mark TSC input device as
wakeup capable later.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 47012c0899cd..858c1a071a81 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -270,7 +270,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_disable_clk;
 
-	device_init_wakeup(&pdev->dev, true);
 	platform_set_drvdata(pdev, tscadc);
 	return 0;
 
-- 
2.18.0
