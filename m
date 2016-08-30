From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/5] mfd: tps65217: Add support for IRQs
Date: Tue, 30 Aug 2016 10:04:30 +0100
Message-ID: <20160830090430.GE1661@dell>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-2-m.niestroj@grinn-global.com>
 <576D0437.1020800@ti.com>
 <c339a5bb-7e0d-bda4-2d76-38808977d3f6@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c339a5bb-7e0d-bda4-2d76-38808977d3f6@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 29 Aug 2016, Marcin Niestroj wrote:

> ping

Again, 2 pings on a patch which has a Maintainer Ack.  Why?

If you're still missing Acks on some patches in the set, resend the set!

> On 24.06.2016 11:58, Grygorii Strashko wrote:
> > On 06/20/2016 01:50 PM, Marcin Niestroj wrote:
> > > Add support for handling IRQs: power button, AC and USB power state
> > > changes. Mask and interrupt bits are shared within one register, which
> > > prevents us to use regmap_irq implementation. New irq_domain is
> > > created in
> > > order to add interrupt handling for each tps65217's subsystem. IRQ
> > > resources have been added for charger subsystem to be able to notify
> > > about
> > > AC and USB state changes.
> > > 
> > > Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > > Changes v3 -> v4 (suggested by Grygorii):
> > >   * Add irq_set_parent() during irq init
> > >   * Remove hardcoded IRQ trigger type, rely on DT bindings instead
> > > 
> > > Changes v2 -> v3 (suggested by Lee):
> > >   * Alphabetical reorder of includes
> > >   * Rename enum tps65217_irqs -> tps65217_irq_type, so we won't confuse
> > >     it with structure object with the same name.
> > >   * Fix inconsistent order of irq_enable and irq_disable
> > >   * Remove redundant 'else' when returning from tps65217_irq_thread
> > > 
> > > Changes v1 -> v2: none
> > > 
> > >   drivers/mfd/Kconfig          |   1 +
> > >   drivers/mfd/tps65217.c       | 195
> > > +++++++++++++++++++++++++++++++++++++++++--
> > >   include/linux/mfd/tps65217.h |  12 +++
> > >   3 files changed, 200 insertions(+), 8 deletions(-)
> > > 
> > 
> > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > 
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
