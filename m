From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 06/21] ARM: tegra: remove old LIC support
Date: Thu, 8 Jan 2015 12:29:55 +0100
Message-ID: <20150108112954.GK1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-7-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-7-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2015 at 05:42:41PM +0000, Marc Zyngier wrote:
[...]
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
[...]
>  void __init tegra_init_irq(void)
>  {
> -	int i;
> -	void __iomem *distbase;
> -
> -	if (of_find_matching_node(NULL, tegra_ictlr_match))
> -		goto skip_extn_setup;
> -
> -	tegra_legacy_irq_syscore_init();
> -
> -	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
> -	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
> -
> -	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
> -		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %d.",
> -			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));
> -		num_ictlrs = ARRAY_SIZE(ictlr_reg_base);
> -	}
> -
> -	for (i = 0; i < num_ictlrs; i++) {
> -		void __iomem *ictlr = ictlr_reg_base[i];
> -		writel(~0, ictlr + ICTLR_CPU_IER_CLR);
> -		writel(0, ictlr + ICTLR_CPU_IEP_CLASS);
> -	}
> -
> -	gic_arch_extn.irq_ack = tegra_ack;
> -	gic_arch_extn.irq_eoi = tegra_eoi;
> -	gic_arch_extn.irq_mask = tegra_mask;
> -	gic_arch_extn.irq_unmask = tegra_unmask;
> -	gic_arch_extn.irq_retrigger = tegra_retrigger;
> -	gic_arch_extn.irq_set_wake = tegra_set_wake;
> -	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
> +	if (!of_find_matching_node(NULL, tegra_ictlr_match))
> +		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");

I'm not very happy about the ABI breakage here, but I also realize that
we need this change to properly describe the hardware. To make it more
obvious that people really should update their DTBs, maybe turn this
into a WARN()?

> -skip_extn_setup:
>  	tegra114_gic_cpu_pm_registration();

I'm not intimately familiar with the GIC, but is this really SoC
specific? Doesn't anybody else need this? Comparing to the GIC spec the
write of 0x1e0 to the GIC_CPU_CTRL register (which I assume corresponds
to GICC_CTLR in the spec), this simply disables the IRQ and FIQ bypass
signals for both group 0 and group 1.

Thierry

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrmoyAAoJEN0jrNd/PrOhu1wP/RtpeWYFylfZC7uKVM7d2+Um
ywP7hZ2o6vDLe5SkghstWJfcoE1VFW1VQSpMopHaC31Ig5yTUDUDmEel+FndETj0
3P+4O5wBaxAT9unY7xivINlUuPIHxaobbSzSE8EEEEezOcT1SIf6P/rZSPEEM0my
2FMdp6JPv3CQgobNe0U+5mUspcblMMG7liOz1Xnf+qH1crX45bGFjp91Ay5MVgEW
W/zDMRr19pHcrW/Xh/lrX/+M1VllXzsZHHiK+2tXKdnjmdBfCWKKJKIOknpRIp6W
Ww5mSaetS+g0MNwVHiijc5zUEM6StjG7M+gpTzyMJ0MXwQF5anLqYvvaXHWITnY1
x5lyqZEW7lfSAdKCjyvgQDmu4RNjdHNVbH7/WO+Wuu5USuyp8Zk8p8x7cFkSKvja
ela3OAlhCnLvqVEiEM3H2RJJ/wLolu73CqK1avYUOOwjPysRkJvo4yBAMHlCkUIG
IeaMHbB0jgZMo3oG/fvcIpY7vBqXL+GyvF3m8uryrjV3q8YGtSCnJLH3HOJ2nVp4
CZGcg3OMNKHTc+wmXBu+JEBF2vY5ESeVd9Q651/ptFSOtiCjSBmlWgNONyj/Z7+6
r+lhXz56sFhpW0v21XXjrp49RXzY67Oz1CeL4cg73MLE2Y1gHRAag86FPLU1giOe
0TBbPEXl7UR+yUba5OSE
=K1QU
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
