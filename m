From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v11 4/8] arm: omap3: twl: add phy consumer data in twl4030_usb_data
Date: Wed, 21 Aug 2013 11:16:09 +0530
Message-ID: <1377063973-22044-5-git-send-email-kishon@ti.com>
References: <1377063973-22044-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377063973-22044-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The PHY framework uses the phy consumer data populated in platform data in the
case of non-dt boot to return the reference to the PHY when the controller
(PHY consumer) requests for it. So populated the phy consumer data in the platform
data of twl usb.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/twl-common.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index c05898f..b0d54da 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -24,6 +24,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/gpio.h>
 #include <linux/string.h>
+#include <linux/phy/phy.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
@@ -90,8 +91,18 @@ void __init omap_pmic_late_init(void)
 }
 
 #if defined(CONFIG_ARCH_OMAP3)
+struct phy_consumer consumers[] = {
+	PHY_CONSUMER("musb-hdrc.0", "usb"),
+};
+
+struct phy_init_data init_data = {
+	.consumers = consumers,
+	.num_consumers = ARRAY_SIZE(consumers),
+};
+
 static struct twl4030_usb_data omap3_usb_pdata = {
 	.usb_mode	= T2_USB_MODE_ULPI,
+	.init_data	= &init_data,
 };
 
 static int omap3_batt_table[] = {
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
