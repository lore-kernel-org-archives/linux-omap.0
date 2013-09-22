From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/4] usb: musb: omap2430: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 16:43:18 +0200
Message-ID: <1379860999-7106-3-git-send-email-zonque@gmail.com>
References: <1379860999-7106-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379860999-7106-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This makes omap2430_pm_ops const and will stub the struct out in case
CONFIG_PM_SLEEP is not set.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 59d2245..be42460 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -659,17 +659,12 @@ static int omap2430_runtime_resume(struct device *dev)
 
 	return 0;
 }
-
-static struct dev_pm_ops omap2430_pm_ops = {
-	.runtime_suspend = omap2430_runtime_suspend,
-	.runtime_resume = omap2430_runtime_resume,
-};
