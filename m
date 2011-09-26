From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] am335xevm: Add support for musb interface
Date: Mon, 26 Sep 2011 15:33:11 +0530
Message-ID: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding musb support in am335x EVM board file.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
These three patches are dependent on my patch set on musb support
for ti81xx recently at [1] and am33xx base port patches from
Vaibhav Hiremath at [2].

[1] http://marc.info/?l=linux-omap&m=131557610318645&w=2
[2] http://marc.info/?l=linux-omap&m=131652916305543&w=2

musb interface on am33xx is exactly same as ti81xx platform and so uses
same glue driver as is.

 arch/arm/mach-omap2/board-am335xevm.c |    9 +++++++++
 arch/arm/mach-omap2/usb-musb.c        |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
index a4102ef..298dc51 100644
--- a/arch/arm/mach-omap2/board-am335xevm.c
+++ b/arch/arm/mach-omap2/board-am335xevm.c
@@ -24,6 +24,14 @@
 #include <plat/irqs.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
+
+static struct omap_musb_board_data musb_board_data = {
+	.set_phy_power	= ti81xx_musb_phy_power,
+	.interface_type	= MUSB_INTERFACE_ULPI,
+	.mode           = MUSB_OTG,
+	.power		= 500,
+};
 
 #include "mux.h"
 
@@ -73,6 +81,7 @@ static void __init am335x_evm_init(void)
 	omap_sdrc_init(NULL, NULL);
 	omap_board_config = am335x_evm_config;
 	omap_board_config_size = ARRAY_SIZE(am335x_evm_config);
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init am335x_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 4ad8e0e..cfc1443 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -143,7 +143,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
-	} else if (cpu_is_ti81xx()) {
+	} else if (cpu_is_ti81xx() || cpu_is_am335x()) {
 		musb_config.multipoint = 0;
 		oh_name = "usb_otg_hs";
 		name = "musb-ti81xx";
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
