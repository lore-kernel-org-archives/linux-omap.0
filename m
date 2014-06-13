From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/36] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Fri, 13 Jun 2014 00:18:21 -0700
Message-ID: <20140613071820.GI17845@atomide.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
 <1402477001-31132-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402477001-31132-6-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140611 01:58]:
> Since the Interrupt Events are used only by the NAND driver,
> there is no point in managing the Interrupt registers
> in the GPMC driver and complicating it with irqchip modeling.
> 
> Let's manage the interrupt registers directly in the NAND driver
> and get rid of irqchip model from GPMC driver.
> 
> Get rid of IRQ commands and unused commands from gpmc_configure() in
> the GPMC driver.

This seems like a step backward to me. The GPMC interrupt enable
register can do edge detection on the wait pins, how is that
limited to NAND?

Further, let's not start mixing GPMC hardware module register
access with the NAND driver register access. They can be clocked
separately. And bugs in the NAND driver can cause issues in other
GPMC using drivers.

Regards,

Tony
