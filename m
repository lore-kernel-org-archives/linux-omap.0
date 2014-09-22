From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 22 Sep 2014 10:46:05 +0300
Message-ID: <20140922074605.GB26114@xps8300>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5419B825.5000201@linutronix.de>
 <20140919102212.GA31784@xps8300>
 <541C0C64.5010206@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541C0C64.5010206@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 19, 2014 at 12:58:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 09/19/2014 12:22 PM, Heikki Krogerus wrote:
> > Couldn't you just replace the handle_irq with a custom irq routine in
> > the omap driver like you did with set_termios? Where you would do
> > those tricks and/or call serial8250_handle_irq()?
> 
> Tricks within serial8250_handle_irq(), see [0]. It is not a lot but
> still. I could provide my own handle irq, just asking what you would
> prefer.
> 
> [0]
> http://git.breakpoint.cc/cgit/bigeasy/linux.git/commit/?h=uart_v10_pre2&id=f26f161d998ee4a84a0aa6ddff69a435c25f204d
> 
> > The 8250_core changes in that patch #10 only modify
> > serial8250_handle_irg right?
> 
> Correct. However there is another change due to the RX_DMA_BUG. A while
> ago you said that this RX_DMA_BUG thing might be something that other
> SoC could use, too.
> If you ask me now for my own irq routine it would make sense to move RX
> bug handling into omap specific code as well.

Well, there are no other SoCs at the moment that would need it, and
it's actually possible that there never will be. So yes, just handle
that also in the omap specific code.


Thanks,

-- 
heikki
