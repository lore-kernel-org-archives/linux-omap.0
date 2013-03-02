From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Sat, 2 Mar 2013 10:54:08 +0530
Message-ID: <51318CF8.4020604@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab3CBFWt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Mar 2013 00:22:49 -0500
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 01 March 2013 10:52 PM, Jon Hunter wrote:
> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> domain. This is not necessary because we do not need to assign a
> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> the OMAP GPIO driver to use a linear mapping instead.
> 
> Please note that this also allows to simplify the logic in the OMAP
> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> virtual irq number from the GPIO bank and bank index.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Cool.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

