From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 20:23:58 +0300
Message-ID: <20120907172355.GA9208@arwen.pp.htv.fi>
References: <504A11E4.6000406@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34812 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088Ab2IGR2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 13:28:24 -0400
Received: by lagy9 with SMTP id y9so1996467lag.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 10:28:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <504A11E4.6000406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 07, 2012 at 05:25:24PM +0200, Benoit Cousson wrote:
> Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre=
),
> we can now specify reg and interrupts using standard device tree
> attributes.
>=20
> Update the OMAP4 dtsi file with missing reg and interrupts attributes.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
>=20
> Hi Tony,
>=20
> This is the first step toward reduction of the hwmod data inside mach-oma=
p2.
> OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
>=20
> DMA is still missing, but I hope that the discussion that happened during
> LPC will fixed that soon.

Very nice work. Do you already have a way on omap_device creation to use
DT data instead of hwmod's ?

cheers

--=20
balbi

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSi2rAAoJEIaOsuA1yqREkMMP/jCyBZv8rPSFY/tZ59/8G5qe
UYDGjRelai0tJLlFVItt6pK0Wi8nEMPB5uQv9j3Ittlbs89UkIl9ycRtleC6MeTC
oU12YG7QOeHXiQEM0Ji5HX6UdbcRZyIjn4vpMk+HuCg/PMBOFyLI1Syvz3LSslFF
CH2Waby1A01oszDORANecYDkbDGQ5TO/ucN8KPpA/tJ6081JVc4Q8Z7rrLKtvfRr
rpRvqk3HBhlLQEkvNTp9oGcTUexT8+ca7T53wqcUKvPvcnm6w9kU/QoAY5xX3Nsk
t35ZvYvmiGRwdd9L+nUVQeVR9Ed9/tu2LHE8zxJHEZH+Tw6oagwcV2rVO7diUUVn
BUW9GHlrglA55qz/nro4Lag6NwsdI3a6iLKg2XXuZbDaYjS6bXIhsT1+rWx2o+kE
xrYVYFts4lrN6hlcGLtUTeV0KsninKCmhR3s4JfOmjUdr/JtOiv6t0awiGmloWTh
hWQpRIshyJ4OZeWiCeOnAPthtOud2Gx4uG+VQp3e4XahUSj9mDKQsGvTrDo0Ngu+
s6iawql/f6Rvn8M1m0x1MQsn+IShumRiEtLR0GPvAitmL6uTKGGvk2/mNkvs09Av
5esOb5W6Bjtx+uft9WHDTBT61/DUpQnEgVGC4aNl5Gx+0QIjdxQQsNpiI83zStW2
s6WcRoJxJQq1Fw3MfSB8
=rOAc
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
