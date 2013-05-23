From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/2] ARM: dts: omap3-overo: add default trigger for TWL4030 LED
Date: Thu, 23 May 2013 10:09:12 +0200
Message-ID: <1369296552-22281-3-git-send-email-florian.vaussard@epfl.ch>
References: <1369296552-22281-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:34967 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755732Ab3EWIJp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 04:09:45 -0400
In-Reply-To: <1369296552-22281-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Commit c971ff1 'leds: leds-pwm: Defer led_pwm_set() if PWM can sleep'
fixed a crash when using a trigger with a pwm-led provided by an
external chip. Now it is safe to add the default trigger according
to board-overo.c.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index be81303..8624fb8 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -21,6 +21,7 @@
 			label = "overo:blue:COM";
 			pwms = <&twl_pwmled 1 7812500>;
 			max-brightness = <127>;
+			linux,default-trigger = "mmc0";
 		};
 	};
 
-- 
1.7.5.4

