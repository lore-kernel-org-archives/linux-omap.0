From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] rtc: rtc-twl: Fix missing device_init_wakeup() when booted
 with device tree
Date: Tue, 21 May 2013 14:40:27 -0700
Message-ID: <20130521214026.GV10378@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

When booted in legacy mode device_init_wakeup() gets called
by drivers/mfd/twl-core.c when the children are initialized.
However, when booted using device tree, the children are
created with of_platform_populate() instead add_children().

This means that the RTC driver will not have device_init_wakeup()
set, and we need to call it from the driver probe like RTC drivers
typically do.

Without this we cannot test PM wake-up events on omaps for
cases where there may not be any physical wake-up event.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This fix is for the -rc cycle please.

--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -524,6 +524,7 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, rtc);
+	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 
 out2:
