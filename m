From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
Date: Thu, 8 Jan 2015 11:13:53 +0100
Message-ID: <20150108101351.GD1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:50271 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbAHKN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 05:13:58 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 05:42:37PM +0000, Marc Zyngier wrote:
> Tegra's LIC (Legacy Interrupt Controller) has been so far only
> supported as a weird extension of the GIC, which is not exactly
> pretty.
>=20
> The stacked irq domain framework fits this pretty well, and allows

Nit: s/irq/IRQ/

> the LIC code to be turned into a standalone irqchip. In the process,
> make the driver DT aware, something that was sorely missing from
> the mach-tegra implementation.
>=20
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/Makefile    |   1 +
>  drivers/irqchip/irq-tegra.c | 335 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 336 insertions(+)
>  create mode 100644 drivers/irqchip/irq-tegra.c

This matches largely what I have in a local patch (modulo the stacked
domains vs. gic_arch_extn). A few comments below.

> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 9516a32..59f34be 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_ARCH_HIP04)		+=3D irq-hip04.o
>  obj-$(CONFIG_ARCH_MMP)			+=3D irq-mmp.o
>  obj-$(CONFIG_ARCH_MVEBU)		+=3D irq-armada-370-xp.o
>  obj-$(CONFIG_ARCH_MXS)			+=3D irq-mxs.o
> +obj-$(CONFIG_ARCH_TEGRA)		+=3D irq-tegra.o
>  obj-$(CONFIG_ARCH_S3C24XX)		+=3D irq-s3c24xx.o

Should these be sorted alphabetically?

> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
[...]
> +#define TEGRA_MAX_NUM_ICTLRS	5
> +
> +static int num_ictlrs;

This could be unsigned int.

> +struct tegra_ictlr_info {
> +	void __iomem *ictlr_reg_base[TEGRA_MAX_NUM_ICTLRS];

Maybe only "reg_base" or "base". The ictlr_ prefix is redundant.

> +#ifdef CONFIG_PM_SLEEP
> +	u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cop_iep[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cpu_ier[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cpu_iep[TEGRA_MAX_NUM_ICTLRS];
> +
> +	u32 ictlr_wake_mask[TEGRA_MAX_NUM_ICTLRS];

Same here.

> +#endif
> +};
> +
> +static struct tegra_ictlr_info *tegra_ictlr_info;

This variable name could be shorter, say "lic", to make some of the code
below more terse.

> +static int tegra_ictlr_suspend(void)
> +{
> +	unsigned long flags;
> +	int i;

This could be unsigned int, too.

[...]
> +static void tegra_ictlr_resume(void)
> +{
> +	unsigned long flags;
> +	int i;

And here.

> +static struct syscore_ops tegra_ictlr_syscore_ops =3D {
> +	.suspend	=3D tegra_ictlr_suspend,
> +	.resume		=3D tegra_ictlr_resume,
> +};
> +
> +static int tegra_ictlr_syscore_init(void)
> +{
> +	register_syscore_ops(&tegra_ictlr_syscore_ops);
> +
> +	return 0;
> +}
> +#else
> +#define tegra_set_wake	NULL
> +static inline void tegra_ictlr_syscore_init(void) {}
> +#endif

Both prototypes for tegra_ictlr_syscore_init() should match here. Since
it never fails, returning void for both should be fine.

> +static struct irq_chip tegra_ictlr_chip =3D {
> +	.name		=3D "ICTLR",

Maybe name it "LIC" since that's the more common name for it?

> +static int tegra_ictlr_domain_xlate(struct irq_domain *domain,
> +				    struct device_node *controller,
> +				    const u32 *intspec,
> +				    unsigned int intsize,
> +				    unsigned long *out_hwirq,
> +				    unsigned int *out_type)
> +{
> +	if (domain->of_node !=3D controller)
> +		return -EINVAL;	/* Shouldn't happen, really... */
> +	if (intsize !=3D 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (intspec[0] !=3D 0)

Maybe use GIC_SPI from dt-bindings/interrupt-controller/arm-gic.h here?
To match the DTS content?

> +static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq,
> +				    unsigned int nr_irqs, void *data)
> +{
> +	struct of_phandle_args *args =3D data;
> +	struct of_phandle_args parent_args;
> +	struct tegra_ictlr_info *info =3D domain->host_data;
> +	irq_hw_number_t hwirq;
> +	int i;

unsigned int?

> +
> +	if (args->args_count !=3D 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (args->args[0] !=3D 0)

GIC_SPI?

> +	hwirq =3D args->args[1];
> +	if (hwirq >=3D (num_ictlrs * 32))
> +		return -EINVAL;	/* Can't deal with this */

Not sure if that comment is necessary here. It's fairly obvious why this
is an error. But it doesn't hurt, so if you prefer to leave it, that's
fine with me.

> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		int ictlr =3D (hwirq + i) / 32;

irq_hw_number_t? Or unsigned int?

> +
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &tegra_ictlr_chip,
> +					      &info->ictlr_reg_base[ictlr]);
> +	}
> +
> +	parent_args =3D *args;
> +	parent_args.np =3D domain->parent->of_node;
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args=
);
> +}
> +
> +

There's an extra blank line here.

> +static void tegra_ictlr_domain_free(struct irq_domain *domain,
> +				    unsigned int virq,
> +				    unsigned int nr_irqs)
> +{
> +	int i;

unsigned int?

> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		struct irq_data *d =3D irq_domain_get_irq_data(domain, virq + i);
> +		irq_domain_reset_irq_data(d);
> +	}
> +}

Aren't you missing a call to irq_domain_free_irqs_parent() here? If so,
why not use irq_domain_free_irqs_common() instead?

> +static struct irq_domain_ops tegra_ictlr_domain_ops =3D {

static const?

> +	.xlate	=3D tegra_ictlr_domain_xlate,
> +	.alloc	=3D tegra_ictlr_domain_alloc,
> +	.free	=3D tegra_ictlr_domain_free,
> +};
> +
> +static int __init tegra_ictlr_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	int err;
> +	int i;

unsigned int?

> +
> +	if (!parent) {
> +		pr_err("%s: no parent, giving up\n", node->full_name);
> +		return -ENODEV;
> +	}
> +
> +	parent_domain =3D irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		return -ENXIO;
> +	}
> +
> +	tegra_ictlr_info =3D kzalloc(sizeof(*tegra_ictlr_info), GFP_KERNEL);
> +	if (!tegra_ictlr_info)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < TEGRA_MAX_NUM_ICTLRS; i++) {
> +		void __iomem *base;
> +
> +		base =3D of_iomap(node, i);
> +		if (!base)
> +			break;
> +
> +		tegra_ictlr_info->ictlr_reg_base[i] =3D base;
> +
> +		/* Disable all interrupts */
> +		writel_relaxed(~0, base + ICTLR_CPU_IER_CLR);

I think you used ~0ul elsewhere, so maybe make this (or the other
instances) consistent?

> +		/* All interrupts target IRQ */
> +		writel_relaxed(0, base + ICTLR_CPU_IEP_CLASS);
> +
> +		num_ictlrs++;
> +	}
> +
> +	if (!num_ictlrs) {
> +		pr_err("%s: no valid regions, giving up\n", node->full_name);
> +		err =3D -ENOMEM;
> +		goto out_free;
> +	}

The local patch that I have does this slightly differently. We have a
tiny table of struct of_device_ids that contains the number of interrupt
controllers to expect for a given compatible (see also below). The code
then checks that the node indeed has valid reg entries for each of the
controllers. So this could be something like:

	struct tegra_ictlr_soc {
		unsigned int num_ictlrs;
	};

	static const struct tegra_ictlr_soc tegra20_ictlr_soc =3D {
		.num_ictlrs =3D 4,
	};

	static const struct tegra_ictlr_soc tegra30_ictlr_soc =3D {
		.num_ictlrs =3D 5,
	};

	static const struct of_device_id ictlr_matches[] =3D {
		{ .compatible =3D "nvidia,tegra30-ictlr", .data =3D &tegra30_ictlr_soc },
		{ .compatible =3D "nvidia,tegra20-ictlr", .data =3D &tegra20_ictlr_soc },
		{ }
	};

And in tegra_ictrl_init():

	const struct of_device_id *match;

	match =3D of_match_node(ictlr_matches, node);
	if (!match)
		return -ENODEV;

	soc =3D match->data;

	...

	WARN(num_ictlrs !=3D soc->num_ictlrs,
	     "Found %u interrupt controllers in DT; expected %u.\n",
	     num_ictlrs, soc->num_ictlrs);

> +
> +	domain =3D irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
> +					  node, &tegra_ictlr_domain_ops,
> +					  tegra_ictlr_info);

Do we need to add a select IRQ_DOMAIN_HIERARCHY somewhere for this to
compile? I guess it's already implied by the select ARM_GIC from
ARCH_TEGRA, so maybe we don't have to be explicit.

> +	if (!domain) {
> +		pr_err("%s: failed to allocated domain\n", node->full_name);
> +		err =3D -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	tegra_ictlr_syscore_init();
> +
> +	pr_info("%s: %d interrupts forwarded to %s\n",
> +		node->full_name, num_ictlrs * 32, parent->full_name);
> +
> +	return 0;
> +
> +out_unmap:
> +	for (i =3D 0; i < num_ictlrs; i++)
> +		iounmap(tegra_ictlr_info->ictlr_reg_base[i]);
> +out_free:
> +	kfree(tegra_ictlr_info);
> +	return err;
> +}
> +
> +IRQCHIP_DECLARE(tegra_ictlr, "nvidia,tegra-ictlr", tegra_ictlr_init);

In general we name compatible values after the first generation of the
SoC that introduced them. For the LIC this would be:

	compatible =3D "nvidia,tegra20-ictlr";
=09
With Tegra30 the number of interrupt controllers was increased to 5, so
it needs a new compatible:

	compatible =3D "nvidia,tegra30-ictlr";

Subsequent generations remain compatible with this variant, but they
traditionally get their own compatible, so for Tegra114 we'd get:

	compatible =3D "nvidia,tegra114-ictlr", "nvidia,tegra30-ictlr";

And similar for Tegra124. So I think the IRQCHIP_DECLARE should match on
"nvidia,tegra20-ictlr" instead. For the same reason we should have a
second entry for the "nvidia,tegra30-ictlr" compatible.

Thierry

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrlhfAAoJEN0jrNd/PrOhRm4P/1TKWqo/eG1L3+GwBl9wIxYY
xOddsnCG/s2U9stKqcFlHMnMENuPEMrDHCJlZ6QhrhJjWDnHAl99NnP34Y4up01Y
i2CWdBhKIHHms1AOOGtPc4MntinZUzLwY5CoFdlcv6cLfXdolTtLcF93o3dNoXXb
lpvCwJtiq78nJKSj5PLtFHOfEcLOLvB0Ugq1FlS3kwXyPGLpEuo6n3KljZLbRuN/
u9q6QFbvxmjHjeHLz/PcPSd/MMQahhpsu+ehPGIt38Pk5Ms0DnvPY+l87cDwOgP0
SYLcoRewWY2jPfxCVW4B4hySFTo5CY55lTKkF97LQ8z7yYpf4CsIoH+L/2K1+RBH
YGcrVVfROuASFfxviWKHlyOGHzhrMUJdK3yl6W/CyyR4Au85AIXyz4PLs2Jjs85d
lrQicd0NQ/XQVGmlVV7Pm9qDWpJ95VJOuvgWLIEK8sdAqAi3+tHhyrscQBw1NMCl
rD4lbigCV1V+wJwvKtmKTrvQ8uJcDLQuTrXQtfcCQCKf7Lhv01SnHChnORVg3xdm
0iXivCk8O2ppf+8PYBSOwcy21X6LxMRWCSUKWPUZxUXkCCfn+nqpxJYRqUspHzKx
1Y9kAUmFzZxZH+BCA2iElxCKi7s+E9iTFbtWl1zRtuGO4Lyn+MKFIdruzjKyPZB4
DAYShVuIBYgWbXbYfAGx
=ksOL
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
