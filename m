From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 13 Jul 2015 00:10:09 -0700
Message-ID: <20150713071008.GC26485@atomide.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436531019-18088-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150710 05:26]:
> Since the Interrupt Events are used only by the NAND driver,
> there is no point in managing the Interrupt registers
> in the GPMC driver and complicating it with irqchip modeling.

I don't think it's a good idea to allow external drivers to
tinker directly with GPMC registers. How about just set up GPMC
as an irqchip for the edge detection interrupts?

I think we already have devices with multiple NAND chips. And
there's nothing stopping other drivers from using the edge
detection interrupts.

Regards,

Tony
