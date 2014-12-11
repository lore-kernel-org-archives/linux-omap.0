From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Thu, 11 Dec 2014 01:52:38 +0100
Message-ID: <20141211005238.GC5585@earth.universe>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
 <20141210145433.GC4602@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50918 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822AbaLKAxD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2014 19:53:03 -0500
Content-Disposition: inline
In-Reply-To: <20141210145433.GC4602@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 08:54:33AM -0600, Felipe Balbi wrote:
> Hi,
>=20
> (adding linux-omap back to the loop)
>=20
> On Wed, Dec 10, 2014 at 04:20:30PM +0530, Lokesh Vutla wrote:
> > Hi Felipe,
> >=20
> > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > Before this patch, HWMOD requires the existence
> > > of a struct omap_hwmod_class very early.
> > Yes, hwmod code looks for omap_hwmod_class entry before registering any=
 hwmod.
> >=20
> > With the patch 4/7 omap_hwmod_class gets populated from dt very late af=
ter registration of the hwmod.
> > So all the hwmod which gets class data from dt never gets registered an=
d state is always UNKNOWN.
> > Mostly making it unusable.
> > IMO this patch just masks the problem.
> >=20
> > In order to register hwmod we need to populate class data very early.
> > We can populate at the same place as how reg property is being parsed.
> > Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
> > The below diff will help:
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
> > index cbb908d..05ecf8a 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct omap=
_hwmod *oh, void *data,
> >  	return 0;
> >  }
> > =20
> > +static int omap_hwmod_has_sysc_bindings(struct device_node *node)
> > +{
> > +	char *properties[] =3D {
> > +		"ti,rev_offs",
> > +		"ti,sysc_offs",
> > +		"ti,syss_offs",
> > +		"ti,sysc_flags",
> > +		"ti,srst_udelay",
> > +		"ti,idlemodes",
> > +		"ti,clockact",
> > +		"ti,sysc_type",
> > +		NULL
> > +	};
> > +	char **tmp =3D properties;
> > +
> > +	while (*tmp) {
> > +		if (of_property_read_bool(node, *tmp)) {
> > +			return true;
> > +		}
> > +		tmp++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_hwmod_init_sysc(struct device_node *node,
> > +		struct omap_hwmod *oh, int index)
> > +{
> > +	struct omap_hwmod_class *class =3D oh->class;
> > +	struct omap_hwmod_class_sysconfig *sysc;
> > +	int ret;
> > +	int i;
> > +	char name[128];
> > +	const char *tmp =3D oh->name;
> > +	u32 prop;
> > +
> > +	/* if data isn't provided by DT, skip */
> > +	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
> > +		return 0;
> > +
> > +	class =3D kzalloc(sizeof(*class), GFP_KERNEL);
> > +	if (!class)
> > +		return -ENOMEM;
> > +
> > +	i =3D 0;
> > +	while (*tmp) {
> > +		if (isalpha(*tmp))
> > +			name[i++] =3D *tmp;
> > +		tmp++;
> > +	}
> > +	name[i] =3D '\0';
> > +
> > +	class->name =3D kzalloc(sizeof(name), GFP_KERNEL);
> > +	if (!class->name)
> > +		return -ENOMEM;
> > +	strncpy(class->name, name, sizeof(name) - 1);
> > +
> > +	sysc =3D kzalloc(sizeof(*sysc), GFP_KERNEL);
> > +	if (!sysc)
> > +		return -ENOMEM;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,rev_offs", index, &prop);
> > +	if (!ret)
> > +		sysc->rev_offs =3D prop;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,sysc_offs", index, &prop=
);
> > +	if (!ret)
> > +		sysc->sysc_offs =3D prop;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,syss_offs", index, &prop=
);
> > +	if (!ret)
> > +		sysc->syss_offs =3D prop;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,sysc_flags", index, &pro=
p);
> > +	if (!ret)
> > +		sysc->sysc_flags =3D prop & 0xffff;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,srst_udelay", index, &pr=
op);
> > +	if (!ret)
> > +		sysc->srst_udelay =3D prop & 0xff;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,idlemodes", index, &prop=
);
> > +	if (!ret)
> > +		sysc->idlemodes =3D prop & 0xff;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,clockact", index, &prop);
> > +	if (!ret)
> > +		sysc->clockact =3D prop & 0xff;
> > +
> > +	ret =3D of_property_read_u32_index(node, "ti,sysc_type", index, &prop=
);
> > +	if (ret)
> > +		prop =3D 1;
> > +
> > +	switch (prop) {
> > +	case 2:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type2;
> > +		break;
> > +	case 3:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type3;
> > +		break;
> > +	case 1:
> > +	default:
> > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type1;
> > +	}
> > +	class->sysc =3D sysc;
> > +	oh->class =3D class;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * _init - initialize internal data for the hwmod @oh
> >   * @oh: struct omap_hwmod *
> > @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh, v=
oid *data)
> >  		else if (np && index)
> >  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> >  				oh->name, np->name);
> > +
> > +		if (np) {
> > +			r =3D omap_hwmod_init_sysc(np, oh, 0);
>=20
> this won't handle any binding which lists more than one hwmod on its
> ti,hwmods property.

I think Tony planned to remove this kind of multi hwmod references.

IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
hwmod database should reference the compatible values. This depends
on omap3 being DT only of course.

-- Sebastian

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUiOrVAAoJENju1/PIO/qaD5QP/A+JHsWm3SoC3OJSfX+Nxe7b
CiHzRP0du6xNr70LCmj8gIKKy/4/NtnNPaXzKjuphRj5ovb/ChY0aRwhgZVlVAAB
S/zRjvudKntaIIBJJBMZ+fH1Jt3Im3+T4UG8R8vtTZzKkqusH6KZaYm78Qd21ZJb
ls7ybgcGYtVrVb9qfXNKn7+OYptxZIHVnSBBIodjCrK457JrYj6mzyN6OZF1h2Jk
2xQbGFNG5w4QV6xeTCNnrbOk+ENUszBz1z3SKSztDYNmIg4doa2btzdpAT44Tq8d
/PBXXt75W6JCrskytrzyn8PdIK1AO+OL1+sqdZ0ccoBvkDHjo7uxSpG7pQ3DG6zG
7tSPcZPeMlhf+ttk0pikplPeCjJys/nZ8E3KMEiMlE/RivBBVqXpFnuDirvw7QTX
Fi6Gx7fGnuzpw8KMbBsg1Bp7yOUDSl7vb+ptjinjK7LuL7aQ2+Z90qsWjR1QBK1S
wwBeNprPH8+amUS3Av7qdb+3/Qcmd8yt5wyzkz09JnjM1GhXliio0itGNojq4SpV
8LIpTj/ynUj33qfiB1K6+gqo53xljAqm3dttqG5O87C7HhF1idme5ocMtxRYlKZ9
CGNG9IQP64EQNjG2OLTZ+KnVryQsQAwBPam3XG4FItyk3Z+mzzaV0gW3nT/LroDy
wi3rA35khIAGKcp9PU8a
=61lD
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
