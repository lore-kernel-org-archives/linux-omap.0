From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 21 Mar 2017 08:41:22 -0700
Message-ID: <20170321154122.GB10760@atomide.com>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-2-tony@atomide.com>
 <20170320151413.GT6986@localhost.localdomain>
 <20170320153341.GK20572@atomide.com>
 <20170321092340.GU6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321092340.GU6986@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Charles Keepax <ckeepax@opensource.wolfsonmicro.com> [170321 02:24]:
> On Mon, Mar 20, 2017 at 08:33:42AM -0700, Tony Lindgren wrote:
> > * Charles Keepax <ckeepax@opensource.wolfsonmicro.com> [170320 08:15]:
> > > On Thu, Mar 16, 2017 at 05:36:30PM -0700, Tony Lindgren wrote:
> > > > At least Motorola CPCAP PMIC needs it's device interrupts re-read
> > > > until there are no more interrupts. Otherwise the PMIC interrupt to
> > > > the SoC will eventually stop toggling.
> > > > 
> > > > Let's allow doing that by introducing a flag for handle_reread
> > > > and by splitting regmap_irq_thread() into two separate functions
> > > > for regmap_read_irq_status() and regmap_irq_handle_pending().
> > > > 
> > > 
> > > Is this actually a property of this hardware or is this just a
> > > result of connecting a device that generates level IRQs to a host
> > > that is expecting an edge triggered IRQ?
> > 
> > Well the CPCAP PMIC interrupt is connected to a GPIO edge interrupt
> > on the SoC in the Motorola v3.8 based kernel tree. But what the CPCAP
> > PMIC interrupt handler does in the Motorola kernel is keep handling
> > the CPCAP internal interrupts (and also keep reading the SoC GPIO
> > line status!) until the GPIO line changes status. So yeah it's a
> > property of the CPCAP PMIC hardware.
> > 
> 
> That sounds a lot like a level triggered IRQ. If they are
> repeatedly reading the GPIO line until it returns to high to know
> they need to process more IRQs, that implies the line is staying
> low whilst IRQs need handling which is level triggered.

Yeah.. Actually my description above is a bit wrong sorry. It seems
the GPIO line changes status too early in some cases meaning the
interrupts stop. So it's like a buggy implementation of level IRQ
that stops driving the GPIO interrupt line to the SoC in some cases
even with PMIC interrupts pending. So it seems like a bug in the
CPCAP PMIC.

So the handling needs to be "read while CPCAP interrupts in the
registers even if the GPIO line to SoC has cleared stopped
signaling interrupts" :)

> > Changing the GPIO interrupt to level makes no difference here. It's
> > not clear why they had marked the CPCAP PMIC to SoC GPIO interrupt
> > as edge though in the Motorola kernel. My guess is that some PMIC
> > to SoC wake-up events are edge interrupts. So we have it set up as
> > edge interrupt in the mainline kernel too.
> > 
> 
> I guess my only comment here is are we sure this isn't a bug in
> supporting level IRQs in the GPIO driver, of course it could be
> that the SoC simply doesn't support level IRQs that is fairly
> common as well. But I guess we should be clear in the commit
> message if this is adding emulation of level triggered IRQs and
> possible add some gating on type of IRQ requested.

Yeah well the SoC variants in this case have been supporting edge
and level interrupts with gpio-omap.c for quite some time.
I doubt that's the issue here, there are not even that many
interrupts coming from the CPCAP. And I've verified the same issue
happens with both edge and level configured GPIOs. There is nothing
pending on the GPIO line.

There is one pending GPIO regression fix when using gpio-omap.c
with gpio-ir-recv.c affecting edge interrupts, but I've also
tested that fix and it makes no difference.

Regards,

Tony
