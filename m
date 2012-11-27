From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: musb: dsps: header movement build error fix
Date: Tue, 27 Nov 2012 20:15:22 +0530
Message-ID: <1354027522-32485-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"54db6ee ARM: OMAP2+: Introduce local usb.h" moved control module bit
definitions from plat/usb.h (which dsps glue was using) to a local
header in mach-omap2. And in parallel,
"c68bb4c usb: musb: dsps: control module handling (quirk)" added
control module handling capability to dsps glue driver that used
those control module bit definitions.

Integration of above two changes would cause build error in musb dsps
glue driver (they go through different trees upstream) as is seen now
in linux-next. Fix it by adding necessary definitions in dsps glue
driver.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---

Hi Felipe,

This applies on top of your musb branch, please help this reach
mainline along with other musb dsps changes for coming merge window
so that they would not cause build error and so that we can have a
working usb in mainline for am335x (beaglebone) at the earliest.

Regards
Afzal

 drivers/usb/musb/musb_dsps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e6f2ae8..f7d764d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -134,6 +134,11 @@ static const resource_size_t dsps_control_module_phys[] = {
 	DSPS_AM33XX_CONTROL_MODULE_PHYS_1,
 };
 
+#define USBPHY_CM_PWRDN		(1 << 0)
+#define USBPHY_OTG_PWRDN	(1 << 1)
+#define USBPHY_OTGVDET_EN	(1 << 19)
+#define USBPHY_OTGSESSEND_EN	(1 << 20)
+
 /**
  * musb_dsps_phy_control - phy on/off
  * @glue: struct dsps_glue *
-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
