From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 9/9] ARM: omap2plus_defconfig: Enable LP873X support
Date: Fri, 14 Oct 2016 18:30:33 +0530
Message-ID: <20161014130033.14172-10-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161014130033.14172-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

LP873X family of PMICs are used in dra71x-evm, So enable the same.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5695cff..e3fdf4d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -267,11 +267,13 @@ CONFIG_TWL4030_WATCHDOG=m
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TI_LP873X=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_LP872X=y
+CONFIG_REGULATOR_LP873X=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_TI_ABB=y
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
