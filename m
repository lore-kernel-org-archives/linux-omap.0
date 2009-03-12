From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 18:04:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.0903111741270.26959-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ari,

One thing that I missed -

On Wed, 11 Mar 2009, Paul Walmsley wrote:

> > On Fri, Mar 06, 2009 at 03:34:54PM +0200, Ari Kauppi wrote:
> > > I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> > > (and thus LOCKDEP) are disabled.
> 
> Ari, are you seeing "Spurious irq XX: XXXXXXXX, please flush posted write 
> for irq" messages?  If so, the correct fix for this is to read from the 
> device interrupt status register immediately after writing to it.  This 
> forces the ARM to wait until the write to the device is complete.  Ari, 
> could you make this change to i2c-omap.c:omap_i2c_isr() instead, and test 
> whether this fixes the problem?
> 
> + u32 tmp;
> 
> ...
> 
>   omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
> + tmp = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG); /* OCP barrier */

You'll also want to make a similar change in omap_i2c_ack_stat(), to add a 
read immediately after that write.


- Paul
