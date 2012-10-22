From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/8] i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
Date: Mon, 22 Oct 2012 16:09:08 +0300
Message-ID: <20121022130908.GZ14033@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-6-git-send-email-balbi@ti.com>
 <50853BA8.8000200@ti.com>
 <20121022122853.GW14033@arwen.pp.htv.fi>
 <50854490.4060306@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CDSQlumANh/CoDwR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50854490.4060306-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--CDSQlumANh/CoDwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 22, 2012 at 03:05:20PM +0200, Benoit Cousson wrote:
> On 10/22/2012 02:28 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Oct 22, 2012 at 02:27:20PM +0200, Benoit Cousson wrote:
> >> Hi Felipe,
> >>
> >> On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> >>> on OMAP4+ we want to read IRQSTATUS_RAW register,
> >>> instead of IRQSTATUS. The reason being that IRQSTATUS
> >>> will only contain the bits which were enabled on
> >>> IRQENABLE_SET and that will break when we need to
> >>> poll for a certain bit which wasn't enabled as an
> >>> IRQ source.
> >>>
> >>> One such case is after we finish converting to
> >>> deferred stop bit, we will have to poll for ARDY
> >>> bit before returning control for the client driver
> >>> in order to prevent us from trying to start a
> >>> transfer on a bus which is already busy.
> >>>
> >>> Note, however, that omap-i2c.c needs a big rework
> >>> on register definition and register access. Such
> >>> work will be done in a separate series of patches.
> >>
> >> Do you need OMAP_I2C_IP_VERSION_3 for OMAP4?
> >>
> >> OMAP_I2C_IP_VERSION_2 was already introduced to detect OMAP3630 vs
> >> omap4430 because they were sharing the same IP version..
> >>
> >> /* I2C controller revisions present on specific hardware */
> >> #define OMAP_I2C_REV_ON_2430            0x36
> >> #define OMAP_I2C_REV_ON_3430_3530       0x3C
> >> #define OMAP_I2C_REV_ON_3630_4430       0x40
> >>
> >> So in theory you should not need an extra version.
> >=20
> > are you sure that's how they're used ? Looking at the code where we
> > choose reg_map_ip_v1 and reg_map_ip_v2:
> >=20
> > 1120         if (dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
> > 1121                 dev->regs =3D (u8 *)reg_map_ip_v2;
> > 1122         else
> > 1123                 dev->regs =3D (u8 *)reg_map_ip_v1;
> >=20
> > And looking at reg_map_ip_v1:
> >=20
> >  218 static const u8 reg_map_ip_v1[] =3D {
> >  219         [OMAP_I2C_REV_REG] =3D 0x00,
> >  220         [OMAP_I2C_IE_REG] =3D 0x01,
> >  221         [OMAP_I2C_STAT_REG] =3D 0x02,
> >  222         [OMAP_I2C_IV_REG] =3D 0x03,
> >  223         [OMAP_I2C_WE_REG] =3D 0x03,
> >  224         [OMAP_I2C_SYSS_REG] =3D 0x04,
> >  225         [OMAP_I2C_BUF_REG] =3D 0x05,
> >  226         [OMAP_I2C_CNT_REG] =3D 0x06,
> >  227         [OMAP_I2C_DATA_REG] =3D 0x07,
> >  228         [OMAP_I2C_SYSC_REG] =3D 0x08,
> >  229         [OMAP_I2C_CON_REG] =3D 0x09,
> >  230         [OMAP_I2C_OA_REG] =3D 0x0a,
> >  231         [OMAP_I2C_SA_REG] =3D 0x0b,
> >  232         [OMAP_I2C_PSC_REG] =3D 0x0c,
> >  233         [OMAP_I2C_SCLL_REG] =3D 0x0d,
> >  234         [OMAP_I2C_SCLH_REG] =3D 0x0e,
> >  235         [OMAP_I2C_SYSTEST_REG] =3D 0x0f,
> >  236         [OMAP_I2C_BUFSTAT_REG] =3D 0x10,
> >  237 };
> >=20
> > that's really not the register map on OMAP3. That only looks valid for
> > OMAP1.
>=20
> No that should be valid as well for OMAP2&3 thanks to the
> OMAP_I2C_FLAG_BUS_SHIFT_2.

aha.. I see. What a hack!

> It was introduced during DT adaptation:
>=20
> #ifdef CONFIG_OF
> static struct omap_i2c_bus_platform_data omap3_pdata =3D {
>         .rev =3D OMAP_I2C_IP_VERSION_1,
>         .flags =3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
>                  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>                  OMAP_I2C_FLAG_BUS_SHIFT_2,
> };
>=20
> static struct omap_i2c_bus_platform_data omap4_pdata =3D {
>         .rev =3D OMAP_I2C_IP_VERSION_2,
> };
>=20
> static const struct of_device_id omap_i2c_of_match[] =3D {
>         {
>                 .compatible =3D "ti,omap4-i2c",
>                 .data =3D &omap4_pdata,
>         },
>         {
>                 .compatible =3D "ti,omap3-i2c",
>                 .data =3D &omap3_pdata,
>         },
>         { },
> };
> MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> #endif
>=20
>=20
> > -ECONFUSED
>=20
> Well, it is confusing...

Tell me about it... in that case, $SUBJECT can be dropped silently, I
will respin next patch so that it checks for VERSION_2 instead of
VERSION_3.

cheers.

--=20
balbi

--CDSQlumANh/CoDwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhUV0AAoJEIaOsuA1yqREZXMP/A8LwrEyo1foBMGZaFJi1zRg
/CAa8aKfWyAyzL1QrZxK2y5q8R9dIeJHPSQtnYA5g+gJwX+XchmShuq52KPXPq3/
d5Qx6r/mqo4xJMEzFuxPoCgA47gO7khkng1T0762aILbvYM+NALqKArfblDYSDAD
0bg0JChQRsbtFGhsHQcd4ZD1vU7M9hVSTA3avUO11FTqCQHcMU/ob2v3GM+LfTFK
FhrRTSJid+QCg8Y+P9sFE8+2e22giEPieg/vi2FUs1pQmG83Nl7u3nc8HB3Juo68
s9OZbHJTEQPGxlNMtMU6D9r+IVMIg2cKeF6fsE51c8krBvOKYSxtSop0VMaM2B+n
rrK7PykzS/b6T+d2hYecAefNE4+H7gCA3ERWoWK9sykEcvbjFUenvaxGrVKfz2Nq
f/pQzsCVKHG5Agkdvh7qAvfclsMRtcLz+Vzb22Odr2WHPzardzSMYkjWGt8w+Ir6
9SGR2M6qcv2JMdKVzxNI4pZ6hC2a59L2fC61BpY1olIhgSzbe3o1VqATK5LAjA5h
1kUKysVoT2MSHx7u32pTKTrLoPipbSI5lVhVFiLcETGi70BPw9synV+SCCsa5IyV
3hIOWn4hcSPs9dY/lXLaIxKkPce5fSrs4fdFSUtC4n9Eg3ixQLqDcygPTpPbBoxj
cGzEhF8Rk+acnNDTSUzB
=jAFZ
-----END PGP SIGNATURE-----

--CDSQlumANh/CoDwR--
