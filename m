From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 2/2] gpio/omap: auto request GPIO as input if used
 as IRQ via DT
Date: Fri, 28 Jun 2013 11:32:15 -0400
Message-ID: <51CDAC7F.5040807@ti.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <1372433223-9053-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3F1Pci (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jun 2013 11:32:38 -0400
In-Reply-To: <1372433223-9053-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi

On Friday 28 June 2013 11:27 AM, Javier Martinez Canillas wrote:
> When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
> has to be made to initialize the OMAP GPIO bank before a driver
> request the IRQ. Otherwise the call to request_irq() fails.
> 
> Drives should not be aware of this neither care wether an IRQ line
> is a GPIO or not. They should just request the IRQ and this has to
> be handled by the irq_chip driver.
> 
> With the current OMAP GPIO DT binding, if we define:
> 
>     gpio6: gpio@49058000 {
>     	   compatible = "ti,omap3-gpio";
> 	   reg = <0x49058000 0x200>;
> 	   interrupts = <34>;
> 	   ti,hwmods = "gpio6";
> 	   gpio-controller;
> 	   #gpio-cells = <2>;
> 	   interrupt-controller;
> 	   #interrupt-cells = <2>;
>     };
> 
> 	   interrupt-parent = <&gpio6>;
>            interrupts = <16 8>;
> 
> The GPIO is correctly mapped as an IRQ but a call to gpio_request()
> is never made. Since a call to the custom IRQ domain .map function
> handler is made for each GPIO used as an IRQ, the GPIO can be setup
> and configured as input there automatically.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

