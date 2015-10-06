From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 6 Oct 2015 01:33:47 -0700
Message-ID: <20151006083346.GL23801@atomide.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560BC0DB.5020205@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150930 04:04]:
> Tony,
> 
> On 18/09/15 17:53, Roger Quadros wrote:
> > Hi,
> > 
> > We do a couple of things in this series which result in
> > cleaner device tree implementation, faster perfomance and
> > multi-platform support. As an added bonus we get new GPI/Interrupt pins
> > for use in the system.
> > 
> > - Establish a custom interface between NAND and GPMC driver. This is
> > needed because all of the NAND registers sit in the GPMC register space.
> > Some bits like NAND IRQ are even shared with GPMC.
> > 
> > - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
> > with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
> > This causes performance increase when using prefetch-irq mode.
> > 30% increase in read, 17% increase in write in prefetch-irq mode.
> > 
> > - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
> > driver can be used on non-OMAP platforms. e.g. Keystone.
> > 
> > - Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
> > 2 to 4 of these and most of them would be unused otherwise. It also
> > allows a cleaner implementation of NAND Ready pin status for the NAND driver.
> > 
> > - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
> > 
> > This series is available at
> > git@github.com:rogerq/linux.git
> > in branch
> > for-v4.4/gpmc-v3

In general, very nice work :)

> I've verified this series with the following boards
> -dra7-evm
> -am437x-gp-evm
> -am335x-evm
> -beagleboard-c4
> 
> For legacy boot I've checked only on beagleboard-c4.

Great.

Does build and boot and use NAND work throughtout the series?
Otherwise we'll have hard time bisecting anything..

> Test procedure was to read an existing ubifs partition,
> create a new one and read it back.
> 
> Need you to Ack if it looks good.
> Do you mind taking it via omap-soc once MTD maintainers ack their relevant parts?

Sure. I'll try to do some testing on the series first too.

Can the dts changes be merged separtely? Otherwise we'll have
a dependency between dts branch and the GPMC/NAND changes.

Regards,

Tony
