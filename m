From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 00/21] irqchip: gic: killing =?UTF-8?Q?gic=5Farch?=  =?UTF-8?Q?=5Fextn=20and=20co=2C=20slowly?=
Date: Sat, 10 Jan 2015 13:45:32 +0000
Message-ID: <cce4dbf67f406d352e1200c5cf84675e@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2015-01-07 17:42, Marc Zyngier wrote:
> The gic_arch_extn hack that a number of platform use has been nagging
> me for too long. It is only there for the benefit of a few platform,
> and yet it impacts all GIC users. Moreover, it gives people the wrong
> idea ("let's use it to put some new custom hack in there"...).
>
> But now that stacked irq domains have landed in -next, the time has
> come for gic_arch_extn to meet the Big Bit Bucket.
>
> This patch series takes several steps towards the elimination of
> gic_arch_extn:
>
> - moves Tegra's legacy interrupt controller support to
>   drivers/irqchip, implementing a stacked domain on top of the
>   standard GIC.
>
> - OMAP, imx6 and exynos are also converted to stacked domains, but
>   their implementation is left in place (the code is far too
>   intricately mixed with other details of the platform for me to even
>   try to move it). Some OMAP variants get a special treatment as we
>   also kill the crossbar horror (more on that below).
>
> - shmobile, ux500 and zynq are only slightly modified.
>
> - The GIC itself is cleaned up, and some other bits and bobs are
>   adjusted for a good measure.
>
> About the TI crossbar:
>
> - The allocation of interrupts in this domain is fairly similar to
>   what we do for MSI (see the GICv2m driver), and stacked domains 
> have
>   proved to be a fitting solution.
>
> - The current description in DT is currently entierely inaccurate, 
> and
>   as we already broke it for the OMAP WUGEN block, we might as well 
> do
>   it again for the TI crossbar.
>
> - The way crossbar, WUGEN and GIC interract is quite complex (this is
>   effectively a stack of three interrupt controllers with interesting
>   exceptions and braindead routing), and stacked domains are the 
> right
>   abstraction for that.
>
> - Other platforms (Freescale Vybrid) are starting to come up with the
>   same type of things, and it'd be good to avoid them following the
>   same broken model.
>
> - It removes a few lines from the code base so it can't completely be
>   a bad idea!
>
> So this patch series does exactly that: make the crossbar a stacked
> interrupt controller that only takes care of setting up the routing,
> fix the DTs to represent the actual HW, and remove a bit of the
> craziness from the GIC code.
>
> It is worth realizing that:
>
> - I haven't been able to test this as much as I would have wanted to
>   (it's only been tested on tegra2 and omap5).
>
> - I've created DT bindings when needed, updated existing ones, but I
>   haven't created a binding for platforms that already used an
>   undocumented one (imx6, I'm looking at you).
>
> - I've relaxed quite a bit of the locking in the GIC code. I believe
>   this is safe, but someone else should give it a long hard look.
>
> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...
>
> As for the patches, they are on top of 3.19-rc3.
>
> I've pushed the code to:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> irq/die-gic-arch-extn-die-die-die

I've updated this branch with the changes requested in this review 
cycle. I'll give it a test run on Monday with the platforms I have 
around (mainly Tegra20 and OMAP4/5).

Unless anything major comes up, I'll post v3 with a view of getting 
this into 3.20.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
