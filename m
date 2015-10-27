From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 18/27] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Tue, 27 Oct 2015 09:28:32 +0100
Message-ID: <20151027092832.4d7bb114@bbrezillon>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
	<1442588029-13769-19-git-send-email-rogerq@ti.com>
	<20151026204900.GI13239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151026204900.GI13239@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On Mon, 26 Oct 2015 13:49:00 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> + others
> 
> A few comments below.
> 
> On Fri, Sep 18, 2015 at 05:53:40PM +0300, Roger Quadros wrote:
> > The GPMC WAIT pin status are now available over gpiolib.
> > Update the omap_dev_ready() function to use gpio instead of
> > directly accessing GPMC register space.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  drivers/mtd/nand/omap2.c                     | 29 +++++++++++++++++-----------
> >  include/linux/platform_data/mtd-nand-omap2.h |  2 +-
> >  2 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 228f498..d0f2620 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/jiffies.h>
> > @@ -184,6 +185,8 @@ struct omap_nand_info {
> >  	/* fields specific for BCHx_HW ECC scheme */
> >  	struct device			*elm_dev;
> >  	struct device_node		*of_node;
> > +	/* NAND ready gpio */
> > +	struct gpio_desc		*ready_gpiod;
> >  };
> >  
> >  /**
> > @@ -1047,22 +1050,17 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
> >  }
> >  
> >  /**
> > - * omap_dev_ready - calls the platform specific dev_ready function
> > + * omap_dev_ready - checks the NAND Ready GPIO line
> >   * @mtd: MTD device structure
> > + *
> > + * Returns true if ready and false if busy.
> >   */
> >  static int omap_dev_ready(struct mtd_info *mtd)
> >  {
> > -	unsigned int val = 0;
> >  	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
> >  							mtd);
> >  
> > -	val = readl(info->reg.gpmc_status);
> > -
> > -	if ((val & 0x100) == 0x100) {
> > -		return 1;
> > -	} else {
> > -		return 0;
> > -	}
> > +	return gpiod_get_value(info->ready_gpiod);
> >  }
> >  
> >  /**
> > @@ -1782,7 +1780,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  		info->reg = pdata->reg;
> >  		info->of_node = pdata->of_node;
> >  		info->ecc_opt = pdata->ecc_opt;
> > -		info->dev_ready	= pdata->dev_ready;
> > +		if (pdata->dev_ready)
> > +			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
> > +
> >  		info->xfer_type = pdata->xfer_type;
> >  		info->devsize = pdata->devsize;
> >  		info->elm_of_node = pdata->elm_of_node;
> > @@ -1815,6 +1815,13 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
> >  	nand_chip->cmd_ctrl  = omap_hwcontrol;
> >  
> > +	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "ready",
> > +						    GPIOD_IN);
> 
> Others have been looking at using GPIOs for the ready/busy pin too. At a
> minimum, we need an updated DT binding doc for this, since I see you're
> adding this via device tree in a later patch (I don't see any DT binding
> patch for this; but I could just be overlooking it). It'd also be great
> if this support was moved to nand_dt_init() so other platforms can
> benefit, but I won't require that.

Actually I started to work on a generic solution parsing the DT and
creating CS, WP and RB gpios when they are provided, but I think it's a
bit more complicated than just moving the rb-gpios parsing into
nand_dt_init().
First you'll need something to store your gpio_desc pointers, which
means you'll have to allocate a table of gpio_desc pointers (or a table
of struct embedding a gpio_desc pointer).
The other blocking point is that when nand_scan_ident() is called, the
caller is supposed to have filled the ->dev_ready() or ->waitfunc()
fields, and to choose how to implement it he may need to know
which kind of RB handler should be used (this is the case in the sunxi
driver, where the user can either use a GPIO or native R/B pin directly
connected to the controller).

All this makes me think that maybe nand_dt_init() should be called
separately or in a different helper (nand_init() ?) taking care of the
basic nand_chip initializations/allocations without interacting with
the NAND itself.

Another solution would be to add an ->init() function to nand_chip
and call it after the generic initialization has been done (but before
NAND chip detection). This way the NAND controller driver could adapt
some fields and parse controller specific properties.

What do you think?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
