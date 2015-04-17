From: pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] omap: i2c: Add calls for pinctrl state select
Date: Fri, 17 Apr 2015 17:07:57 +0200
Message-ID: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This adds calls to pinctrl subsystem in order to switch pin states
on suspend/resume if you provide a "sleep" state in DT.

Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e89419..6b5d4bd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1423,6 +1423,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
 	}

+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }

@@ -1431,6 +1433,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);

+	pinctrl_pm_select_default_state(dev);
+
 	if (!_dev->regs)
 		return 0;

--
1.9.3
