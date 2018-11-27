From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Tue, 27 Nov 2018 09:55:38 -0800
Message-ID: <20181127175538.GS53235@atomide.com>
References: <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
 <20181126102541.GC10878@ulmo>
 <20181126193212.GN53235@atomide.com>
 <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jonathanh@nvidia.com> [181126 20:17]:
> 
> On 26/11/2018 19:32, Tony Lindgren wrote:
> > * Thierry Reding <treding@nvidia.com> [181126 10:25]:
> >> On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
> >>> The register map documentation I have states the following:
> >>> bit7 INT_POLARITY Select the polarity of the INT output line
> >>> 0: Interrupt line (INT) is low when interrupt is pending (default) RW
> >>> 1: Interrupt line (INT) is high when interrupt is pending
> >>>
> >>> By default the Palmas irq is active low.
> >>
> >> That would confirm that the driver code is correct. My understanding is
> >> that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
> >> to invert the interrupt again in the PMC.
> > 
> > But then why Tegra need to set PALMAS_POLARITY_CTRL_INT_POLARITY
> > if dts has IRQ_TYPE_LEVEL_HIGH? Shouldn't the Palmas default low
> > setting be correct for Tegra if PMC expects active-low interrupt
> > and then inverts it for GIC?
> 
> So I think what is going on here is ...
> 
> 1. For Tegra, the interrupt parent the palmas interrupt in DT is the GIC
>    not the PMC. The PMC does not register an interrupt controller
>    (although to be correct probably should have. I think it had been
>     discussed in the past and Stephen W may know the history here). So
>    the interrupt polarity has to be HIGH otherwise setting the trigger
>    type in the GIC will fail (as it only supports rising edge or level
>    high IIRC).
> 2. However, as Thierry mentioned the Tegra PMC wants an active low
>    interrupt and so the PMC inverts it on entering the PMC. However,
>    given that the GIC interrupts must be active high, the PMC must
>    invert again between the PMC and GIC.
> 
> So looking back my description in the change 7e9d474954f4 was not quite
> accurate because the interrupt from palmas is active high but the PMC
> inverts it. I think that this is quite confusing because we don't have a
> good way to describe this in the DT. If we made the PMC an interrupt
> controller then it would probably be a lot clearer. However, for
> historical reasons this was not done.

OK if Tegra PMC inverts the PMIC interrupt coming in from palmas as
active-high to active-low for PMC, and then PMC again inverts it
from active-low to active-high for GIC then it makes sense.

The only option that works for omap5 at palmas end is if
PALMAS_POLARITY_CTRL_INT_POLARITY is cleared. Setting the SoC internal
pulls does not make a difference, so I suspect there is either some
unknown pull-up/pull-down configuration register in palmas, or there
is an external pull resistor.

But as dra7 is using a gpio interrupt, I'll just change omap5 to use
gpio_wk16 instead of sys_nirq1 too. Will send out a patch shortly.

Regards,

Tony
