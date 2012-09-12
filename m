From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: AM33XX: hwmod: Add OMAP_INTC_START offset to
 all module int nos
Date: Wed, 12 Sep 2012 23:38:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209122330580.7275@utopia.booyaka.com>
References: <1347484551-11775-1-git-send-email-hvaibhav@ti.com> <1347484551-11775-3-git-send-email-hvaibhav@ti.com> <20120912215232.GE5997@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120912215232.GE5997@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Wed, 12 Sep 2012, Tony Lindgren wrote:

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

This change has been made.

> Then these should be fixed up to have trailing commas
> as requested by Russell earlier on several occasions.

I've taken the script you sent and run it on the data file - thanks for 
the script - and will send the updated pull request shortly.  Sounds like 
Russell should send patches for Documentation/CodingStyle and 
scripts/checkpatch.pl so it can be agreed as a kernel-wide policy.


- Paul
