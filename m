From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] arm: omap5: hwmod: add missing ocp2scp hwmod data
Date: Mon, 15 Jul 2013 18:46:03 +0300
Message-ID: <20130715154603.GC32035@arwen.pp.htv.fi>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
 <1373902423-28654-3-git-send-email-balbi@ti.com>
 <51E418A4.9000109@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52659 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab3GOPqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 11:46:52 -0400
Content-Disposition: inline
In-Reply-To: <51E418A4.9000109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <benoit.cousson@linaro.org>

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 09:13:32PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On Monday 15 July 2013 09:03 PM, Felipe Balbi wrote:
> > From: Benoit Cousson <benoit.cousson@linaro.org>
> >=20
> > without that hwmod data, USB3 will not in OMAP5 boards.
> >=20
> > While at that, also fix DTS data to pass reg property,
> > otherwise driver won't probe.
> >=20
> > Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/boot/dts/omap5.dtsi               |  3 +-
> >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++=
++++++++
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > index 5c99f19..4e41409 100644
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -652,10 +652,11 @@
> >  			};
> >  		};
> > =20
> > -		ocp2scp {
> > +		ocp2scp@4a080000 {
>=20
> While at that, can we also name it ocp2scp1 since we have 3 instances of
> ocp2scp and it'll conflict when we want to add it for SATA and PCIE.

Tony/Benoit, you want that in same patch or as a separate patch
altogether ?

--=20
balbi

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5Bk7AAoJEIaOsuA1yqREu4oQALQr8RH8onQR5QtDzKeOckW8
EE3M2ohrkqLb0xPjUVRxVweE6ZMdoyQzhvjwVwFk50la8IUlDBito5FRiIq1170E
yqpWdgSsnVXPkk4jdoeJSTHAFrD3DYgxy9qpsNJS5cIWXSCPJkiMZmSCRKlnt75p
h5QF498O5oB9iiGuCFm8CX8CTtVz63+5RYi3JkKha4ecXkqkEkFLpVPtMhh3DWos
O6+BOj/cgck2jGz0Nord3r9JUqVfQP0TDXwBjwRoaZRuyV26wffjPSAjUrVRHdsL
IKGcVqpX3EUp7xW8xOg9w678V+EL+KeC1hNLRAY5NlOL26HFpfX3wjDnAC8DjPBz
r9FzeuV2pkXRZYQbGH60djFY1CvazM+HKhuozSOPFmr9XeNpIxILpGbKEXmq1Mqs
VQva60qhAhdC9MnWlsfykYOT1TVzhm7yBrkMQ2/4N4vido5NpWNueWkBJ8LdkrwM
SmtfqcYnSX+tFPCeGHdXwPTbXieWvyVNKsDJwYQn6L5JNR5oEZj6KD+5IG3VwnvL
nB9VCtYoQk8isMUmoh3M4YNDZglcBzL2a+QI4sj2x6YtnVy6xAWSxBAuLQ3AjRe2
QlDZ2cSO5cvXeLvc7uW/X1pib2hidGP01ghXNUAT/qdSl+v1kD1D4AauOs4ieEtT
jZZ8RWvyPGdPNpeNTnNH
=NGh+
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
