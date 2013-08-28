From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 2/3] drivers: Makefile: Extcon is a framework so bump it up
Date: Wed, 28 Aug 2013 23:03:04 +0530
Message-ID: <1377711185-31238-3-git-send-email-george.cherian@ti.com>
References: <1377711185-31238-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377711185-31238-1-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, popcornmix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Bump up the order, since extcon is a framework and needed by
other drivers. With the previous order it failed to detect
extcon device in DWC3 when both were compiled built-in.

Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index ab93de8..4573b8d 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -49,6 +49,7 @@ obj-y				+= char/
 obj-y				+= gpu/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
+obj-$(CONFIG_EXTCON)		+= extcon/
 
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
@@ -145,7 +146,6 @@ obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
 obj-$(CONFIG_HYPERV)		+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
-obj-$(CONFIG_EXTCON)		+= extcon/
 obj-$(CONFIG_MEMORY)		+= memory/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_VME_BUS)		+= vme/
-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
