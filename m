From: Matt Porter <mporter@linaro.org>
Subject: [PATCH 5/5] ARM: dts: AM33XX: Add ecap interrupt properties
Date: Wed, 29 Jan 2014 15:59:59 -0500
Message-ID: <1391029199-3670-6-git-send-email-mporter@linaro.org>
References: <1391029199-3670-1-git-send-email-mporter@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:57374 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbaA2VAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jan 2014 16:00:19 -0500
Received: by mail-ig0-f173.google.com with SMTP id c10so16047181igq.0
        for <linux-omap@vger.kernel.org>; Wed, 29 Jan 2014 13:00:19 -0800 (PST)
In-Reply-To: <1391029199-3670-1-git-send-email-mporter@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linaro Patches <patches@linaro.org>

Add missing interrupt properties to the ecap0, ecap1, and ecap2
nodes.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..b4139ba 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -582,6 +582,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
+				interrupts = <31>;
+				interrupt-names = "ecap0";
 				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
@@ -610,6 +612,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
+				interrupts = <47>;
+				interrupt-names = "ecap1";
 				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
@@ -638,6 +642,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
+				interrupts = <61>;
+				interrupt-names = "ecap2";
 				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
-- 
1.8.4

