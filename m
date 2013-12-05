From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
Date: Thu, 5 Dec 2013 09:29:10 -0800
Message-ID: <20131205172909.GB26766@atomide.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com>
 <20131120192209.GI10317@atomide.com>
 <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
 <20131121000533.GJ10317@atomide.com>
 <20131121014555.GL10317@atomide.com>
 <20131121204814.GC10023@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995Ab3LER3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:29:15 -0500
Content-Disposition: inline
In-Reply-To: <20131121204814.GC10023@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Tony Lindgren <tony@atomide.com> [131121 12:49]:
> * Tony Lindgren <tony@atomide.com> [131120 17:46]:
> > * Tony Lindgren <tony@atomide.com> [131120 16:06]:
> > >=20
> > > They at least had interrupts listed looking at commit 3b9b10. Pro=
bably
> > > the thing to do for now is to revert those changes, and see if we=
 can
> > > just remove the L3 entries from the .dtsi files.
> >=20
> > Actually the patch I posted should be able to handle also the
> > ti,hwmods =3D "l3_main_1", "l3_main_2", "l3_main_3" property in oma=
p4.dtsi,
> > but we're not currently parsing that as we only look at the childre=
n
> > and not the properties of the OCP bus. Should be fixable, will take=
 a look
> > tomorrow if this approach makes sense to you.
>=20
> OK this one seems to do the right thing for me.

No comments? I'll queue the patch below to the fixes, please yell
if you see any issues with that.
=20
> Tony
>=20
>=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Nov 2013 15:46:51 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix overwriting hwmod data with data fr=
om device tree
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> We have some device tree properties where the ti,hwmod have multiple
> values:
>=20
> am33xx.dtsi:	ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
> am4372.dtsi:	ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
> dra7.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2";
> omap3.dtsi:	ti,hwmods =3D "mcbsp2", "mcbsp2_sidetone";
> omap3.dtsi:	ti,hwmods =3D "mcbsp3", "mcbsp3_sidetone";
> omap4.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2", "l3_main_3";
> omap5.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2", "l3_main_3";
>=20
> That's not correct way of doing things in this case because these are
> separate devices with their own address space, interrupts, SYSCONFIG
> registers and can set their PM states independently.
>=20
> So they should all be fixed up to be separate devices in the .dts fil=
es.
>=20
> We also have the related data removed for at least omap4 in commit
> 3b9b10151c68 (ARM: OMAP4: hwmod data: Clean up the data file), so
> that data is wrongly initialized as null data.
>=20
> So we need to fix two bugs:
>=20
> 1. We are only checking the first entry of the ti,hwmods property
>=20
>    This means that we're only initializing the first hwmods entry
>    instead of the ones listed in the ti,hwmods property.
>=20
> 2. We are only checking the child nodes, not the nodes themselves
>=20
>    This means that anything listed at OCP level is currently just
>    ignored and unitialized and at least the omap4 case, with the
>    legacy data missing from the hwmod.
>=20
> Fix both of the issues by using an index to the ti,hwmods property
> and changing the hwmod lookup function to also check the current node
> for ti,hwmods property instead of just the children.
>=20
> While at it, let's also add some warnings for the bad data so it's
> easier to fix.
>=20
> Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index e3f0eca..ee655da 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2326,38 +2326,80 @@ static int _shutdown(struct omap_hwmod *oh)
>  	return 0;
>  }
> =20
> +static int of_dev_find_hwmod(struct device_node *np,
> +			     struct omap_hwmod *oh)
> +{
> +	int count, i, res;
> +	const char *p;
> +
> +	count =3D of_property_count_strings(np, "ti,hwmods");
> +	if (count < 1)
> +		return -ENODEV;
> +
> +	for (i =3D 0; i < count; i++) {
> +		res =3D of_property_read_string_index(np, "ti,hwmods",
> +						    i, &p);
> +		if (res)
> +			continue;
> +		if (!strcmp(p, oh->name)) {
> +			pr_debug("omap_hwmod: dt %s[%i] uses hwmod %s\n",
> +				 np->name, i, oh->name);
> +			return i;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  /**
>   * of_dev_hwmod_lookup - look up needed hwmod from dt blob
>   * @np: struct device_node *
>   * @oh: struct omap_hwmod *
> + * @index: index of the entry found
> + * @found: struct device_node * found or NULL
>   *
>   * Parse the dt blob and find out needed hwmod. Recursive function i=
s
>   * implemented to take care hierarchical dt blob parsing.
> - * Return: The device node on success or NULL on failure.
> + * Return: Returns 0 on success, -ENODEV when not found.
>   */
> -static struct device_node *of_dev_hwmod_lookup(struct device_node *n=
p,
> -						struct omap_hwmod *oh)
> +static int of_dev_hwmod_lookup(struct device_node *np,
> +			       struct omap_hwmod *oh,
> +			       int *index,
> +			       struct device_node **found)
>  {
> -	struct device_node *np0 =3D NULL, *np1 =3D NULL;
> -	const char *p;
> +	struct device_node *np0 =3D NULL;
> +	int res;
> +
> +	res =3D of_dev_find_hwmod(np, oh);
> +	if (res >=3D 0) {
> +		*found =3D np;
> +		*index =3D res;
> +		return 0;
> +	}
> =20
>  	for_each_child_of_node(np, np0) {
> -		if (of_find_property(np0, "ti,hwmods", NULL)) {
> -			p =3D of_get_property(np0, "ti,hwmods", NULL);
> -			if (!strcmp(p, oh->name))
> -				return np0;
> -			np1 =3D of_dev_hwmod_lookup(np0, oh);
> -			if (np1)
> -				return np1;
> +		struct device_node *fc;
> +		int i;
> +
> +		res =3D of_dev_hwmod_lookup(np0, oh, &i, &fc);
> +		if (res =3D=3D 0) {
> +			*found =3D fc;
> +			*index =3D i;
> +			return 0;
>  		}
>  	}
> -	return NULL;
> +
> +	*found =3D NULL;
> +	*index =3D 0;
> +
> +	return -ENODEV;
>  }
> =20
>  /**
>   * _init_mpu_rt_base - populate the virtual address for a hwmod
>   * @oh: struct omap_hwmod * to locate the virtual address
>   * @data: (unused, caller should pass NULL)
> + * @index: index of the reg entry iospace in device tree
>   * @np: struct device_node * of the IP block's device node in the DT=
 data
>   *
>   * Cache the virtual address used by the MPU to access this IP block=
's
> @@ -2368,7 +2410,7 @@ static struct device_node *of_dev_hwmod_lookup(=
struct device_node *np,
>   * -ENXIO on absent or invalid register target address space.
>   */
>  static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *dat=
a,
> -				    struct device_node *np)
> +				    int index, struct device_node *np)
>  {
>  	struct omap_hwmod_addr_space *mem;
>  	void __iomem *va_start =3D NULL;
> @@ -2390,13 +2432,17 @@ static int __init _init_mpu_rt_base(struct om=
ap_hwmod *oh, void *data,
>  		if (!np)
>  			return -ENXIO;
> =20
> -		va_start =3D of_iomap(np, oh->mpu_rt_idx);
> +		va_start =3D of_iomap(np, index + oh->mpu_rt_idx);
>  	} else {
>  		va_start =3D ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
>  	}
> =20
>  	if (!va_start) {
> -		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
> +		if (mem)
> +			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
> +		else
> +			pr_err("omap_hwmod: %s: Missing dt reg%i for %s\n",
> +			       oh->name, index, np->full_name);
>  		return -ENXIO;
>  	}
> =20
> @@ -2422,17 +2468,29 @@ static int __init _init_mpu_rt_base(struct om=
ap_hwmod *oh, void *data,
>   */
>  static int __init _init(struct omap_hwmod *oh, void *data)
>  {
> -	int r;
> +	int r, index;
>  	struct device_node *np =3D NULL;
> =20
>  	if (oh->_state !=3D _HWMOD_STATE_REGISTERED)
>  		return 0;
> =20
> -	if (of_have_populated_dt())
> -		np =3D of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
> +	if (of_have_populated_dt()) {
> +		struct device_node *bus;
> +
> +		bus =3D of_find_node_by_name(NULL, "ocp");
> +		if (!bus)
> +			return -ENODEV;
> +
> +		r =3D of_dev_hwmod_lookup(bus, oh, &index, &np);
> +		if (r)
> +			pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
> +		else if (np && index)
> +			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> +				oh->name, np->name);
> +	}
> =20
>  	if (oh->class->sysc) {
> -		r =3D _init_mpu_rt_base(oh, NULL, np);
> +		r =3D _init_mpu_rt_base(oh, NULL, index, np);
>  		if (r < 0) {
>  			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n"=
,
>  			     oh->name);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
