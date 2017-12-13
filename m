From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH balbi-usb] usb: renesas_usbhs: usbhs_rcar3_notifier() can
 be static
Date: Thu, 14 Dec 2017 01:20:52 +0800
Message-ID: <20171213172052.GA27583@lkp-sb04.lkp.intel.com>
References: <201712140134.kYd2nFKY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201712140134.kYd2nFKY%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Fixes: 3a7cce26122e ("usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel")
Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 rcar3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/rcar3.c b/drivers/usb/renesas_usbhs/rcar3.c
index d657309..d0ea4ff 100644
--- a/drivers/usb/renesas_usbhs/rcar3.c
+++ b/drivers/usb/renesas_usbhs/rcar3.c
@@ -112,8 +112,8 @@ static int usbhs_rcar3_get_id(struct platform_device *pdev)
 	return USBHS_GADGET;
 }
 
-int usbhs_rcar3_notifier(struct notifier_block *nb, unsigned long event,
-			 void *data)
+static int usbhs_rcar3_notifier(struct notifier_block *nb, unsigned long event,
+				void *data)
 {
 	struct usbhs_priv *priv = container_of(nb, struct usbhs_priv, nb);
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
