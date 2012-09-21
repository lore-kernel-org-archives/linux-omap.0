From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Makefile.boot: Add am335x evm and bone
 targets
Date: Fri, 21 Sep 2012 11:54:55 -0700
Message-ID: <20120921185454.GE28835@atomide.com>
References: <1346435674-6207-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAB0764@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EAB0764@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120910 23:56]:
> On Fri, Aug 31, 2012 at 23:24:34, Hiremath, Vaibhav wrote:
> > This adds am335x-evm and am335x-bone dtb targets to
> > 'make dtbs', just like other platforms.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/Makefile.boot |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> > index 6cf1c2d..1136072 100644
> > --- a/arch/arm/mach-omap2/Makefile.boot
> > +++ b/arch/arm/mach-omap2/Makefile.boot
> > @@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
> >  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
> >  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
> >  dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> > +dtb-$(CONFIG_SOC_AM33XX)	+= am335x-evm.dtb am335x-bone.dtb
> 
> Tony,
> 
> Gentle reminder on this patch !!!

Sorry I'm behind with patches with all the clean up happening right now.
Can you please repost this for fixes the arm-soc/for-next has now moved
these to a common location for CONFIG_MULTIARCH.

The commit is 85594df2 (ARM: dtb: move all dtb targets to common Makefile).

Thanks,

Tony
