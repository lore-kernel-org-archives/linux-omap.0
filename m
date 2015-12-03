From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 11/27] mtd: nand: omap: Clean up device tree support
Date: Wed, 2 Dec 2015 22:09:06 -0800
Message-ID: <20151203060906.GA16368@brian-ubuntu>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-12-git-send-email-rogerq@ti.com>
 <5613A404.9010106@ti.com>
 <20151203042954.GB120110@google.com>
 <565FD9B9.3030202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565FD9B9.3030202@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 03, 2015 at 11:27:13AM +0530, Roger Quadros wrote:
> On 03/12/15 09:59, Brian Norris wrote:
> > On Tue, Oct 06, 2015 at 01:35:48PM +0300, Roger Quadros wrote:
> >>  arch/arm/mach-omap2/gpmc-nand.c              |   5 +-
> >>  drivers/memory/omap-gpmc.c                   | 143 +++++++--------------------
> >>  drivers/mtd/nand/omap2.c                     | 136 +++++++++++++++++++++----
> >>  include/linux/platform_data/mtd-nand-omap2.h |   3 +-
> >>  4 files changed, 155 insertions(+), 132 deletions(-)
> > 
> > Also, this is going to be hard to manage across trees, as you touch
> > three drivers all at once. Is it not possible to split any of this apart
> > better?
> 
> Will need some more effort and I can do it. Butm if we're going to start
> an with immutable branch with everything in, is it worth the effort?

I don't think I noticed the "everything in it" part. I was assuming
you'd have non-MTD changes in the immutable branch, and MTD stuff on
top. But that is indeed more difficult. I'm fine with everything going
in one branch, and pulling that all into MTD.

Then the hangup is that you'll need to have some of l2-mtd.git in that
branch as a prerequisite, if you're going to rebase. Or else I have to
fix it up when merging back into l2-mtd.git...

...

> >> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> >> index a067f58..ff27e5a 100644
> >> --- a/include/linux/platform_data/mtd-nand-omap2.h
> >> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> >> @@ -76,11 +76,10 @@ struct omap_nand_platform_data {
> >>  	int			devsize;
> >>  	enum omap_ecc           ecc_opt;
> >>  
> >> -	/* for passing the partitions */
> >> -	struct device_node	*of_node;
> >>  	struct device_node	*elm_of_node;
> >>  
> >>  	/* deprecated */
> >>  	struct gpmc_nand_regs	reg;
> >> +	struct device_node	*of_node;
> > 
> > I'm a little confused here. Do you have a mixed platform data / device
> > tree setup here? That's odd. (It also seems if that was really
> > necessary, you could have the board file set pdev->dev.of_node before
> > registering it, then you don't need this field.) But really, if you're
> > partly using device tree, can't you just convert completely? Or is this
> > a two-phase process, and you're planning to convert omap2 to full device
> > tree?
> 
> The existing device tree implementation for omap2-nand was like this:
> omap-gpmc.c driver was creating a platform device for the nand device and
> passing the device node via platform data.
> 
> After this series we no longer do this and that's why of_node is marked
> deprecated in platform data. I might as well could just get rid of it
> but wasn't sure of how we're going to integrate the changes into the
> subsystem trees so just marked it deprecated.

Whoops, sorry I didn't read the "deprecated" header there this time. I
thought the movement was odd. *facepalm*

But yes, especially if we're putting everything in one branch, it'd be
more clear to simply kill off things instead of marking things
deprecated. It's especially confusing, since you're actually still using
the field.

Brian
