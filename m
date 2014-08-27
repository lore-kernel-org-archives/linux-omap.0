From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Wed, 27 Aug 2014 13:23:14 -0700
Message-ID: <20140827202313.GF16006@atomide.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-16-git-send-email-bigeasy@linutronix.de>
 <20140815210211.GD9239@atomide.com>
 <53F5AF0D.5060409@linutronix.de>
 <20140821184416.GF10066@atomide.com>
 <53FE3779.5090908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53FE3779.5090908@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140827 12:54]:
> On 08/21/2014 08:44 PM, Tony Lindgren wrote:
> >>> Also, with DMA enabled, looks like omap deeper idle states are
> >>> blocked as the DMA stays reserved. After I commented out the
> >>> DMA info for my console UART, PM started working.
> >>
> >> Hmm. This would explain something. This would mean that I should cancel
> >> the RX DMA transfer in the PM-suspend routine. Let me see how that
> >> works.
> > 
> > OK and if the DMA works with PM, then I don't see why we would not
> > want to have it automatically enabled.
> 
> I re-did that part where the registers are restored. Mostly for that
> reason to use function in runtime_resume() as in set_termios(). I think
> that is cute :) _And_ if somebody changes here something and breaks it
> then it doesn't work with and without runtime-pm. It looks like the
> omap-serial doesn't restore the XON1 & XOFF1 registers.
> 
> While at it I made sure that it works as good as I could and that means:
> 
> core_pwrdm
> (ON),OFF:182,RET:21,INA:131,ON:335,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

Hey that's great, that's the ultimate torture test here!
There's nothing like rebooting the system every time you hit
idle and still have drivers working :)
 
> The core off part with DMA looks like a no no:
> I #if 0 the block in where it assigned up.dma. With this I hit
> core-off. Step two was
> 
> |static void omap8250_update_scr(struct uart_8250_port *up,
> |                 struct omap8250_priv *priv)
> |{
> |serial_out(up, UART_OMAP_SCR, priv->scr | OMAP_UART_SCR_DMAMODE_CTL);
> |serial_out(up, UART_OMAP_SCR, priv->scr | OMAP_UART_SCR_DMAMODE_CTL |
> OMAP_UART_SCR_DMAMODE_1);
> |serial_out(up, UART_OMAP_SCR, priv->scr | |OMAP_UART_SCR_DMAMODE_CTL);
> |serial_out(up, UART_OMAP_SCR, priv->scr);
> |}
> 
> which means I just enable DMA mode in UART and disable it. No DMA
> operations were performed.
> With this change I see a lost character now and then which means the
> UART-IP goes into off and loses its context. Good. However I don't see
> core off anymore. This looks like a bug beyond my responsibilities :)

OK, that sounds like a bug still lurking around somewhere. The core
domain won't hit idle if there are any hardware pieces blocking.

> I added code to cancel & and start DMA transfers in runtime suspend
> callbacks.

Do you mean just the OMAP_UART_SCR_DMAMODE_CTL related code, or
also the dmaengine calls?

> However core-off with DMA won't work. I think we could document this in
> the binding document. What do you think?

There should not be such a limitation though. Maybe dump out the values
of cm_idlest_per and cm_idlest1_core for working and failing off idle
cases and see what the difference is?

It could be the either the dma or the uart hardware blocking. I guess
it could be also an issue with runtime pm use somewhere.

> > BTW, looks like the ports move around now though. If set a port
> > to disabled with status = "disabled"; in the .dts file, you'll get
> > a different console which does not happen with omap-serial I believe.
> 
> You a right. I fixed it in the 8250-core code.

OK thanks.

Tony
