From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Wed, 13 Jul 2011 20:20:55 +0100
Message-ID: <20110713192055.GC3369@freya.fluff.org>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
 <8739ikp9aa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8739ikp9aa.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 05, 2011 at 05:01:01PM -0700, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
> 
> > Currently the fifo depth is set to zero for OMAP4 which disables
> > the FIFO usage. This patch enables the FIFO usage for I2C transactions
> > on OMAP4 also.
> >
> > Tested on omap4430 and 3430.
> >
> > Reported-By: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > ---
> > Rebased on top of the series by Andy Green
> > http://www.spinics.net/lists/linux-i2c/msg05632.html
> 
> Thanks.
> 
> This is v3.1 material, but would be nice to see a couple tested-by or
> acked-by tags from folks that are more actively using the I2C driver
> before merging
> 
> Kevin

guess you'll be picking these up?
 
> 
> >  drivers/i2c/busses/i2c-omap.c |   11 ++++++-----
> >  1 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index d53cd61..8f87a37 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1068,13 +1068,14 @@ omap_i2c_probe(struct platform_device *pdev)
> >  		 * size. This is to ensure that we can handle the status on int
> >  		 * call back latencies.
> >  		 */
> > -		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430) {
> > -			dev->fifo_size = 0;
> > +
> > +		dev->fifo_size = (dev->fifo_size / 2);
> > +
> > +		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
> >  			dev->b_hw = 0; /* Disable hardware fixes */
> > -		} else {
> > -			dev->fifo_size = (dev->fifo_size / 2);
> > +		else
> >  			dev->b_hw = 1; /* Enable hardware fixes */
> > -		}
> > +
> >  		/* calculate wakeup latency constraint for MPU */
> >  		if (dev->set_mpu_wkup_lat != NULL)
> >  			dev->latency = (1000000 * dev->fifo_size) /
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
