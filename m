From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Thu, 11 Dec 2014 18:44:35 +0100
Message-ID: <20141211174434.GA2022@earth.universe>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
 <20141210145433.GC4602@saruman>
 <20141211005238.GC5585@earth.universe>
 <20141211142333.GE20762@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59713 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758493AbaLKRok (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2014 12:44:40 -0500
Content-Disposition: inline
In-Reply-To: <20141211142333.GE20762@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 08:23:33AM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Dec 11, 2014 at 01:52:38AM +0100, Sebastian Reichel wrote:
> > On Wed, Dec 10, 2014 at 08:54:33AM -0600, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > (adding linux-omap back to the loop)
> > >=20
> > > On Wed, Dec 10, 2014 at 04:20:30PM +0530, Lokesh Vutla wrote:
> > > > Hi Felipe,
> > > >=20
> > > > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > > > Before this patch, HWMOD requires the existence
> > > > > of a struct omap_hwmod_class very early.
> > > > Yes, hwmod code looks for omap_hwmod_class entry before registering=
 any hwmod.
> > > >=20
> > > > With the patch 4/7 omap_hwmod_class gets populated from dt very lat=
e after registration of the hwmod.
> > > > So all the hwmod which gets class data from dt never gets registere=
d and state is always UNKNOWN.
> > > > Mostly making it unusable.
> > > > IMO this patch just masks the problem.
> > > >=20
> > > > In order to register hwmod we need to populate class data very earl=
y.
> > > > We can populate at the same place as how reg property is being pars=
ed.
> > > > Call omap_hwmod_init_sysc() in _init() of the particular hwmod:
> > > > The below diff will help:
> > > >
> > > > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2=
/omap_hwmod.c
> > > > index cbb908d..05ecf8a 100644
> > > > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > > > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > > > @@ -2415,6 +2415,116 @@ static int __init _init_mpu_rt_base(struct =
omap_hwmod *oh, void *data,
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > +static int omap_hwmod_has_sysc_bindings(struct device_node *node)
> > > > +{
> > > > +	char *properties[] =3D {
> > > > +		"ti,rev_offs",
> > > > +		"ti,sysc_offs",
> > > > +		"ti,syss_offs",
> > > > +		"ti,sysc_flags",
> > > > +		"ti,srst_udelay",
> > > > +		"ti,idlemodes",
> > > > +		"ti,clockact",
> > > > +		"ti,sysc_type",
> > > > +		NULL
> > > > +	};
> > > > +	char **tmp =3D properties;
> > > > +
> > > > +	while (*tmp) {
> > > > +		if (of_property_read_bool(node, *tmp)) {
> > > > +			return true;
> > > > +		}
> > > > +		tmp++;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int omap_hwmod_init_sysc(struct device_node *node,
> > > > +		struct omap_hwmod *oh, int index)
> > > > +{
> > > > +	struct omap_hwmod_class *class =3D oh->class;
> > > > +	struct omap_hwmod_class_sysconfig *sysc;
> > > > +	int ret;
> > > > +	int i;
> > > > +	char name[128];
> > > > +	const char *tmp =3D oh->name;
> > > > +	u32 prop;
> > > > +
> > > > +	/* if data isn't provided by DT, skip */
> > > > +	if ((class && class->sysc) || !omap_hwmod_has_sysc_bindings(node))
> > > > +		return 0;
> > > > +
> > > > +	class =3D kzalloc(sizeof(*class), GFP_KERNEL);
> > > > +	if (!class)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	i =3D 0;
> > > > +	while (*tmp) {
> > > > +		if (isalpha(*tmp))
> > > > +			name[i++] =3D *tmp;
> > > > +		tmp++;
> > > > +	}
> > > > +	name[i] =3D '\0';
> > > > +
> > > > +	class->name =3D kzalloc(sizeof(name), GFP_KERNEL);
> > > > +	if (!class->name)
> > > > +		return -ENOMEM;
> > > > +	strncpy(class->name, name, sizeof(name) - 1);
> > > > +
> > > > +	sysc =3D kzalloc(sizeof(*sysc), GFP_KERNEL);
> > > > +	if (!sysc)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,rev_offs", index, &p=
rop);
> > > > +	if (!ret)
> > > > +		sysc->rev_offs =3D prop;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_offs", index, &=
prop);
> > > > +	if (!ret)
> > > > +		sysc->sysc_offs =3D prop;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,syss_offs", index, &=
prop);
> > > > +	if (!ret)
> > > > +		sysc->syss_offs =3D prop;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_flags", index, =
&prop);
> > > > +	if (!ret)
> > > > +		sysc->sysc_flags =3D prop & 0xffff;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,srst_udelay", index,=
 &prop);
> > > > +	if (!ret)
> > > > +		sysc->srst_udelay =3D prop & 0xff;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,idlemodes", index, &=
prop);
> > > > +	if (!ret)
> > > > +		sysc->idlemodes =3D prop & 0xff;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,clockact", index, &p=
rop);
> > > > +	if (!ret)
> > > > +		sysc->clockact =3D prop & 0xff;
> > > > +
> > > > +	ret =3D of_property_read_u32_index(node, "ti,sysc_type", index, &=
prop);
> > > > +	if (ret)
> > > > +		prop =3D 1;
> > > > +
> > > > +	switch (prop) {
> > > > +	case 2:
> > > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type2;
> > > > +		break;
> > > > +	case 3:
> > > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type3;
> > > > +		break;
> > > > +	case 1:
> > > > +	default:
> > > > +		sysc->sysc_fields =3D &omap_hwmod_sysc_type1;
> > > > +	}
> > > > +	class->sysc =3D sysc;
> > > > +	oh->class =3D class;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * _init - initialize internal data for the hwmod @oh
> > > >   * @oh: struct omap_hwmod *
> > > > @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *o=
h, void *data)
> > > >  		else if (np && index)
> > > >  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> > > >  				oh->name, np->name);
> > > > +
> > > > +		if (np) {
> > > > +			r =3D omap_hwmod_init_sysc(np, oh, 0);
> > >=20
> > > this won't handle any binding which lists more than one hwmod on its
> > > ti,hwmods property.
> >=20
> > I think Tony planned to remove this kind of multi hwmod references.
>=20
> true, but I'm still a bit iffy wrt that. ABI compatibility breaks and
> all

Moving the hwmod data to device tree will break the ABI
compatibility anyways. You wont be able to use an old DT with the
new kernel, since then you are missing the hwmod data (assuming
there won't be a fallback hwmod data kept in the kernel source).

> > IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
> > hwmod database should reference the compatible values. This depends
> > on omap3 being DT only of course.
>=20
> don't you think it's too late for that ? We need to support the current
> form of dts files forever. It's an ABI afterall.

As I described above the ABI *will* break if hwmod data is removed from
the kernel.

OTOH where is the ABI breakage when hwmod database in kernel is
built from the compatible value? The compatible values are already
part of the ABI, so there are no new properties needed. The ti,hwmod
property can be marked as deprecated (and maybe removed after some
years).

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUidf/AAoJENju1/PIO/qavkAP/RxKhIBBXHM7VSWwEQQPTY8G
c/iX5dhgRFS/leEsuaokcjBhUoC3DiQ21JKyTglh1/jxJlJAAmpoFww1KiyfHc/L
Olmtf78QKyIaVNJNQckdNO5OvUZ5llQQt9A46hLeU91BX9pQRDzxZdzaFe5OG/Rr
RR1LjzEfgIzDEFMsOk50/r6JkJaeynhhHmfX3vnArOwg+1+uosihbpftAGex1WsU
BfNlly99s5K7Xwvu979G28gyW9L9/ruvaDNvHTCDcobpwf0P0YNUBjPOiKVIDVj3
YdmMp7rVumoArfDBjY9Bf+lOnqQvoUGji4VtdTGT7Vm4hwKGKnYsCNUqrgjMPHIF
BqAGLbVetIaCwoWop5Z6MUIb0qFu3d0HG1ArxibgXudxpObjiqlcYRS/TF8pOqa2
Ai51aL+YbNz4KhG3e4G8W4jc7xfASxCer28BU+UiS2MCH8/Ihes6Ws6zfzPoTTGZ
640WWF1xt3qodMppBRUj5cL9cfY5c8kRwjwUoLLl1ai1I37KjfwTF1YtwjcwT9Lc
4AM7DYyP2csSPH79syfVowutWB1jMq0Y68tfDqVPFOxnq8hXroOQDpollWqAICvR
6TCtj5KY3MfVfVPC6+xvKCIWdIRLSJUwxpxjimiDqhktMRUazanhsP/a+n39fxNX
t4syaDdvCjbqihD7Q4D9
=rYKK
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
