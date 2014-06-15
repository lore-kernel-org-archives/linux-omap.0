From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: warn about incorrect
 spelling
Date: Sun, 15 Jun 2014 00:16:36 -0700
Message-ID: <20140615071636.GA23746@core.coreip.homeip.net>
References: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
 <1384788541-16338-1-git-send-email-balbi@ti.com>
 <20140614002355.GB24821@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140614002355.GB24821@saruman.home>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rob.herring@calxeda.com, Pawel.Moll@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 13, 2014 at 07:23:55PM -0500, Felipe Balbi wrote:
> Hi,
> 
> Here's another patch which has been pending for months.

Sorry, lost track of this one, applied.

> 
> On Mon, Nov 18, 2013 at 09:29:01AM -0600, Felipe Balbi wrote:
> > In the hopes that people run new kernels on
> > their devices, let's add a warning message
> > asking users to have their DTS file fixed.
> > 
> > The goal is that by Linux 4.0 we will be
> > able to remove support for the bogus version
> > of our touchscreen's DTS.
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > Here you go, I've added your Suggested-by Mark,
> > if you wish I can remove or change to something
> > else.
> > 
> > cheers
> > 
> >  drivers/input/touchscreen/ti_am335x_tsc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> > index b61df9d..91302cd 100644
> > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > @@ -354,9 +354,12 @@ static int titsc_parse_dt(struct platform_device *pdev,
> >  	 */
> >  	err = of_property_read_u32(node, "ti,coordinate-readouts",
> >  			&ts_dev->coordinate_readouts);
> > -	if (err < 0)
> > +	if (err < 0) {
> > +		dev_warn(&pdev->dev, "please use 'ti,coordinate-readouts' instead\n");
> >  		err = of_property_read_u32(node, "ti,coordiante-readouts",
> >  				&ts_dev->coordinate_readouts);
> > +	}
> > +
> >  	if (err < 0)
> >  		return err;
> >  
> > -- 
> > 1.8.4.GIT
> > 
> 
> -- 
> balbi



-- 
Dmitry
