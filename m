From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Thu, 11 Dec 2014 08:23:33 -0600
Message-ID: <20141211142333.GE20762@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
 <20141210145433.GC4602@saruman>
 <20141211005238.GC5585@earth.universe>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932612AbaLKOYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2014 09:24:08 -0500
Content-Disposition: inline
In-Reply-To: <20141211005238.GC5585@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 11, 2014 at 01:52:38AM +0100, Sebastian Reichel wrote:
> On Wed, Dec 10, 2014 at 08:54:33AM -0600, Felipe Balbi wrote:
> > Hi,
> >=20
> > (adding linux-omap back to the loop)
> >=20
> > On Wed, Dec 10, 2014 at 04:20:30PM +0530, Lokesh Vutla wrote:
> > > Hi Felipe,
> > >=20
> > > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > > Before this patch, HWMOD requires the existence
> > > > of a struct omap_hwmod_class very early.
> > > Yes, hwmod code looks for omap_hwmod_class entry before registering a=
ny hwmod.
> > >=20
> > > With the patch 4/7 omap_hwmod_class gets populated from dt very late =
after registration of the hwmod.
> > > So all the hwmod which gets class data from dt never gets registered =
and state is always UNKNOWN.
> > > Mostly making it unusable.
> > > IMO this patch just masks the problem.
> > >=20
> > > In order to register hwmod we need to populate class data very early.
> > > We can populate at the same place as how reg property is being parsed.
> > > Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
> > > The below diff will help:
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> > > index cbb908d..05ecf8a 100644
> > > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > > @@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct om=
ap_hwmod *oh, void *data,
> > >  	return 0;
> > >  }
> > > =20
> > > +static int omap_hwmod_has_sysc_bindings(struct device_node *node)
> > > +{
> > > +	char *properties[] =3D {
> > > +		"ti,rev_offs",
> > > +		"ti,sysc_offs",
> > > +		"ti,syss_offs",
> > > +		"ti,sysc_flags",
> > > +		"ti,srst_udelay",
> > > +		"ti,idlemodes",
> > > +		"ti,clockact",
> > > +		"ti,sysc_type",
> > > +		NULL
> > > +	};
> > > +	char **tmp =3D properties;
> > > +
> > > +	while (*tmp) {
> > > +		if (of_property_read_bool(node, *tmp)) {
> > > +			return true;
> > > +		}
> > > +		tmp++;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int omap_hwmod_init_sysc(struct device_node *node,
> > > +		struct omap_hwmod *oh, int index)
> > > +{
> > > +	struct omap_hwmod_class *class =3D oh->class;
> > > +	struct omap_hwmod_class_sysconfig *sysc;
> > > +	int ret;
> > > +	int i;
> > > +	char name[128];
> > > +	const char *tmp =3D oh->name;
> > > +	u32 prop;
> > > +
> > > +	/* if data isn't provided by DT, skip */
> > > +	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
> > > +		return 0;
> > > +
> > > +	class =3D kzalloc(sizeof(*class), GFP_KERNEL);
> > > +	if (!class)
> > > +		return -ENOMEM;
> > > +
> > > +	i =3D 0;
> > > +	while (*tmp) {
> > > +		if (isalpha(*tmp))
> > > +			name[i++] =3D *tmp;
> > > +		tmp++;
> > > +	}
> > > +	name[i] =3D '\0';
> > > +
> > > +	class->name =3D kzalloc(sizeof(name), GFP_KERNEL);
> > > +	if (!class->name)
> > > +		return -ENOMEM;
> > > +	strncpy(class->name, name, sizeof(name) - 1);
> > > +
> > > +	sysc =3D kzalloc(sizeof(*sysc), GFP_KERNEL);
> > > +	if (!sysc)
> > > +		return -ENOMEM;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,rev_offs", index, &pro=
p);
> > > +	if (!ret)
> > > +		sysc->rev_offs =3D prop;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_offs", index, &pr=
op);
> > > +	if (!ret)
> > > +		sysc->sysc_offs =3D prop;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,syss_offs", index, &pr=
op);
> > > +	if (!ret)
> > > +		sysc->syss_offs =3D prop;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_flags", index, &p=
rop);
> > > +	if (!ret)
> > > +		sysc->sysc_flags =3D prop & 0xffff;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,srst_udelay", index, &=
prop);
> > > +	if (!ret)
> > > +		sysc->srst_udelay =3D prop & 0xff;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,idlemodes", index, &pr=
op);
> > > +	if (!ret)
> > > +		sysc->idlemodes =3D prop & 0xff;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,clockact", index, &pro=
p);
> > > +	if (!ret)
> > > +		sysc->clockact =3D prop & 0xff;
> > > +
> > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_type", index, &pr=
op);
> > > +	if (ret)
> > > +		prop =3D 1;
> > > +
> > > +	switch (prop) {
> > > +	case 2:
> > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type2;
> > > +		break;
> > > +	case 3:
> > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type3;
> > > +		break;
> > > +	case 1:
> > > +	default:
> > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type1;
> > > +	}
> > > +	class->sysc =3D sysc;
> > > +	oh->class =3D class;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * _init - initialize internal data for the hwmod @oh
> > >   * @oh: struct omap_hwmod *
> > > @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh,=
 void *data)
> > >  		else if (np && index)
> > >  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> > >  				oh->name, np->name);
> > > +
> > > +		if (np) {
> > > +			r =3D omap_hwmod_init_sysc(np, oh, 0);
> >=20
> > this won't handle any binding which lists more than one hwmod on its
> > ti,hwmods property.
>=20
> I think Tony planned to remove this kind of multi hwmod references.

true, but I'm still a bit iffy wrt that. ABI compatibility breaks and
all

> IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
> hwmod database should reference the compatible values. This depends
> on omap3 being DT only of course.

don't you think it's too late for that ? We need to support the current
form of dts files forever. It's an ABI afterall.

--=20
balbi

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiajlAAoJEIaOsuA1yqRERvcP/2MXFvE0zSWQig4OZZ8DnPSu
viaAJlgcpvjSAbGzpbsYLHuoiJYeRpMDZ2tf2W9G6AmXVqhpgXOPf4EPYgAifhDN
wXRvH+hPVMAOfwjcWo1gs2DrVcUWF36jD1KagoYNQtMJRlm4UMQxHyiFNDLgVJ33
s8c7kBwsD62Q+joZFKld4PYGcan/AM+bA0sx9uLJI7WnxFrUCXx88VZ0GmStT14m
yFZ8VyWIyn1uoxS4GudIwlsnLwo3E6bAB1cre6P+0zZkD7rQ/fjSS/JKuLujrf1n
Bg8s2TVbm4E5vAiSgn+Wv4NqdxwU+UDQQp+8dfq5xrfpGksmLMnx4iVnbV1g724M
iNgVOUlZ6hqL8xRsEZP4l6xCVDlmYkz3Zp0wn336zGKn7tku0uQCMQDkmghPSGoR
JfWWx/Ruojq3+EFrqpXkUsFAZcF2uuwq/SZyiD6nz+ZVw5abSMoKaJzhjIrkPwAX
VjnP/JV/KZzr37XhLtGTzYW/E6ysJ+Fox1n8R4ee1bIB31bb93Ik8/NFwpcVGNcT
u6bH0EROnPqGSwEXJUsECMn/H2KeaO+wZZXv4nGt7qM2F1CTZoLqmeG9rjOnTXrZ
rnkj6MImdTzMlfafZLwtVmDgvQtIPFuvhmWKpw3PAiACHQ7bHFXR6G5lep954KNK
ILLZ47WLX5pwqRy0gli6
=2qN7
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
