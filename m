From: Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Thu, 12 Dec 2013 14:39:26 +0100
Message-ID: <52A9BC8E.9090007@st.com>
References: <52A8768C.5070103@st.com>
 <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com>
 <52A89206.8080605@st.com> <52A8A1A1.9090104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:36907 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807Ab3LLNjs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 08:39:48 -0500
In-Reply-To: <52A8A1A1.9090104@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Nishant,

I've configured the device tree as you told me. Now, my device tree code 
is that:

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts 
b/arch/arm/boot/dts/omap4-panda-es.dts
index 816d1c9..5644260 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -41,6 +41,12 @@
              0xb6 (PIN_OUTPUT | MUX_MODE3)    /* gpio_110 */
          >;
      };
+
+    lsm6db0_pins: lsm6db0_pins {
+        pinctrl-single,pins = <
+            0xfc (PIN_INPUT | MUX_MODE3) /* mcspi1_cs2.gpio_139 */
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
+        interrupts = <139 0x1>;
+        interrupt-parent = <&lsm6db0_pins>;
+    };
+};
+
  &leds {
      pinctrl-0 = <
          &led_gpio_pins


I've also read the documentation file 
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt 
but I'm confused about the gpio muxed with mcspi1.
Do you think my patch is correct?


Thanks,
Denis
