From: Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Thu, 12 Dec 2013 15:27:02 +0100
Message-ID: <52A9C7B6.3020905@st.com>
References: <52A8768C.5070103@st.com>
 <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com>
 <52A89206.8080605@st.com> <52A8A1A1.9090104@ti.com> <52A9BC8E.9090007@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41950 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542Ab3LLO1V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 09:27:21 -0500
In-Reply-To: <52A9BC8E.9090007@st.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Maybe, this is more correctly but still doesn't work...


 From 9f6e524fa86834c3ab9a5f710021620a103019b2 Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Thu, 12 Dec 2013 14:52:39 +0100
Subject: [PATCH] device tree

---
  arch/arm/boot/dts/omap4-panda-es.dts |   22 ++++++++++++++++++++++
  1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts 
b/arch/arm/boot/dts/omap4-panda-es.dts
index 816d1c9..82c3eb7 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -41,6 +41,12 @@
              0xb6 (PIN_OUTPUT | MUX_MODE3)    /* gpio_110 */
          >;
      };
+
+    lsm6db0_pins: lsm6db0_pins {
+        pinctrl-single,pins = <
+            0xf6 (PIN_INPUT | MUX_MODE3) /*  mcspi1_simo.gpio_136 */
+        >;
+    };
  };

  &led_wkgpio_pins {
@@ -49,6 +55,22 @@
      >;
  };

+&i2c4 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&i2c4_pins>;
+
+    clock-frequency = <400000>;
+
+    lsm6db0@03 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&lsm6db0_pins>;
+        compatible = "st,lsm6db0";
+        reg = <0x03>;
+        interrupts = <&mcspi1 136 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&mcspi1>;
+    };
+};
+
  &leds {
      pinctrl-0 = <
          &led_gpio_pins
-- 
1.7.9.5


No one can help me?

Thanks,
Denis

