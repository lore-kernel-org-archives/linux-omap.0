From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 2/5] ARM: dts: cm-t335: add support for SBC-T335
Date: Sun, 13 Dec 2015 10:55:36 +0200
Message-ID: <1449996939-13901-3-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449996939-13901-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add basic support for the SBC-T335.

CompuLab SBC-T335 is a single baseboard computer.
The SBC-T335 is based on the Texas Instruments Cortex-A8 Sitara AM3354
SoC.

Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt |  3 +++
 arch/arm/boot/dts/Makefile                          |  1 +
 arch/arm/boot/dts/am335x-sbc-t335.dts               | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sbc-t335.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 2154f97..358e87e 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -141,6 +141,9 @@ Boards:
 - AM335X CM-T335 : System On Module, built around the Sitara AM3352/4
   compatible = "compulab,cm-t335", "ti,am33xx"
 
+- AM335X SBC-T335 : single board computer, built around the Sitara AM3352/4
+  compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx"
+
 - OMAP5 EVM : Evaluation Module
   compatible = "ti,omap5-evm", "ti,omap5"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 15411bc..d82ea97 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -466,6 +466,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-lxm.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
+	am335x-sbc-t335.dtb \
 	am335x-sl50.dtb \
 	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
new file mode 100644
index 0000000..9e98445
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
@@ -0,0 +1,16 @@
+/*
+ * am335x-sbc-t335.dts - Device Tree file for Compulab SBC-T335
+ *
+ * Copyright (C) 2014 - 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "am335x-cm-t335.dts"
+
+/ {
+	model = "CompuLab CM-T335 on SB-T335";
+	compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx";
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
