From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] usb: ehci-omap: Update platform header file path
Date: Thu, 3 Dec 2009 20:23:57 -0600
Message-ID: <20091204022357.GA19315@lixom.net>
References: <20091125090259.GB30331@lixom.net> <20091125125326.GA18175@suse.de> <20091125175739.GE4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091125175739.GE4348-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP usb header file will move in the same merge window as this
driver is getting introduced in, so update the driver now instead of
making a merge-order-dependent patch later on through linux-omap.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>


---

Greg, see below for history (you were Cc:d at the time). Should have
gone to you in the first place. Sorry for the confusion. Either combine
with the ehci-omap patch, or merge separate.   Thanks!

-Olof


On Wed, Nov 25, 2009 at 09:57:39AM -0800, Tony Lindgren wrote:

> The ehci-omap.c driver should be in Greg's queue. I only have the
> the related platform init code and header changes in my for-next
> because of the omap header move from mach to plat.
> 
> IMHO, this fix would be best added to Greg's queue as the ehci-omap.c
> driver is there [1]. Or just merged into the exisiting patch
> to keep git bisect working:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Meanwhile, I'll also add this fix to omap-testing and master branches
> so people can use it until it gets merged.
> 
> Regards,
> 
> Tony
> 
> [1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-host-ehci-introduce-omap-ehci-hcd-driver.patch


diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7ba8df3..5cfed78 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,7 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <mach/usb.h>
+#include <plat/usb.h>
 
 /*
  * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
