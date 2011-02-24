From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Thu, 24 Feb 2011 18:50:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE497E3@dbde02.ent.ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com>
 <AANLkTim3X-k-0HV2wLjSSAmKHQ1kLCYW777s52TyirDU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43277 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab1BXNUT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 08:20:19 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ODKFqW029800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:20:18 -0600
In-Reply-To: <AANLkTim3X-k-0HV2wLjSSAmKHQ1kLCYW777s52TyirDU@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, February 24, 2011 12:14 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>=20
> On Wed, Feb 23, 2011 at 23:28, Sanjeev Premi <premi@ti.com> wrote:
> > Add glue logic to hook-up AM35x processors
> > with TPS65023.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>=20
> [...]
> > +/**
> > + * TBD: Just a copy of OMAP3 PMIC info.
> > + * =A0 =A0 =A0Many fields below don't make much sense for AM3517,
> > + * =A0 =A0 =A0but keeping them as is for now.
> > + */
> > +static struct omap_volt_pmic_info am3517_volt_info =3D {
> > + =A0 =A0 =A0 .slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> > + =A0 =A0 =A0 .step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 25000,
> > + =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> > + =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> > + =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> > + =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> > + =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
> > + =A0 =A0 =A0 .vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_E=
RROROFFSET,
> > + =A0 =A0 =A0 .vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTE=
PMIN_VSTEPMIN,
> > + =A0 =A0 =A0 .vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTE=
PMAX_VSTEPMAX,
> > + =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP=
2_VLIMITTO_VDDMIN,
> > + =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP=
2_VLIMITTO_VDDMAX,
> > + =A0 =A0 =A0 .vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMIT=
TO_TIMEOUT_US,
> > + =A0 =A0 =A0 .i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE=
_ADDR,
> > + =A0 =A0 =A0 .pmic_reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_VDD_C=
ORE_SR_CONTROL_REG,
> > + =A0 =A0 =A0 .vsel_to_uv =A0 =A0 =A0 =A0 =A0 =A0 =3D tps65023_vsel=
_to_uv,
> > + =A0 =A0 =A0 .uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D tps65023_uv_t=
o_vsel,
> > +};
> I see your point in http://marc.info/?l=3Dlinux-omap&m=3D129847126805=
656&w=3D2
> "Check the definition of omap_volt_pmic_info and omap_volt_data.
>=20
> Just to "hack" support we can fill *don't care* values for the
> fields not supported and wrap processing under if (cpu_is_....())
> checks; but this doesn't appear to be a good solution"
> PMIC specific data:
> > +       .slew_rate              =3D 4000,
> > +       .step_size              =3D 25000,
>=20
> SoC specific data + PMIC limits:
> > +       .on_volt                =3D 1200000,
> > +       .onlp_volt              =3D 1000000,
> > +       .ret_volt               =3D 975000,
> > +       .off_volt               =3D 600000,
>=20
> I dont like the following at all!
> > +       .volt_setup_time        =3D 0xfff,
>=20
> SOC specific
> > +       .vp_erroroffset         =3D OMAP3_VP_CONFIG_ERROROFFSET,
> > +       .vp_vstepmin            =3D OMAP3_VP_VSTEPMIN_VSTEPMIN,
> > +       .vp_vstepmax            =3D OMAP3_VP_VSTEPMAX_VSTEPMAX,
> > +       .vp_vddmin              =3D OMAP3430_VP2_VLIMITTO_VDDMIN,
> > +       .vp_vddmax              =3D OMAP3430_VP2_VLIMITTO_VDDMAX,
> > +       .vp_timeout_us          =3D OMAP3_VP_VLIMITTO_TIMEOUT_US,
>=20
> PMIC speciic
> > +       .i2c_slave_addr         =3D OMAP3_SRI2C_SLAVE_ADDR,
> > +       .pmic_reg               =3D OMAP3_VDD_CORE_SR_CONTROL_REG,
> > +       .vsel_to_uv             =3D tps65023_vsel_to_uv,
> > +       .uv_to_vsel             =3D tps65023_uv_to_vsel,
>=20
> Yeah they ought to be split properly IMHO.

[sp] Gr8. Good abstraction of PMIC functions and SoC functions
     related to VC/PC would be necessary. More importantly
     keeping the interfaces pluggable for different PMICs.

~sanjeev
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
