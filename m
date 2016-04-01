From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
Date: Fri, 01 Apr 2016 16:59:16 +0530
Message-ID: <1459510156-9147-2-git-send-email-gautam.vivek@samsung.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1459510156-9147-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

mach-spear enables PHY_ST_SPEAR1310_MIPHY and
PHY_ST_SPEAR1340_MIPHY, which now fall under PHY_PLAT
config. So select CONFIG_PHY_PLAT as well to resolve
dependencies.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-spear/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ea9ea95..c0a62fd 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -29,6 +29,7 @@ if ARCH_SPEAR13XX
 config MACH_SPEAR1310
 	bool "SPEAr1310 Machine support with Device Tree"
 	select PINCTRL_SPEAR1310
+	select PHY_PLAT
 	select PHY_ST_SPEAR1310_MIPHY
 	help
 	  Supports ST SPEAr1310 machine configured via the device-tree
@@ -36,6 +37,7 @@ config MACH_SPEAR1310
 config MACH_SPEAR1340
 	bool "SPEAr1340 Machine support with Device Tree"
 	select PINCTRL_SPEAR1340
+	select PHY_PLAT
 	select PHY_ST_SPEAR1340_MIPHY
 	help
 	  Supports ST SPEAr1340 machine configured via the device-tree
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
