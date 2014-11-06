From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Thu, 6 Nov 2014 12:35:44 -0800
Message-ID: <20141106203544.GE31454@atomide.com>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
 <545BC8C1.4070503@ti.com>
 <545BCF3F.8020705@linutronix.de>
 <CAGo_u6qTqp1Wpo8E26gLpStu_EiRw32gstkCiXw+EWNDWSnHbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6qTqp1Wpo8E26gLpStu_EiRw32gstkCiXw+EWNDWSnHbw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [141106 11:59]:
> On Thu, Nov 6, 2014 at 1:42 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 11/06/2014 08:15 PM, Nishanth Menon wrote:
> >> sounds good to me *IF* omap8250_enable_wakeup (wakeirq handling) is
> >> the way we want to continue doing things for daisychain? -> Tony, can
> >> you comment?
> >> http://marc.info/?l=linux-omap&m=141222144402707&w=2
> >>
> >> I wonder if wakeirq explicit handling is valid anymore and something
> >> given the potential race and alternate approach proposed?
> >
> > The wakeirq logic is already in the driver. So if we go for the
> > alternate approach, the pinctrl patch is obsolete? Or does it mean we
> > get rid of the map8250_enable_wakeup() including the second irq we have
> > now (and keep the pinctl change)?
>
> based on Thomas's feedback we should probably not carry forward
> wakeirq as a seperate irq with it's own request_irq instead it psuedo
> triggers uart's interrupt irq -> I am not clear about the direction

The pinctrl change in this patch and the wake-up events are a separate
issue.

As some omaps need the RX pin remuxed temporarily to GPIO for wake-up
events, the $subject patch seems just fine to me.

For the wake-up interrupts, the issue Thomas was concerned was
re-entrant interrupts and  handling the wake-up interrupts in various
different ways. From hardware point of view the wake-up events behave
like a separate IRQ controller, so the request_irq part is fine.

> Tony wants drivers to take in the approach in the thread above - all I
> wondered was if it had any conflict of pin_sleep -> if the generic
> handler retriggers the irq before the suspend_handler, then
> configuring sleep is gonna break daisychain support. not sure if there
> is any specific direction drivers should take.

The wake-irq is disabled during runtime and should be enabled so
that should not be an issue.
 
> Again, Tony is the right guy to comment about this.

Yeah I'll repost the patches for the generic wake-irq handling.
Fixing up the drivers to use that is trivial once we've agreed on
the generic wake-up event handling.

Regards,

Tony
