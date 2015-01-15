From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Thu, 15 Jan 2015 10:12:19 -0800
Message-ID: <20150115181219.GH18552@atomide.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
 <1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
 <20150114222814.GU2419@atomide.com>
 <871tmwi0d6.fsf@approximate.cambridge.arm.com>
 <20150115144016.GA19920@kahuna>
 <87sifcgksy.fsf@approximate.cambridge.arm.com>
 <20150115170443.GF18552@atomide.com>
 <54B7F8CC.3070901@arm.com>
 <20150115175701.GG18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150115175701.GG18552@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kerne>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150115 10:04]:
> * Marc Zyngier <marc.zyngier@arm.com> [150115 09:31]:
> > On 15/01/15 17:04, Tony Lindgren wrote:
> > > * Marc Zyngier <marc.zyngier@arm.com> [150115 06:53]:
> > >> On Thu, Jan 15 2015 at  2:40:16 pm GMT, Nishanth Menon <nm@ti.com> wrote:
> > >>> On 14:28-20150115, Marc Zyngier wrote:
> > >>>> Assuming the workaround I posted earlier works, the OMAP/DRA7 part of
> > >>>> this series is going to require some rework too (I need to know where
> > >>>> these legacy interrupts are attached: crossbar, WUGEN, or GIC?).
> > >>>>
> > >>> crossbar will never work with legacy static interrupts anyways - since
> > >>> there was never a static interrupt possible - I believe we had removed
> > >>> all the legacy hardcoded interrupt definitions for DRA7. ideally, they
> > >>> should all be dt only now.
> > >>
> > >> Yes, I guessed as much after looking at the DRA7XX hwmod.
> > >>
> > >> So only OMAP4/5 is b0rken at the moment. I can probably work around it
> > >> as I did in this example patch, just by changing the compatible strings
> > >> for the xlate callback. Very ugly.
> > > 
> > > For the -rc, it seems the wakeupen still needs a fix as based on grepping
> > > for OMAP44XX_IRQ_GIC_START. Got any great ideas for that?
> > 
> > I think this one is fine. It computes the SPI number based on the hwirq
> > coming from the GIC. That direction is completely unaffected by the
> > linear domain stuff. It is only when you try to use a hardware IRQ as a
> > Linux IRQ that you run into trouble.
> 
> Yes OK that makes sense.

And suspend and resume seem to work with your fix.

FYI, to test suspend and resume with wakeups from the serial console,
the uart wakeup events need to be enabled under sys:

#!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
        echo enabled > $uart/wakeup 2>&1
done

And after that suspending with echo mem > /sys/power/state should wake
to a serial interrupt.

Regards,

Tony
