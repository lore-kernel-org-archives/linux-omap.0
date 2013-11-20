From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
Date: Wed, 20 Nov 2013 10:12:56 -0800
Message-ID: <20131120181255.GG10317@atomide.com>
References: <20131120025620.GF10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55992 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751940Ab3KTSM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:12:59 -0500
Content-Disposition: inline
In-Reply-To: <20131120025620.GF10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [131119 18:57]:
> We have some device tree properties where the ti,hwmod has multiple
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
> So we need to handle the whole string array instead of just the
> first string to find the related hwmod entry.
>=20
> Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2228,11 +2228,23 @@ static struct device_node *of_dev_hwmod_looku=
p(struct device_node *np,
>  						struct omap_hwmod *oh)
>  {
>  	struct device_node *np0 =3D NULL, *np1 =3D NULL;
> -	const char *p;
> =20
>  	for_each_child_of_node(np, np0) {
> -		if (of_find_property(np0, "ti,hwmods", NULL)) {
> -			p =3D of_get_property(np0, "ti,hwmods", NULL);
> +		int count, i;
> +
> +		count =3D of_property_count_strings(np0, "ti,hwmods");
> +		if (count < 1)
> +			continue;
> +
> +		for (i =3D 0; i < count; i++) {
> +			const char *p;
> +			int res;
> +
> +			res =3D of_property_read_string_index(np0, "ti,hwmods",
> +							    i, &p);
> +			if (res)
> +				continue;
> +
>  			if (!strcmp(p, oh->name))
>  				return np0;
>  			np1 =3D of_dev_hwmod_lookup(np0, oh);

Hmm I think this also needs part two to it to populate the right IO spa=
ce
based on the index, this probably now wrongly populates the first IO sp=
ace
for all the hwmod instances in the group.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
