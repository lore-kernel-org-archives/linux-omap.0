From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] ARM: AM33XX: hwmod: Add OMAP_INTC_START offset to
 all module int nos
Date: Wed, 12 Sep 2012 22:02:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB2BB0@DBDE01.ent.ti.com>
References: <1347484551-11775-1-git-send-email-hvaibhav@ti.com>
 <1347484551-11775-3-git-send-email-hvaibhav@ti.com>
 <20120912215232.GE5997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120912215232.GE5997@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 13, 2012 at 03:22:32, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120912 14:17]:
> > With recent migration of omap architectures to SPARSE_IRQ framework,
> > it is important to add OMAP_INTC_START to all interrupt numbers
> > which will be eventually requested by drivers.
> > 
> > This is required in order to get AM33XX boot functionality.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  168 ++++++++++++++--------------
> >  1 files changed, 84 insertions(+), 84 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > index 7b7ed08..3c320f4 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> 
> You should just have on top of this file:
> 
> #define OMAP_INTC_START		0
> 
> Then Paul can apply this, and while merging with the sparseirq
> changes, the above can be removed.
> 

Ok, I will add this at the top of the file and resend this patch.


> > @@ -72,7 +72,7 @@ static struct omap_hwmod_class am33xx_emif_hwmod_class = {
> >  };
> >  
> >  static struct omap_hwmod_irq_info am33xx_emif_irqs[] = {
> > -	{ .name = "ddrerr0", .irq = 101 },
> > +	{ .name = "ddrerr0", .irq = 101 + OMAP_INTC_START },
> >  	{ .irq = -1 }
> >  };
> >  
> 
> Then these should be fixed up to have trailing commas
> as requested by Russell earlier on several occasions.
> 

Ok, I will fix this and all other places as well and resend.

Thanks,
Vaibhav
