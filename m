From: Tony Lindgren <tony@atomide.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 10:57:06 -0700
Message-ID: <20130607175705.GC3331@atomide.com>
References: <51B1C9D2.6060703@ti.com>
 <51B1D3D6.2020803@ti.com>
 <51B1D654.9070107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28754 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755822Ab3FGR5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 13:57:07 -0400
Content-Disposition: inline
In-Reply-To: <51B1D654.9070107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130607 05:53]:
> On 07/06/13 15:36, Grygorii Strashko wrote:
> 
> > Could you check if below change will help you, pls?
> > iff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 13d1eca..66a62e7 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -615,11 +615,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter
> > *adap,
> >         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
> >                 if (msg->flags & I2C_M_IGNORE_NAK)
> >                         return 0;
> > -               if (stop) {
> > -                       w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> > -                       w |= OMAP_I2C_CON_STP;
> > -                       omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> > -               }
> > +
> > +               w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> > +               w |= OMAP_I2C_CON_STP;
> > +               omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> > +
> >                 return -EREMOTEIO;
> >         }
> >         return -EIO;
> 
> With that one, I don't get timeouts, but it still doesn't work (i.e.
> behavior is the same as on -rc1).
> 
> When I run i2cdump the first time, I see that it (probably) manages to
> read the first byte, as that's "00". Everything after that are 'XX'es.

Hmm I suggest git bisect, I'm pretty sure I was using my panda es
with my omap4 DT conversion patches against v3.10-rc1.

In any case, please also test your changes against the current
omap-for-v3.11/cleanup branch that drops omap4 legacy hwmod data for
the parts that should come from DT. If you see some additional issues
with that, we can revert the related parts of the last patch in
omap-for-v3.11/cleanup.

Regards,

Tony
