From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 08/16] mfd: omap-usb-host: know about number of ports
 from revision register
Date: Wed, 21 Nov 2012 21:44:24 +0200
Message-ID: <20121121194424.GB14290@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-9-git-send-email-rogerq@ti.com>
 <20121121134300.GJ10216@arwen.pp.htv.fi>
 <50ACE907.2000603@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUTu4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 14:50:56 -0500
Content-Disposition: inline
In-Reply-To: <50ACE907.2000603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 04:45:27PM +0200, Roger Quadros wrote:
> >> +	switch (omap->usbhs_rev) {
> >> +	case OMAP_USBHS_REV1:
> >> +		omap->nports =3D 3;
> >> +		break;
> >> +	case OMAP_USBHS_REV2:
> >> +		omap->nports =3D 2;
> >> +		break;
> >> +	default:
> >> +		omap->nports =3D MAX_HS_USB_PORTS;
> >> +		dev_info(dev,
> >> +		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
> >> +		   omap->usbhs_rev, omap->nports);
> >=20
> > please make this dev_dbg().
> >=20
>=20
> IMHO, I think this should be displayed on the console as the driver
> doesn't really support that revision and might need to be upgraded. It
> won't be displayed for existing hardware that we know about till date.

Ok, there are two ways to see this:

a) (my preferred) you don't treat it as an error, you assume that newer
HW is backwards compatible until proven otherwise. If that's the case,
you don't need this message because driver will just work.

b) you treat it as an error, you assume that newer HW is *not* backwards
compatible until prove otherwise. If that's the case, you don't need
this message because driver won't probe.

In both situations the message is pretty much meaningless. I prefer to
assume driver will work with newer HW and if it doesn't, it just means
(NOTICE, THIS IS MY OWN OPINION, NOT MY EMPLOYER'S OPINION BY ANY MEANS)
we're not fast enough delivering code to mainline kernel. We are the
first ones to have access to the HW afterall ;-)

> >> +		break;
> >> +	}
> >> +
> >>  	need_logic_fck =3D false;
> >> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> >> +	for (i =3D 0; i < omap->nports; i++) {
> >>  		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
> >>  			is_ehci_hsic_mode(i))
> >>  				need_logic_fck |=3D true;
> >> @@ -538,7 +561,7 @@ static int __devinit usbhs_omap_probe(struct platf=
orm_device *pdev)
> >>  		goto err_init60m;
> >>  	}
> >> =20
> >> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> >> +	for (i =3D 0; i < omap->nports; i++) {
> >>  		struct clk *pclk;
> >>  		char utmi_clk[] =3D "usb_host_hs_utmi_px_clk";
> >> =20
> >> @@ -588,8 +611,6 @@ static int __devinit usbhs_omap_probe(struct platf=
orm_device *pdev)
> >>  	}
> >> =20
> >> =20
> >> -	pm_runtime_enable(dev);
> >=20
> > moving this part around isn't part of $SUBJECT aparently.
>=20
> pm_runtime_enable is moved earlier so that we can read the REVISION
> register, so it is part of $SUBJECT.

fair enough, but then it needs to be mentioned on commit log.

--=20
balbi

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrS8YAAoJEIaOsuA1yqRESS8P/2GRKfo1+8unH83jst/J7ewL
Ct+sccrEcKNr70lD/oSuXnEwzsCoN9qwo72c82TUlulaPyhVaYmtgwXRE6MLjnWi
hBOD+xcLzGpi2ksCyX6JmgbvYWh71KTGTJHwF3MXqywiRycXIPA0aWz5hX7qphPo
McvWggF6IB3WY64oaWr4E/0goFUyh76dOd/a/OtEwkF1hnKT3bQWP0yDYz239hks
QTCSbz8yN46WuJqgs6Mw4gBQoUi6ByqBO2NaR0czRL+bCKzoMHpJy3uH+eBmP6Y5
PbDFV+DiRIJ+ha91cJXLTnj1L/3F0UR+7CmXYFXT/AwXZiDXnH969cM8KPxO7xT6
NyHPFgbC6N/6243HgKKT5A8Bd6l+MZVSn5YC5a5TE+6q4HlAcr5a+Rg8IzifuFfN
GtbGiR+Xw2o1wC52ZmCe54q6bHTaxopXKLjwwbyZXMkojooki4eUalmfUpDKkuTr
CaKuQMNFvJv7XTnzdMn8idVqwMX60ClE1IksVV4k8LPWS76r0UFbxqrUfz78Syoc
ibCwSCJZyUaTxQ5OXmyAeIG6jvslR4+45M3TDntTQ+t6a0NazaxhH+E5HJFquaP+
gyIlIvVFPPg3VE6xtLMKv6/OEA+Ks6f3fFHp4A2baFHgt9ZXk+yo8PEsoXuJPvls
hLcHil9HFIMhfipprWaQ
=90wq
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
