From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 REPOST 5/5] imx6q: Remove unconditional dependency on
 l2x0 L2 cache support
Date: Thu, 15 Dec 2011 09:02:20 +0800
Message-ID: <20111215010219.GP28768@b20223-02.ap.freescale.net>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
 <20111214132622.GA1520@S2100-06.ap.freescale.net>
 <20111214140500.GA1700@richard-laptop>
 <20111214150119.GD2568@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111214150119.GD2568-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 03:01:19PM +0000, Dave Martin wrote:
> On Wed, Dec 14, 2011 at 10:05:04PM +0800, Richard Zhao wrote:
> > On Wed, Dec 14, 2011 at 09:26:24PM +0800, Shawn Guo wrote:
> > > Hi Dave,
> > > 
> > > Sorry for that I did not look into previous post to point it out.
> > > 
> > > On Wed, Dec 14, 2011 at 11:39:41AM +0000, Dave Martin wrote:
> > > > The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> > > > support built into the kernel, so this patch removes the dependency
> > > > on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.
> > > > 
> > > > This makes the l2x0 support optional, so that it can be turned off
> > > > when desired for debugging purposes etc.
> > > > 
> > > > Thanks to Shawn Guo for this suggestion. [1]
> > > > 
> > > > Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > 
> > > > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> > > > ---
> > > >  arch/arm/mach-imx/Kconfig |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > > index 29a3d61..1fb93f2 100644
> > > > --- a/arch/arm/mach-imx/Kconfig
> > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > @@ -609,13 +609,13 @@ comment "i.MX6 family:"
> > > >  config SOC_IMX6Q
> > > >  	bool "i.MX6 Quad support"
> > > >  	select ARM_GIC
> > > > -	select CACHE_L2X0
> > > >  	select CPU_V7
> > > >  	select HAVE_ARM_SCU
> > > >  	select HAVE_IMX_GPC
> > > >  	select HAVE_IMX_MMDC
> > > >  	select HAVE_IMX_SRC
> > > >  	select HAVE_SMP
> > > > +	select MIGHT_HAVE_CACHE_L2X0
> > > 
> > > The option SOC_IMX6Q is only available when ARCH_IMX_V6_V7 is selected.
> > > Since MIGHT_HAVE_CACHE_L2X0 has been selected by ARCH_IMX_V6_V7 in
> > > patch #1, this line seems redundant here.
> > Would it be better keep this one and remove patch #1 one? imx5 doesn't have
> > l2x0.
> 
> Do you mean to remove MIGHT_HAVE_CACHE_L2X0 from ARCH_IMX_V6_V7, and select
> it only from SOC_IMX6Q?
Yes, I think it's more precise. Shawn?

Thansk
Richard
> 
> Cheers
> ---Dave
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
