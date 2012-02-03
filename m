From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 13:10:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38125 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab2BCUK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 15:10:29 -0500
In-Reply-To: <20120203205401.5ddf241d@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

One other comment..

On Fri, 3 Feb 2012, NeilBrown wrote:

> On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > On Fri, 3 Feb 2012, NeilBrown wrote:
> > 
> > > I can remove this effect with:
> > > 
> > > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > > index f809041..c7ef760 100644
> > > --- a/drivers/tty/serial/omap-serial.c
> > > +++ b/drivers/tty/serial/omap-serial.c
> > > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
> > >  	spin_lock_irqsave(&up->port.lock, flags);
> > >  	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> > >  	spin_unlock_irqrestore(&up->port.lock, flags);
> > > -	pm_runtime_put(&up->pdev->dev);
> > > +	pm_runtime_mark_last_busy(&up->pdev->dev);
> > > +	pm_runtime_put_autosuspend(&up->pdev->dev);
> > >  	return ret;
> > >  }

It's a little surprising that this helps.  The pm_runtime_get*() and 
_put*() in serial_omap_tx_empty() are just intended to ensure that the 
UART's clocks are running for that LSR register read.

Considering your theory that the UART clocks are being cut while there's 
still data in the FIFO, you might consider removing this code at the end 
of transmit_chars():

	if (uart_circ_empty(xmit))
		serial_omap_stop_tx(&up->port);



- Paul
