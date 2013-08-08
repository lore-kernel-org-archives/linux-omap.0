From: Lars Poeschel <poeschel@lemonage.de>
Subject: How to use gpio-omap as interrupt-controller
Date: Thu, 8 Aug 2013 17:23:27 +0200
Message-ID: <201308081723.27051.poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1-1.goneo.de ([212.90.139.81]:42592 "EHLO smtp1-1.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965811Ab3HHPXf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 11:23:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org

Hi!

I have a device-tree-booting omap board that uses gpio-omap as gpio driver. 
Kernel version is 3.11.0-rc4. I have connected a device that signals 
interrupts to a gpio pin of the omap. The driver for this device fails in 
request_threaded_irq.
The irq framework tries to setup the irq in __setup_irq which calls 
gpio_irq_type in gpio-omap.c. This function checks if bank->mod_usage is 
set and because it is not, the function fails. Looking at where bank-
>mod_usage is set, I see it is only set in omap_gpio_request.
This means I have to request at least one random gpio to be able to set the 
type of the irq of another pin on this bank ?
How do I correctly use the gpio-omap gpio driver in my case ?
The board is booting using device tree and does not request a gpio prior to 
requesting the irq on this gpio bank. I really do not want to request a 
gpio. They should stay as they are.
Or does this mean the driver of the connected device is wrong and instead 
it has to request some random gpio before ?

An example of such a connected device is gpio-adnp by the way.
The device tree part looks like this:

		gpioext: gpio-adnp@41 {
			compatible = "ad,gpio-adnp";
			reg = <0x41>;

			interrupt-parent = <&gpio>;
			interrupts = <160 1>;

			gpio-controller;
			#gpio-cells = <1>;

			interrupt-controller;
			#interrupt-cells = <2>;

			nr-gpios = <64>;
		};

Regards,
Lars
