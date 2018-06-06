From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] ARM: dts: igep: Relicense the IGEP boards under GPLv2/X11
Date: Wed,  6 Jun 2018 17:24:59 +0200
Message-ID: <20180606152500.14034-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@gmail.com>
List-Id: linux-omap@vger.kernel.org

The current GPLv2 only licensing on IGEP boards makes it very impractical
for other software components licensed under another license.

In order to make it easier for them to reuse our device trees, relicense
all boards under a GPLv2/X11 dual-license. Also switch to use the SPDX
identifiers and remove the boiler plate license text.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-igep0033.dtsi       | 7 ++-----
 arch/arm/boot/dts/omap3-igep.dtsi            | 6 ++----
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 5 +----
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts   | 5 +----
 arch/arm/boot/dts/omap3-igep0020.dts         | 5 +----
 arch/arm/boot/dts/omap3-igep0030-common.dtsi | 5 +----
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts   | 5 +----
 arch/arm/boot/dts/omap3-igep0030.dts         | 5 +----
 8 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index a5769a8f5fc8..c79066df4e0c 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * am335x-igep0033.dtsi - Device Tree file for IGEP COM AQUILA AM335x
+ * Device Tree file for IGEP COM AQUILA AM335x
  *
  * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index f33cc80c9dbc..9c02942a58a7 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Common device tree for IGEP boards based on AM/DM37x
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
+
 /dts-v1/;
 
 #include "omap36xx.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index ecbec23af49f..9675ce2cf069 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Common Device Tree Source for IGEPv2
  *
  * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 321c2b7a4e9f..8b8959930d19 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree Source for IGEPv2 Rev. F (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep0020-common.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 33d6b4ead092..770b69f13c9e 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree Source for IGEPv2 Rev. C (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep0020-common.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index 443f71707437..9cd3e427ae22 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Common Device Tree Source for IGEP COM MODULE
  *
  * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index 76dc08868bfb..8b2d01e7996b 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree Source for IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2014 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep0030-common.dtsi"
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 55b0cc4f5ee5..22329ae502c5 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Device Tree Source for IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)
  *
  * Copyright (C) 2012 Javier Martinez Canillas <javier@osg.samsung.com>
  * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "omap3-igep0030-common.dtsi"
-- 
2.17.1
