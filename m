From: "Pakaravoor, Jagadeesh" <j-pakaravoor-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and restore
Date: Mon, 2 Feb 2009 20:52:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D45244@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF0A6@dbde02.ent.ti.com>
 <4986F037.3090604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4986F037.3090604-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> >         omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> > @@ -300,14 +302,15 @@ static int omap_i2c_init(struct omap_i2c
> >                 } else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
> >                         u32 v;
> 
> This local variable is left unused, so you will get a compiler warning.
> 
> > -                       v = SYSC_AUTOIDLE_MASK;
> > -                       v |= SYSC_ENAWAKEUP_MASK;
> > -                       v |= (SYSC_IDLEMODE_SMART <<
> > +                       dev->syscstate = SYSC_AUTOIDLE_MASK;
> > +                       dev->syscstate |= SYSC_ENAWAKEUP_MASK;
> > +                       dev->syscstate |= (SYSC_IDLEMODE_SMART <<
> >                               __ffs(SYSC_SIDLEMODE_MASK));
> > -                       v |= (SYSC_CLOCKACTIVITY_FCLK <<
> > +                       dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
> >                               __ffs(SYSC_CLOCKACTIVITY_MASK));
> >
> > -                       omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);

The variable "v", holds the value to be written to OMAP_I2C_SYSC_REG. I compiled the code for omap_3430sdp_defconfig, and received no compiler warning.

-Jagadeesh
