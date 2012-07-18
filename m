From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC/PATCH 3/3] i2c: omap: Add support for I2C_M_STOP message flag
Date: Wed, 18 Jul 2012 13:13:12 +0200
Message-ID: <223770735.y2EoxFmDTd@avalon>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com> <1340720229-30356-4-git-send-email-laurent.pinchart@ideasonboard.com> <5006556C.8070003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5006556C.8070003-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Shubhrajyoti,

On Wednesday 18 July 2012 11:49:24 Shubhrajyoti wrote:
> On Tuesday 26 June 2012 07:47 PM, Laurent Pinchart wrote:
> > Generate a stop condition after each message marked with I2C_M_STOP.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-omap.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 801df60..cf1bda0 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -545,6 +545,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> > 
> >  	if (dev->speed > 400)
> >  	
> >  		w |= OMAP_I2C_CON_OPMODE_HS;
> > 
> > +	if (msg->flags & I2C_M_STOP)
> > +		stop = 1;
> 
> How about patching omap_i2c_xfer (caller) instead.
> There are some debug prints of stop  above that will not reflect the
> real value.

omap_i2c_xfer() doesn't look at the content of individual messages, I thought 
it was cleaner not to modify that. Note that the message flags are printed in 
the debug message you mention, which is why I've decided to modify the stop 
variable after printing the message. If you think it's better to modify it 
before, we can move this chunk above the dev_dbg().


> >  	if (msg->flags & I2C_M_TEN)
> >  	
> >  		w |= OMAP_I2C_CON_XA;
> >  	
> >  	if (!(msg->flags & I2C_M_RD))

-- 
Regards,

Laurent Pinchart
