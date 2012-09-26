From: Koen Kooi <koen@dominion.thruhere.net>
Subject: replacement for /sys/kernel/debug/omap_mux in DT/pinctrl land ?
Date: Wed, 26 Sep 2012 13:46:45 +0200
Message-ID: <D7202A6C-5250-4B55-B3B8-FF15BCCA97AC@dominion.thruhere.net>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64475 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab2IZLqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 07:46:48 -0400
Received: by wibhr7 with SMTP id hr7so621553wib.1
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 04:46:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: List List <linux-omap@vger.kernel.org>

Hi,

With a patched 3.6rc7 on my beaglebone I can set the pinmux for pins using pinctrl and that seems to work. On the 3.2 vendor tree there was the omap_mux driver with an awesome debugfs interface:

# cat /sys/kernel/debug/omap_mux/lcd_data0 
name: lcd_data0.ehrpwm2A (0x44e108a0/0x8a0 = 0x0003), b NA, t NA
mode: OMAP_PIN_OUTPUT | OMAP_MUX_MODE3
signals: lcd_data0 | gpmc_a0 | pr1_mii_mt0_clk | ehrpwm2A | NA | pr1_pru1_pru_r30_0 | pr1_pru1_pru_r31_0 | gpio2_6

Notice how it tells me that it's muxed the PWM in 2 ways: signal name (ehrpwm2A) and register content (0x0003). Compare to pinctrl:

root@bone-mainline:/sys/kernel/debug/pinctrl/44e10800.pinmux# grep 8a0 *
pinconf-pins:pin 40 (44e108a0):
pingroups:pin 40 (44e108a0)
pinmux-pins:pin 40 (44e108a0): 4a300000.pruss (GPIO UNCLAIMED) function pinmux_pruss_led_pins group pinmux_pruss_led_pins
pins:pin 40 (44e108a0)  pinctrl-single

What is that pin muxed to? It is part of the 'pinmux_pruss_led_pins' in the DT, but debugfs remains mute on how pin 40 is muxed.

regards,

Koen