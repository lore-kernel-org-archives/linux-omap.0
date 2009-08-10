From: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Mon, 10 Aug 2009 10:44:38 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F20295A89778@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F89@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0908030054390.19529@utopia.booyaka.com>
 <CD8CC2B65FEE304DA95744A5472698F202959C0D61@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202959C0D61-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sonasath, Moiz
> Sent: Monday, August 03, 2009 3:20 PM
> To: Paul Walmsley
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Menon,
> Nishanth; Pandita, Vikram
> Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
> 
> 
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org]
> > Sent: Monday, August 03, 2009 2:36 AM
> > To: Sonasath, Moiz
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Menon,
> > Nishanth; Pandita, Vikram
> > Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
> >
> > Hello Moiz,
> >
> > A few remaining comments, most of these from an earlier message.
> >
> > On Tue, 21 Jul 2009, Sonasath, Moiz wrote:
> >
> > > When an XRDY/XDR is hit, wait for XUDF before writing data to
> DATA_REG.
> > > Otherwise some data bytes can be lost while transferring them from the
> > > memory to the I2C interface.
> > >
> > > Do a Busy-wait for XUDF, before writing data to DATA_REG. While
> waiting
> > > if there is NACK | AL, set the appropriate error flags, ack the
> pending
> > > interrupts and return from the ISR.
> > >
> > > Signed-off-by: Moiz Sonasath<m-sonasath-l0cyMroinI0@public.gmane.org>
> > > Signed-off-by: Vikram pandita<vikram.pandita-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++++++++++-
> > >  1 files changed, 23 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-
> > omap.c
> > > index 05b5e4c..8deaf87 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -672,9 +672,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
> > >  			break;
> > >  		}
> > >
> > > +		err = 0;
> > > +complete:
> > >  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
> > >
> > > -		err = 0;
> > >  		if (stat & OMAP_I2C_STAT_NACK) {
> > >  			err |= OMAP_I2C_STAT_NACK;
> > >  			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> > > @@ -764,6 +765,27 @@ omap_i2c_isr(int this_irq, void *dev_id)
> > >  							"data to send\n");
> > >  					break;
> > >  				}
> > > +
> > > +				/*
> > > +				 * OMAP3430 Errata 1.153: When an XRDY/XDR
> > > +				 * is hit, wait for XUDF before writing data
> > > +				 * to DATA_REG. Otherwise some data bytes can
> > > +				 * be lost while transferring them from the
> > > +				 * memory to the I2C interface.
> > > +				 */
> >
> > Based on this description, shouldn't this patch also zero the transmit
> > FIFO threshold?  Consider what the transmit path becomes after this
> patch:
> >
> > 1. Fill transmit FIFO
> > 2. Leave ISR & wait for interrupt
> > 3. Interrupt happens due to XDR/XRDY (transmit FIFO low-water-mark
> >    reached)
> > 4. Busy-wait until transmit FIFO & shift register completely empty
> > 5. If more data to send, go to step #1
> >
> > i2c-omap.c currently sets the transmit FIFO threshold to 1/2 of the
> total
> > FIFO size[1].  This means that, in the worst case, I2C3, the I2C ISR
> will
> > busy-wait in step 4 for the time it takes 32 bytes to be transmitted.
> > This is time that the MPU spends doing nothing but spinning, wasting
> > power.  This seems unnecessary and wasteful.  The time the driver spends
> > busy-waiting in the ISR should be reduced to the lowest possible
> duration.
> >
> > To do this, what I suggest that you additionally do in the patch is to
> > reduce the transit FIFO threshold/low-water-mark, controlled by
> > I2C_BUF.XTRSH, to the lowest possible value.  This should maximize the
> > time spent between steps 2 and 3 and minimize the time spent between
> steps
> > 3 and 5.
> >
> > Is there a reason why this can't be done?
> 
> Yes, this is actually lined up in my list of actions. I will be working on
> this to test the functionality and stability of I2C code with the
> threshold set to zero.
> 

I did some analysis and testing of the code with threshold set to zero, we cannot make the threshold zero with the present code in place, as this would hamper the functionality of the draining feature because in this case the XDR interrupt will not be triggered.

XDR-> when TX FIFO level equal/below the XTRSH AND TXSTAT is less than XTRSH

XRDY-> when TX FIFO level equal/below the XTRSH AND TXSTAT is equal/greater than XTRSH 

This in turn causes XRDY to be triggered always (even when there are only last few bytes left to be transmitted) and therefore the code tries to transmit data when the upper application is out of data.

> >
> > > +
> > > +				if (cpu_is_omap34xx()) {
> >
> > Does this erratum apply to the I2C IP block on OMAP2430?  It also has
> FIFO
> > transmit capability.  It would be ideal if you can find out from the I2C
> > IP block designers.  If you cannot, please consider adding a comment
> that
> > this may also apply to the I2C block on OMAP2430.
> >
> > In general it is best to enable these workarounds based on the I2C IP
> > block's own revision register contents, not the OMAP CPU type.  The goal
> > is to remove all these OMAP-specific "cpu_is_omapxxxx()" macros from
> > device drivers.  For example, what if a future DaVinci part uses the
> same
> > I2C IP block?
> 
> Yes this is the right way.
> I am checking with the IP team and will get back on this action item.

I checked with the I2C IP team, yes the errata applies to the I2C block on OMAP2430 and OMAP2420. I will send out a patch to include OMAP24XX for this erratum.

> 
> >
> > > +						while (!(stat & OMAP_I2C_STAT_XUDF)) {
> >
> > Is there a reason why you can't just reuse the main while() loop in the
> > ISR, and add a state variable to handle any special casing needed in
> this
> > context?  That will avoid this separate while() loop.
> >
> 
> The problem with using the main while() loop is the counter 'count'
> associated with it as I am not sure if the count value of 100 is enough
> wait time for allowing the XUDF bit to set and if we can come up with an
> accurate wait count to be used there.
> 
> The idea is that if the hardware is functional, XUDF bit will be set once
> the FIFO and shift registers are empty and the only thing that can go
> wrong at that point is a sudden NACK or AL. These errors are taken care in
> my while loop thereby eliminating the need of a timeout on XUDF wait.
> 
> 
> 
> > > +							if (stat & (OMAP_I2C_STAT_NACK |
> > OMAP_I2C_STAT_AL)) {
> > > +								omap_i2c_ack_stat(dev,
> > stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> > > +								err |= OMAP_I2C_STAT_XUDF;
> > > +								goto complete;
> > > +							}
> > > +							cpu_relax();
> > > +							stat = omap_i2c_read_reg(dev,
> > OMAP_I2C_STAT_REG);
> > > +						}
> > > +				}
> > > +
> > >  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> > >  			}
> > >  			omap_i2c_ack_stat(dev,
> >
> > For those following along in the archives, this is an extension of
> > comments from
> >
> >    http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg13846.html
> >
> >
> > - Paul
> >
> >
> > 1. Eventually this is likely to change, based on power management
> >    constraints.
> 
> Regards
> Moiz Sonasath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Moiz Sonasath
