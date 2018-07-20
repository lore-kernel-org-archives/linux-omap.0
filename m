From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction
 once per transfer
Date: Fri, 20 Jul 2018 21:29:10 +0200
Message-ID: <20180720212910.49bb2a88@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-4-jmkrzyszt@gmail.com>
        <20180719082318.290abee1@bbrezillon>
        <90128326.sKM4evrj8F@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90128326.sKM4evrj8F@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 20 Jul 2018 20:12:05 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Thursday, July 19, 2018 8:23:18 AM CEST Boris Brezillon wrote:
> > On Thu, 19 Jul 2018 01:57:05 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > In its current shape, the driver sets data port direction before each
> > > byte read/write operation, even during multi-byte transfers.  Optimize
> > > that by setting the port direction only on first byte of each transfer.  
> > 
> > Sounds like premature optimization for something you'll rework when
> > fully switching to the GPIO consumer API to control the DATA bus.  
> 
> Indeed, this optimization was crucial for getting acceptable performance of 
> data transfers over GPIO.  I'm only not sure if there is any action in 
> response to your comment expected on my side, e.g., did you want to say I 
> should modify the patch description, or change the order of patches?

I'm just saying that, since you switch to a solution that goes through
the GPIO framework to control the data bus, making sure the the pin
direction change is done only once when reading/writing several bytes is
something you can do after/when transitioning to the new approach.

So yes, I suggest to re-order patches, except that this patch won't
look the same at all if you move it after the "use the GPIO consumer
API to control data bus" patch.
