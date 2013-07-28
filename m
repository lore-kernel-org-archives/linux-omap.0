From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 16:25:26 +0200
Message-ID: <51F529D6.8030809@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:51525 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab3G1O0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:26:33 -0400
Received: from eiche.ahsoftware (p57B21DD0.dip0.t-ipconnect.de [87.178.29.208])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id E89AF423C2AF
	for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 16:26:29 +0200 (CEST)
In-Reply-To: <51F4F973.8000303@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi, Balaji T K <balajitk@ti.com>

Am 28.07.2013 12:58, schrieb Alexander Holler:

> This patch basically broke every usage of
> 
> irq = gpio_to_irq(gpio);
> request[_threaded]_irq(irq, ...);
> 
> because request[_threaded]_irq(irq, ...) now fails because of a missing
> irq_domain (no mapping => no domain).
> 
> A prominent victim of this is the omap_hsmmc driver with the cd-gpio
> option enabled. To reproduce it, just add "cd-gpios = <&gpio0 6
> GPIO_ACTIVE_HIGH>;" (or similiar) to the omap-mmc part in the DT.

By the way, if someone decides to touch omap_hsmmc, the driver wrongly
assumes that 0 is not a valid IRQ number and it doesn't check if
gpio_to_irq() returns a negative value. ;)

Regards,

Alexander Holler
