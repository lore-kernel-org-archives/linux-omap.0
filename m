From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 00/18] OMAP: GPIO: cleanup GPIO driver
Date: Fri, 22 Apr 2011 16:02:39 +0200
Message-ID: <20110422140239.GG15233@pengutronix.de>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab1DVOCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 10:02:43 -0400
Content-Disposition: inline
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com

Hi,

On Fri, Apr 22, 2011 at 04:38:14PM +0530, Charulatha V wrote:
> Modifies the OMAP GPIO driver to avoid usage of cpu_is* checks
> for different OMAP architectures. This is done by moving some
> architecture specific code to mach-omap* and call them from
> plat-omap* using function pointers. Also remove the register offset
> macros from OMAP GPIO driver and handle the same in mach-omap*.
> 
> Avoid usage of gpio_bank_count and gpio_bank pointer array by
> means of maintaining a list. Removes the bank->method flag from
> the GPIO driver.
> 
> All OMAP1 SoCs has one MPUIO type GPIO bank. OMAP2+ does not have
> any MPUIO type GPIO bank. Since MPUIO type GPIO bank is the same for
> all OMAP1 CPUs, they are handled in plat-omap/ itself as
> there is no common gpio.c file for all cpu types in mach-omap1.
> They are identified by using bank->stride flag as it is '0'
> for other than MPUIO type banks.

The omap gpio code clearly deserves a cleanup, but I think this series
does not go far enough. There are only a handful of possible ways to
implement a gpio hardware, most of them can be abstracted in a similar
way Thomas did for the irq handlers and then we can handle most SoC
specific gpio code in generic code.

Something like the following comes to my mind:

struct gpio_chip_mmio_regs {
	unsigned long output_set_reg;
	unsigned long output_clean_reg;
	unsigned long direction_reg;
	unsigned long status_reg;
};

struct gpio_chip_mmio {
	struct gpio_chip_mmio_regs *regs;
	void __iomem *base;
	void (*direction_output)(struct gpio_chip_mmio *, int);
	void (*direction_input)(struct gpio_chip_mmio *, int);
	struct gpio_chip chip;
};

int gpio_chip_mmio_add(struct gpio_chip_mmio *);

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
