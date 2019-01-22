From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v1 1/2] ARM: dts: am335x-shc.dts: Switch to SPDX identifier
Date: Tue, 22 Jan 2019 06:26:22 +0100
Message-ID: <20190122052623.1779840-2-hs@denx.de>
References: <20190122052623.1779840-1-hs@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122052623.1779840-1-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Adopt the SPDX license identifier headers to ease license
compliance management.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/boot/dts/am335x-shc.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index d0fd68873689..5cdaf0cd9401 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * support for the bosch am335x based shc c3 board
  *
  * Copyright, C) 2015 Heiko Schocher <hs@denx.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 /dts-v1/;
 
-- 
2.17.2
