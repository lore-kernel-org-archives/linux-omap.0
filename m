From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [RFC PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Wed, 20 Aug 2014 08:40:28 +0200
Message-ID: <20140820064028.GC9319@ci00147.xsens-tech.local>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-4-git-send-email-frans.klaver@xsens.com>
 <20140819185701.GC22003@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140819185701.GC22003@saruman.home>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Frans Klaver <fransklaver@gmail.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 19, 2014 at 01:57:02PM -0500, Felipe Balbi wrote:
> On Tue, Aug 19, 2014 at 02:14:47PM +0200, Frans Klaver wrote:
> > At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
> > rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
> > this to about 170 overflows in 10 minutes.
> 
> Can you try Sebastian Siewior's patches for 8250_omap and 8250 dma
> support ? That should help you a lot.

I'll have a look at that series. Thanks for pointing it out.

> >  drivers/tty/serial/omap-serial.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index 14a0167..57664b9 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -575,6 +575,21 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
> >  }
> >  
> >  /**
> > + * serial_omap_fast_irq() - schedule interrupt handling
> > + */
> > +static irqreturn_t serial_omap_fast_irq(int irq, void *dev_id)
> > +{
> > +	struct uart_omap_port *up = dev_id;
> > +	unsigned int iir = serial_in(up, UART_IIR);
> > +
> > +	if (iir & UART_IIR_NO_INT)
> > +		return IRQ_NONE;
> > +
> > +	disable_irq_nosync(up->port.irq);
> 
> NAK. Either use IRQF_ONESHOT or actually mask the IRQs at the device's
> registers (basically clearing IER).

Given the work that's been done on the 8250 based driver, what are the
short-term chances omap-serial will be dropped? I'd be happy to improve
here if it makes sense to do so. If the 8250 based driver is going to
replace omap-serial anyway on the short term, I don't see the point of
further developing this patch. The others would still make sense in my
opinion.

Thanks,
Frans
