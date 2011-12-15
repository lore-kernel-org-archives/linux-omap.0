From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v4 REPOST 5/5] imx6q: Remove unconditional dependency on
 l2x0 L2 cache support
Date: Thu, 15 Dec 2011 09:54:15 +0800
Message-ID: <20111215015414.GQ28768@b20223-02.ap.freescale.net>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
 <20111214132622.GA1520@S2100-06.ap.freescale.net>
 <20111214140500.GA1700@richard-laptop>
 <20111214150119.GD2568@linaro.org>
 <20111215010219.GP28768@b20223-02.ap.freescale.net>
 <20111215014619.GB3259@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111215014619.GB3259@S2101-09.ap.freescale.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Dave Martin <dave.martin@linaro.org>, Richard Zhao <richard.zhao@linaro.org>, linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <avorontsov@mvista.com>, Will Deacon <will.deacon@arm.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@google.com>, Paul Mundt <lethal@linux-sh.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 09:46:20AM +0800, Shawn Guo wrote:
> On Thu, Dec 15, 2011 at 09:02:20AM +0800, Richard Zhao wrote:
> > On Wed, Dec 14, 2011 at 03:01:19PM +0000, Dave Martin wrote:
> > > On Wed, Dec 14, 2011 at 10:05:04PM +0800, Richard Zhao wrote:
> > > > On Wed, Dec 14, 2011 at 09:26:24PM +0800, Shawn Guo wrote:
> > > > > Hi Dave,
> > > > > 
> > > > > Sorry for that I did not look into previous post to point it out.
> > > > > 
> > > > > On Wed, Dec 14, 2011 at 11:39:41AM +0000, Dave Martin wrote:
> > > > > > The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> > > > > > support built into the kernel, so this patch removes the dependency
> > > > > > on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.
> > > > > > 
> > > > > > This makes the l2x0 support optional, so that it can be turned off
> > > > > > when desired for debugging purposes etc.
> > > > > > 
> > > > > > Thanks to Shawn Guo for this suggestion. [1]
> > > > > > 
> > > > > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > > > > > 
> > > > > > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> > > > > > ---
> > > > > >  arch/arm/mach-imx/Kconfig |    2 +-
> > > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > > > > index 29a3d61..1fb93f2 100644
> > > > > > --- a/arch/arm/mach-imx/Kconfig
> > > > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > > > @@ -609,13 +609,13 @@ comment "i.MX6 family:"
> > > > > >  config SOC_IMX6Q
> > > > > >  	bool "i.MX6 Quad support"
> > > > > >  	select ARM_GIC
> > > > > > -	select CACHE_L2X0
> > > > > >  	select CPU_V7
> > > > > >  	select HAVE_ARM_SCU
> > > > > >  	select HAVE_IMX_GPC
> > > > > >  	select HAVE_IMX_MMDC
> > > > > >  	select HAVE_IMX_SRC
> > > > > >  	select HAVE_SMP
> > > > > > +	select MIGHT_HAVE_CACHE_L2X0
> > > > > 
> > > > > The option SOC_IMX6Q is only available when ARCH_IMX_V6_V7 is selected.
> > > > > Since MIGHT_HAVE_CACHE_L2X0 has been selected by ARCH_IMX_V6_V7 in
> > > > > patch #1, this line seems redundant here.
> > > > Would it be better keep this one and remove patch #1 one? imx5 doesn't have
> > > > l2x0.
> > > 
> > > Do you mean to remove MIGHT_HAVE_CACHE_L2X0 from ARCH_IMX_V6_V7, and select
> > > it only from SOC_IMX6Q?
> > Yes, I think it's more precise. Shawn?
> > 
> No.
> 
> * imx5 hardware does have L2, and it's just not set up in the kernel
>   (I do not know why).
> * Currently, ARCH_IMX_V6_V7 only covers imx3 and imx6, and both are
>   calling l2x0 init function to set L2 up.
> * When we merge mach-mx5 into mach-imx to have ARCH_IMX_V6_V7 cover
>   imx3, imx5 and imx6, there is no reason for us to not set L2 up for
>   imx5 too.
> 
> So MIGHT_HAVE_CACHE_L2X0 really should be selected by ARCH_IMX_V6_V7.
mx5/cortex-a8 don't use L2X0. But that's ok. MIGHT_HAVE_CACHE_L2X0 is just a hint.
Please Shawn's suggestion.

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
