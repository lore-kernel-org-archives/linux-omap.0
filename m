From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Wed, 10 Dec 2014 08:54:33 -0600
Message-ID: <20141210145433.GC4602@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60037 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbaLJOzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 09:55:19 -0500
Content-Disposition: inline
In-Reply-To: <54882576.8020609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(adding linux-omap back to the loop)

On Wed, Dec 10, 2014 at 04:20:30PM +0530, Lokesh Vutla wrote:
> Hi Felipe,
>=20
> On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > Before this patch, HWMOD requires the existence
> > of a struct omap_hwmod_class very early.
> Yes, hwmod code looks for omap_hwmod_class entry before registering any h=
wmod.
>=20
> With the patch 4/7 omap_hwmod_class gets populated from dt very late afte=
r registration of the hwmod.
> So all the hwmod which gets class data from dt never gets registered and =
state is always UNKNOWN.
> Mostly making it unusable.
> IMO this patch just masks the problem.
>=20
> In order to register hwmod we need to populate class data very early.
> We can populate at the same place as how reg property is being parsed.
> Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
> The below diff will help:
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_=
hwmod.c
> index cbb908d..05ecf8a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct omap_h=
wmod *oh, void *data,
>  	return 0;
>  }
> =20
> +static int omap_hwmod_has_sysc_bindings(struct device_node *node)
> +{
> +	char *properties[] =3D {
> +		"ti,rev_offs",
> +		"ti,sysc_offs",
> +		"ti,syss_offs",
> +		"ti,sysc_flags",
> +		"ti,srst_udelay",
> +		"ti,idlemodes",
> +		"ti,clockact",
> +		"ti,sysc_type",
> +		NULL
> +	};
> +	char **tmp =3D properties;
> +
> +	while (*tmp) {
> +		if (of_property_read_bool(node, *tmp)) {
> +			return true;
> +		}
> +		tmp++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_hwmod_init_sysc(struct device_node *node,
> +		struct omap_hwmod *oh, int index)
> +{
> +	struct omap_hwmod_class *class =3D oh->class;
> +	struct omap_hwmod_class_sysconfig *sysc;
> +	int ret;
> +	int i;
> +	char name[128];
> +	const char *tmp =3D oh->name;
> +	u32 prop;
> +
> +	/* if data isn't provided by DT, skip */
> +	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
> +		return 0;
> +
> +	class =3D kzalloc(sizeof(*class), GFP_KERNEL);
> +	if (!class)
> +		return -ENOMEM;
> +
> +	i =3D 0;
> +	while (*tmp) {
> +		if (isalpha(*tmp))
> +			name[i++] =3D *tmp;
> +		tmp++;
> +	}
> +	name[i] =3D '\0';
> +
> +	class->name =3D kzalloc(sizeof(name), GFP_KERNEL);
> +	if (!class->name)
> +		return -ENOMEM;
> +	strncpy(class->name, name, sizeof(name) - 1);
> +
> +	sysc =3D kzalloc(sizeof(*sysc), GFP_KERNEL);
> +	if (!sysc)
> +		return -ENOMEM;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,rev_offs", index, &prop);
> +	if (!ret)
> +		sysc->rev_offs =3D prop;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,sysc_offs", index, &prop);
> +	if (!ret)
> +		sysc->sysc_offs =3D prop;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,syss_offs", index, &prop);
> +	if (!ret)
> +		sysc->syss_offs =3D prop;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,sysc_flags", index, &prop);
> +	if (!ret)
> +		sysc->sysc_flags =3D prop & 0xffff;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,srst_udelay", index, &prop=
);
> +	if (!ret)
> +		sysc->srst_udelay =3D prop & 0xff;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,idlemodes", index, &prop);
> +	if (!ret)
> +		sysc->idlemodes =3D prop & 0xff;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,clockact", index, &prop);
> +	if (!ret)
> +		sysc->clockact =3D prop & 0xff;
> +
> +	ret =3D of_property_read_u32_index(node, "ti,sysc_type", index, &prop);
> +	if (ret)
> +		prop =3D 1;
> +
> +	switch (prop) {
> +	case 2:
> +		sysc->sysc_fields =3D &omap_hwmod_sysc_type2;
> +		break;
> +	case 3:
> +		sysc->sysc_fields =3D &omap_hwmod_sysc_type3;
> +		break;
> +	case 1:
> +	default:
> +		sysc->sysc_fields =3D &omap_hwmod_sysc_type1;
> +	}
> +	class->sysc =3D sysc;
> +	oh->class =3D class;
> +
> +	return 0;
> +}
> +
>  /**
>   * _init - initialize internal data for the hwmod @oh
>   * @oh: struct omap_hwmod *
> @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh, voi=
d *data)
>  		else if (np && index)
>  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
>  				oh->name, np->name);
> +
> +		if (np) {
> +			r =3D omap_hwmod_init_sysc(np, oh, 0);

this won't handle any binding which lists more than one hwmod on its
ti,hwmods property.

--=20
balbi

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiF6pAAoJEIaOsuA1yqREtCcQALHoy764/HTldYDN6pPII7G8
2FQPdqAaAUmsQm+NhvmH3rWCDebGOuYkFPS/9QEfZ9s5NpRsv83N9JfkA/5RImBe
oF+64rMqBbMeJdheToVDh4tDFJ+zX9ecG/QgEliry9i3F6rtaBD1DCar/n6uCYbj
AkLB0D/jrBt7yxhCT65t2x5vYKG+5+MIKX15EDm/2lN83Pb8YxMA0N7flri66qO2
FnJhLjG+GV9ILPIb1dBx03E/0iB+18A5UF72On7fOzpByFEabj92l5lMVDm2qt/S
7zk0qWHwt+qH8xZte60XOCgMYVd1h3epb/yd62RwjaFIb6jY4IF/s4u2225U5JpP
FpMuAa0hNPDQ+I5gfG0SuSMbuDjsj8oI7O9vlIB8pZJuLO+vJ8exx2eyQmk7mD9g
48tm0vHeJIPO891v9L8wKBvnftIGORW3XY69wPJ+h9U0lY+z4sF2/vvpKnwjFNoU
51e/RdwEOA0Glt8Gp4Hmvju1gvsjEcAwoTXfjvi5QhpFl0k/ammbVsq8cWbwtfxw
WrQh3BsvpIZHAPcgogoOQmUzCHP5QNiykH2ROqz0J412PnDxEs2PL8Tl/VeABHLz
Bcx3gFg2xbZKJ2jj0hRHfFIxESf1GUBZ+tJ2UaamGRd+v4GXBNijR1TQ53Yhh4Mc
O7WZPN+qQajljzBy02BF
=96gb
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
