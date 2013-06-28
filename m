From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Fri, 28 Jun 2013 11:28:53 -0400
Message-ID: <51CDABB5.4080102@ti.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49209 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338Ab3F1P3Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jun 2013 11:29:16 -0400
In-Reply-To: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi

On Friday 28 June 2013 11:27 AM, Javier Martinez Canillas wrote:
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
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> 
Thanks for the patches.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

