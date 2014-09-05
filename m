From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: omap3-overo: Fix UART wake-up events
Date: Fri, 5 Sep 2014 10:46:33 -0700
Message-ID: <20140905174633.GA3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39595 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaIERqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2014 13:46:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>, Ash Charles <ash@gumstix.com>

Compared to legacy booting, we don't have wake-up events enabled
for device tree based booting. This means that if deeper idle
states are enabled, the device won't wake up to UART events and
seems like it has hung.

Let's fix that by adding the wake-up interrupt. Note that we
don't need to set the PIN_OFF_WAKEUPENABLE any longer, that's
handled by the wake-up interrupt when the serial driver does
request_irq on it.

Tested with the following on omap3-overo-summit that has the
ES2.1 omap:

#!/bin/bash

uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
        echo enabled > $uart/wakeup
        echo auto > $uart/control
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

# grep -i uart /proc/interrupts
 90:       1085      INTC  74  OMAP UART2
338:          5   pinctrl 366  OMAP UART2

# grep ^core_pwrdm /sys/kernel/debug/pm_debug/count
core_pwrdm (ON),OFF:1654,RET:131,INA:39,ON:1825...

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
@@ -36,8 +36,8 @@
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 };
@@ -88,6 +88,7 @@
 };
 
 &uart3 {
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
