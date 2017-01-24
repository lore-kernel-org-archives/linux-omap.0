From: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/3] ARM: configs: omap2plus_defconfig: Enable support for micrell phys
Date: Tue, 24 Jan 2017 11:09:35 +0100
Message-ID: <1485252576-36955-2-git-send-email-t.remmet@phytec.de>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485252576-36955-1-git-send-email-t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wadim Egorov <w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The phyCORE-AM335x SoM with PCM-953 carrierboard has a
KSZ9021 phy mounted. To add support for this we need to enable
the micrell phy driver in the config.

Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 195c98b..0c2bf2d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -168,6 +168,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
+CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
