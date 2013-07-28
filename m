From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 12:58:59 +0200
Message-ID: <51F4F973.8000303@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:53166 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab3G1K7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 06:59:30 -0400
Received: from eiche.ahsoftware (p57B21DD0.dip0.t-ipconnect.de [87.178.29.208])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 6CD59423C272
	for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 12:59:27 +0200 (CEST)
In-Reply-To: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi, Balaji T K <balajitk@ti.com>

Am 28.06.2013 17:27, schrieb Javier Martinez Canillas:
> When a GPIO is defined as an interrupt line using Device
> Tree, a call to irq_create_of_mapping() is made that calls
> irq_create_mapping(). So, is not necessary to do the mapping
> for all OMAP GPIO lines and explicitly call irq_create_mapping()
> on the driver probe() when booting with Device Tree.
>
> Add a custom IRQ domain .map function handler that will be
> called by irq_create_mapping() to map the GPIO lines used as IRQ.
> This also allows to execute needed setup code such as configuring
> a GPIO as input and enabling the GPIO bank.

This patch basically broke every usage of

irq = gpio_to_irq(gpio);
request[_threaded]_irq(irq, ...);

because request[_threaded]_irq(irq, ...) now fails because of a missing 
irq_domain (no mapping => no domain).

A prominent victim of this is the omap_hsmmc driver with the cd-gpio 
option enabled. To reproduce it, just add "cd-gpios = <&gpio0 6 
GPIO_ACTIVE_HIGH>;" (or similiar) to the omap-mmc part in the DT.

I don't know what else might fail, but I would assume there are still 
many other places which do request an IRQ for a GPIO with the above, now 
failing, sequence.

Regards,

Alexander

