From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] serial: omap: suspend device on probe errors
Date: Mon, 10 Apr 2017 11:21:39 +0200
Message-ID: <20170410092139.11441-2-johan@kernel.org>
References: <20170410092139.11441-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410092139.11441-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Shubhrajyoti D <shubhrajyoti@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Make sure to actually suspend the device before returning after a failed
(or deferred) probe.

Note that autosuspend must be disabled before runtime pm is disabled in
order to balance the usage count due to a negative autosuspend delay as
well as to make the final put suspend the device synchronously.

Fixes: 388bc2622680 ("omap-serial: Fix the error handling in the omap_serial probe")
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/omap-serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 8c2086e14b51..e4210b9ad0d3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1767,7 +1767,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_port:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_qos_remove_request(&up->pm_qos_request);
 	device_init_wakeup(up->dev, false);
-- 
2.12.2
