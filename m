From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] USB: musb: dsps: add explicit runtime resume at suspend
Date: Wed, 26 Jul 2017 17:00:46 +0200
Message-ID: <20170726150046.22757-3-johan@kernel.org>
References: <20170726150046.22757-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726150046.22757-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The musb_dsps driver is special in that the parent (glue) device's
driver is accessing registers mapped by the child. The clock is however
shared and is managed by the grandparent device.

Since commit 869c59782981 ("usb: musb: dsps: add support for suspend and
resume") the dsps driver has been accessing these registers as part of
suspend and resume.

The parent driver obviously cannot runtime resume the child during
system suspend and is currently relying on the fact that the child will
be RPM_ACTIVE throughout suspend. The suspend implementation also makes
sure to check that the child is indeed present (and hence the clock
enabled) before accessing the registers.

Let's add an explicit runtime resume of the glue device itself to enable the
clock before doing the register accesses in case these assumptions ever change
(i.e. if the child is left runtime suspended).

Note that the glue-timer cancellation is moved after the child-presence
check to keep error handling simple. This should be fine as the timer is
not setup until the controller is being registered and at that time
glue->musb and its driver data have already been initialised.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/musb_dsps.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index bc6a9be2ccc5..f6b526606ad1 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -1015,13 +1015,20 @@ static int dsps_suspend(struct device *dev)
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	struct musb *musb = platform_get_drvdata(glue->musb);
 	void __iomem *mbase;
-
-	del_timer_sync(&glue->timer);
+	int ret;
 
 	if (!musb)
 		/* This can happen if the musb device is in -EPROBE_DEFER */
 		return 0;
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	del_timer_sync(&glue->timer);
+
 	mbase = musb->ctrl_base;
 	glue->context.control = musb_readl(mbase, wrp->control);
 	glue->context.epintr = musb_readl(mbase, wrp->epintr_set);
@@ -1060,6 +1067,8 @@ static int dsps_resume(struct device *dev)
 	    musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
 		dsps_mod_timer(glue, -1);
 
+	pm_runtime_put(dev);
+
 	return 0;
 }
 #endif
-- 
2.13.3
