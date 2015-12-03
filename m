From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 18/27] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Thu, 3 Dec 2015 09:41:46 +0100
Message-ID: <20151203094146.41eba882@bbrezillon>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
	<1442588029-13769-19-git-send-email-rogerq@ti.com>
	<20151026204900.GI13239@google.com>
	<20151027092832.4d7bb114@bbrezillon>
	<20151203044544.GC120110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203044544.GC120110@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-omap@vger.kernel.org

Hi Brian,

On Wed, 2 Dec 2015 20:45:44 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> (to be clear, this branch of discussion isn't directly regarding the TI
> changes; we can handle any generic handling afterward, as long as we get
> the DT binding right now)
> 
> On Tue, Oct 27, 2015 at 09:28:32AM +0100, Boris Brezillon wrote:
> > On Mon, 26 Oct 2015 13:49:00 -0700
> > Brian Norris <computersforpeace@gmail.com> wrote:
> > > On Fri, Sep 18, 2015 at 05:53:40PM +0300, Roger Quadros wrote:
> > > > @@ -1782,7 +1780,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> > > >  		info->reg = pdata->reg;
> > > >  		info->of_node = pdata->of_node;
> > > >  		info->ecc_opt = pdata->ecc_opt;
> > > > -		info->dev_ready	= pdata->dev_ready;
> > > > +		if (pdata->dev_ready)
> > > > +			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
> > > > +
> > > >  		info->xfer_type = pdata->xfer_type;
> > > >  		info->devsize = pdata->devsize;
> > > >  		info->elm_of_node = pdata->elm_of_node;
> > > > @@ -1815,6 +1815,13 @@ static int omap_nand_probe(struct platform_device *pdev)
> > > >  	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
> > > >  	nand_chip->cmd_ctrl  = omap_hwcontrol;
> > > >  
> > > > +	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "ready",
> > > > +						    GPIOD_IN);
> > > 
> > > Others have been looking at using GPIOs for the ready/busy pin too. At a
> > > minimum, we need an updated DT binding doc for this, since I see you're
> > > adding this via device tree in a later patch (I don't see any DT binding
> > > patch for this; but I could just be overlooking it). It'd also be great
> > > if this support was moved to nand_dt_init() so other platforms can
> > > benefit, but I won't require that.
> > 
> > Actually I started to work on a generic solution parsing the DT and
> > creating CS, WP and RB gpios when they are provided, but I think it's a
> > bit more complicated than just moving the rb-gpios parsing into
> > nand_dt_init().
> > First you'll need something to store your gpio_desc pointers, which
> > means you'll have to allocate a table of gpio_desc pointers (or a table
> > of struct embedding a gpio_desc pointer).
> 
> I'm not sure what you mean by table. It seems like we would just have a
> few gpio_desc pointers in struct nand_chip, no?

Nope, because a single nand_chip can use several CS and R/B lines,
hence the gpio_desc array.

> 
> > The other blocking point is that when nand_scan_ident() is called, the
> > caller is supposed to have filled the ->dev_ready() or ->waitfunc()
> > fields, and to choose how to implement it he may need to know
> > which kind of RB handler should be used (this is the case in the sunxi
> > driver, where the user can either use a GPIO or native R/B pin directly
> > connected to the controller).
> 
> Right, I was thinking about this one.
> 
> > All this makes me think that maybe nand_dt_init() should be called
> > separately or in a different helper (nand_init() ?) taking care of the
> > basic nand_chip initializations/allocations without interacting with
> > the NAND itself.
> 
> Yeah, I feel like there have been other good reasons for something like
> this before, and we just have worked around them so far. Maybe something
> more like the alloc/add split in many other subsystems? e.g.,
> platform_device_{alloc,add}, spi_{alloc,add}_device. Now we might want
> nand_alloc()?
> 
> On a slight tangent, it seems silly that nand_scan_tail() doesn't
> register the MTD, but nand_release() unregisters it. That shouldn't be.

Yep, that's one of the things we should address too.

> 
> > Another solution would be to add an ->init() function to nand_chip
> > and call it after the generic initialization has been done (but before
> > NAND chip detection). This way the NAND controller driver could adapt
> > some fields and parse controller specific properties.
> 
> That could work too, I guess.

Hm, all these suggestions have been made before I started my
nand_controller/nand_chip separation work, and I think we can get
something way simpler if we switch to a model where the core
implements most of the initialization steps (including parsing of
generic DT properties) and ask the controller to do its specific
initialization (as is done in the SPI subsystem for example).

If you want to have an idea of where I'm heading to, you can have a
look at the last commits in this branch [1]. The generic DT parsing is
not yet automated but it could easily be places here [2], so that when
controller->ops->add() is called everything is in place and the driver
can overload the default behavior with its own implementation.

Any objection to this approach?

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-sunxi/commits/nand/layering-rework
[2]https://github.com/bbrezillon/linux-sunxi/blob/nand/layering-rework/drivers/mtd/nand/nand_base.c#L4025

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
