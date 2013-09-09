From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv4] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 13:26:20 -0500
Message-ID: <20130909182620.GO9325@radagast>
References: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net>
 <20130909141531.GL9325@radagast>
 <A84D17B9-D194-46CC-8D9C-8CB602F2A332@dominion.thruhere.net>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="biWPhq3+BvkPqXf5"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A84D17B9-D194-46CC-8D9C-8CB602F2A332@dominion.thruhere.net>
Sender: stable-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olof@lixom.net, stable@vger.kernel.org, George Cherian <george.cherian@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

--biWPhq3+BvkPqXf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 09, 2013 at 04:26:38PM +0200, Koen Kooi wrote:
>=20
> Op 9 sep. 2013, om 16:15 heeft Felipe Balbi <balbi@ti.com> het volgende g=
eschreven:
>=20
> > Hi,
> >=20
> > On Mon, Sep 09, 2013 at 03:45:50PM +0200, Koen Kooi wrote:
> >> The BeagleBone Black is basically a regular BeagleBone with eMMC and H=
DMI added,
> >> so create a common dtsi both can use.
> >>=20
> >> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI =
transceiver=20
> >> after a dozen boots with an uSD card inserted because LDO will be at 3=
=2E3V instead
> >> of 1.8.=20
> >>=20
> >> MMC support for AM335x still isn't in, so only the LDO change has been=
 added.
> >>=20
> >> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> >> Tested-by: Tom Rini <trini@ti.com>
> >> Tested-by: Matt Porter <matt.porter@linaro.org>
> >=20
> > not entirelly related to $SUBJECT but having HDMI listed in BBB DTS will
> > prevent the use of RF cape, no ?
>=20
> Complete and utter lack of software from TI for the RF cape is
> preventing the RF cape from working regardless of HDMI entries.

How would you ever use RF cape with HDMI on BBB ? It doesn't matter the
amount of code TI (or whoever else) writes down, that will never work
fine.

--=20
balbi

--biWPhq3+BvkPqXf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSLhLMAAoJEIaOsuA1yqREjegP/ArO6F9itj4bTNhYt7CTwOS/
DXJGewogKtW3N0tpmPD01cpJesdGdZ3/xix2kINqL5D6PsBmkGfbvdBe9bPNlu7q
ueBh+2chQsqKQFKlURwJC/ZOPrd9hu7ODrCVvPUz/321M1Q67U81pD7S35HVUfEz
MpRaAISNr8Gen/+qrg/fns1825QbaLm+/YenlJGtH5agGXQi/2rfmgylkuNgBD4m
cVc+9J44B5du3GqyRsffx5eBuWSG2WH57wUv8rkLRF1Rg29Ua2JLbp/wacxOdpW1
UKm2marZvAuwMHXDQx0HKsxEfx0fEdi9zT48Zoj3P6QY0o5rfHMQRIbiChlv1djG
qnC54fobKvHLFDFiOfn1l6UY4ydFl+CESXw8RvbLerj6xs6PjCKf3kIz3fVCYK0s
kQKAb8WWEG2kJzmldaYdnoAiURoT0Z7CaTHFoiRHVTss9pEr+LM4dZnJ2BSUZ/Zg
3sV6GGmrwlR2daIhX2J1kcVoaH3jD4G6Wztp3EWc6YIZVLDS9xEy9lmYdreNmXfG
/pfOfFS6puUaMoEYEvURDGrvF65CsKgwnZYql8MzFaAr3GHS3eMBpFRDCBHcy6Vs
RUd5bOSuwK7wZs5HxliF+jtbfTplfE8Tu0sYZGkgiQGfkrL6QNvErWkXVu8nfRqS
cshgCyHLna3Y2hEm6haI
=JgJc
-----END PGP SIGNATURE-----

--biWPhq3+BvkPqXf5--
