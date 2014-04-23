From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/13] tty: serial: add missing braces
Date: Wed, 23 Apr 2014 09:58:29 -0500
Message-ID: <1398265117-11793-5-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

per CodingStyle we should have those braces, no
functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 837f6c1..f456f46 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1694,8 +1694,10 @@ static int serial_omap_probe(struct platform_device *pdev)
 	    omap_up_info->DTR_present) {
 		up->DTR_gpio = omap_up_info->DTR_gpio;
 		up->DTR_inverted = omap_up_info->DTR_inverted;
-	} else
+	} else {
 		up->DTR_gpio = -EINVAL;
+	}
+
 	up->DTR_active = 0;
 
 	up->dev = &pdev->dev;
@@ -1757,6 +1759,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, up);
 	if (omap_up_info->autosuspend_timeout == 0)
 		omap_up_info->autosuspend_timeout = -1;
+
 	device_init_wakeup(up->dev, true);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-- 
1.9.2.459.g68773ac
