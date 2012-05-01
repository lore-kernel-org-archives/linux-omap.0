From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 29/39] ARM: OMAP2+: board n8x0: gpmc driver adaptation
Date: Tue, 1 May 2012 17:52:53 +0530
Message-ID: <afbabad89b7e0b303cbd6c92dd8661531041e390.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335874494.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-n8x0.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 94f6077..d3d866a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -36,6 +36,7 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -45,6 +46,13 @@
 #define TUSB6010_GPIO_ENABLE	0
 #define TUSB6010_DMACHAN	0x3f
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
 /*
  * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
@@ -114,10 +122,12 @@ static void __init n8x0_usb_init(void)
 	}
 	tusb_set_power(0);
 
-	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
+	*gpmc_cur = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
 					TUSB6010_ASYNC_CS, TUSB6010_SYNC_CS,
 					TUSB6010_GPIO_INT, TUSB6010_DMACHAN);
-	if (ret != 0)
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
 		goto err;
 
 	printk(announce);
@@ -785,7 +795,9 @@ static void __init n8x0_init_machine(void)
 					ARRAY_SIZE(n810_i2c_board_info_2));
 	board_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	gpmc_onenand_init(board_onenand_data);
+	*gpmc_cur++ = gpmc_onenand_init(board_onenand_data);
+	gpmc_data.num_device++;
+	omap_init_gpmc(&gpmc_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
 }
-- 
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
