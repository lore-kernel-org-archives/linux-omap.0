From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Sat, 8 Aug 2015 08:40:01 -0700
Message-ID: <20150808154001.GB11851@kroah.com>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
 <55C54D49.3090406@hurleysoftware.com>
 <55C5CC95.6030901@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C5CC95.6030901@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 08, 2015 at 11:32:05AM +0200, Sebastian Andrzej Siewior wrote:
> On 08/08/2015 02:28 AM, Peter Hurley wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> >> index 0340ee6ba970..07a11e0935e4 100644
> >> --- a/drivers/tty/serial/8250/8250_omap.c
> >> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> @@ -769,7 +771,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
> >>  		return;
> >>  	}
> >>  
> >> -	dmaengine_pause(dma->rxchan);
> >> +	ret = dmaengine_pause(dma->rxchan);
> >> +	if (WARN_ON_ONCE(ret))
> >> +		priv->rx_dma_broken = true;
> > 
> > No offense, Sebastian, but it boggles my mind that anyone could defend this
> > as solid api design. We're in the middle of an interrupt handler and the
> > slave dma driver is /just/ telling us now that it doesn't implement this
> > functionality?!!?
> 
> This is the best thing I could come up with. But to be fair: This
> happens once _very_ early in the process and is 100% reproducible. The
> WARN_ON should trigger user attention.

Never expect a _user_ to do anything with a WARN_ON except ignore it.

WARN_ON is for developers when something really bad went wrong that you
want to be notified so that you can fix the code to prevent that from
ever happening again.

So this isn't ok, sorry, a user would not know what to do with this at
all except email me asking why the driver is broken because a kernel
"oops" just happened, when in reality, their hardware is broken in a way
that you already know about when you wrote the patch.

You know better than this.

greg k-h
