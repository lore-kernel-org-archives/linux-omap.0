From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Seeking clarity on IRQCHIP_MASK_ON_SUSPEND
Date: Mon, 10 Sep 2012 15:25:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1209101524040.2724@ionos>
References: <20120910165127.37dd07f3@notabene.brown> <alpine.LFD.2.02.1209101215300.2724@ionos> <CAMQu2gzp1mieitAtDWB8Uud97gFQjH7eZ-bDZ2kMBLejAx4qMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gzp1mieitAtDWB8Uud97gFQjH7eZ-bDZ2kMBLejAx4qMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: NeilBrown <neilb@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Sep 2012, Shilimkar, Santosh wrote:
> Thomas,
> 
> On Mon, Sep 10, 2012 at 3:58 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, 10 Sep 2012, NeilBrown wrote:
> >>
> >> The IRQCHIP_MASK_ON_SUSPEND flag seems to be hard to use correctly, so either
> >> I'm understanding it wrongly, or it could be made easier to use.
> >> If the first case, I'm hoping that some improvement to documentation might
> >> result.  If the second, then maybe we can fix the code.
> > ...
> >> Is anyone able to give a definitive answer on this?  Should
> >> IRQCHIP_MASK_ON_SUSPEND be removed?
> >
> > The whole point of IRQCHIP_MASK_ON_SUSPEND is to deal with hardware
> > designed by geniuses.
> >
> > Most SoCs have a way to mark the interrupts which serve as a wake up
> > source as such. All other interrupts are magically "masked" on entry
> > to suspend.
> >
> Just to support this, IRQCHIP_MASK_ON_SUSPEND does work with quite
> a few ARM platforms too. OMAP already uses it in mainline and I have
> seen patches for U500 and Tegra SOCs. Most of these usages are with
> IRQ chips who doesn't have any driver run time PM supported and
> the IRQ CHIP itself is shutdown when the CPU/CPU cluster gets
> power down. So as far as functionality concerned with the flag,
> it does what it suppose to do.
> 
> > Now there is hardware which is missing such a control, so we need to
> > mask the non wakeup interrupts right before going into suspend.
> >
> > That's what IRQCHIP_MASK_ON_SUSPEND does. Not more, not less. See
> > commit d209a699a0b for more ugly details.
> >
> > You might be looking for a different functionality. Can you explain
> > what you need?
> >
> Neil's email came from a discussion on the usage of this flag for
> OMAP GPIO irqchip which I proposed. With the flag, when the
> lazy check_irq routine is called, the GPIO driver is runtime suspended
> and hence the late mask/unmask calls take abort(clocks are already gated).
> GPIO IRQCHIP is secondary IRQCHIP connected to 1 interrupt line
> per bank(32 GPIOs) to the primary interrupt controller IRQCHIP.

So for this thing you need a IRQCHIP_MASK_BEFORE_SUSPEND variant? 
