From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] mfd: cpcap: Use handle_reread flag for interrupts
Date: Mon, 3 Apr 2017 15:32:02 +0100
Message-ID: <20170403143202.mj3jpi7csdfbpgdy@dell>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-3-tony@atomide.com>
 <20170403102122.c6bztacpqmt2xdzw@dell>
 <20170403141454.GG10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403141454.GG10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 03 Apr 2017, Tony Lindgren wrote:

> Hi,
> 
> * Lee Jones <lee.jones@linaro.org> [170403 03:23]:
> > On Wed, 22 Mar 2017, Tony Lindgren wrote:
> > 
> > > On CPCAP we need to keep reading interrupts until there are no
> > > more interrupts. Otherwise the PMIC interrupt to the SoC will at
> > > some point stop toggling. This seems to happen because new CPCAP
> > > device interrupts show up while we're handling.
> > > 
> > > Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Marcel Partap <mpartap@gmx.net>
> > > Cc: Michael Scott <michael.scott@linaro.org>
> > > Tested-by: Sebastian Reichel <sre@kernel.org>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/mfd/motorola-cpcap.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Applied, thanks.
> 
> Sorry this one depends on patch 1/4 for .handle_reread. So this
> one should be reverted or dropped. That will cause trivial merge
> conflicts with patches 2 and 4.
> 
> Please let me know if you want me to resend just patches 2 and 4
> as patches 1 and 2 need more work.

Yes, I found that out (and replied to the regmap patch).

I'll revert them all for now.

Awaiting a subsequent revision.

> > > diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> > > --- a/drivers/mfd/motorola-cpcap.c
> > > +++ b/drivers/mfd/motorola-cpcap.c
> > > @@ -71,6 +71,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
> > >  		.ack_base = CPCAP_REG_MI1,
> > >  		.mask_base = CPCAP_REG_MIM1,
> > >  		.use_ack = true,
> > > +		.handle_reread = true,
> > >  	},
> > >  	{
> > >  		.name = "cpcap-m2",
> > > @@ -79,6 +80,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
> > >  		.ack_base = CPCAP_REG_MI2,
> > >  		.mask_base = CPCAP_REG_MIM2,
> > >  		.use_ack = true,
> > > +		.handle_reread = true,
> > >  	},
> > >  	{
> > >  		.name = "cpcap1-4",
> > > @@ -88,6 +90,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
> > >  		.mask_base = CPCAP_REG_INTM1,
> > >  		.type_base = CPCAP_REG_INTS1,
> > >  		.use_ack = true,
> > > +		.handle_reread = true,
> > >  	},
> > >  };
> > >  
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
