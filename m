From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 08 Aug 2012 11:48:05 +0300
Message-ID: <1344415685.4932.14.camel@deskari>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	    <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>
	   <1344407158.17575.21.camel@lappyti> <50220B94.5040303@ti.com>
	  <1344410835.17575.54.camel@lappyti> <50221C4D.8000503@ti.com>
	 <1344413580.4932.5.camel@deskari> <50222575.6050807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/1bL5WJooFSaVMQLQk1N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45068 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757869Ab2HHIsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 04:48:10 -0400
Received: by lbon10 with SMTP id n10so433366lbo.39
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 01:48:07 -0700 (PDT)
In-Reply-To: <50222575.6050807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-/1bL5WJooFSaVMQLQk1N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 14:08 +0530, Archit Taneja wrote:
> On Wednesday 08 August 2012 01:43 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-08-08 at 13:29 +0530, Archit Taneja wrote:
> >
> >> Okay, one thing which I want to align on is that most of these functio=
ns
> >> don't really do the actual configurations. That is, they'll just updat=
e
> >> the private data, and the actual configuration will only happen on ena=
ble.
> >>
> >> We would want set_timings() op to have a direct impact. But we wouldn'=
t
> >> want the same for setting the data lines, that could be clubbed with
> >> other configurations at enable. That's okay, right?
> >
> > I'm not sure we want/need set_timings to have direct impact. Changing
> > the timings on the fly has some problems, like the output size changing
> > to smaller than the overlays, and we perhaps may need to adjust the
> > clock dividers (dispc's, DSI PLL's or PRCM's).
> >
> > It feels just much easier and safer to require that the mgr is disabled
> > when these changes are made. And as far as I can see, there shouldn't b=
e
> > any need to change the timings via the shadow registers, as quickly as
> > possible and during vblank...
>=20
> That makes sense. But currently set_timings for DPI has a direct impact.=
=20
> HDMI/VENC/SDI take the easier route of disabling and enabling the interfa=
ce.
>=20
> I agree it's safer and easier to make sure things are disabled first,=20
> but maybe it's good to have the capability set hdmi timings on the fly=
=20
> in the future, it would make the switch faster, same goes for reading edi=
d.

When do we need to switch mode quickly? Reading edid should not require
disabling the output for sure.

HDMI is a bit broken currently, though. I think we first enable the
whole stuff, including video output using VGA, then we read EDID, then
we change the mode.

We should just enable enough of HDMI to be able to read EDID, and start
the video output with the correct mode. This needs some restructuring of
the driver, though. I tried it once quickly, but it turned out not to be
trivial.

> What I meant to ask was whether we should do the same for something like=
=20
> dpi_set_data_lines(), that is, disable dpi, update the data_lines=20
> private data with a new value, and enable dpi again.

Hmm, I think it's better to leave disabling and enabling the output to
the panel driver. So when the panel driver wants to use
dpi_set_data_lines(), it needs to first disable the DPI output. If it
doesn't, dpi_set_data_lines() returns -EBUSY.

Otherwise if the panel driver does something like:

dpi_set_foo()
dpi_set_bar()

Both of those could first disable output, change setting, enable output.
Instead the panel should first disable, then call those, and then
enable.

 Tomi


--=-/1bL5WJooFSaVMQLQk1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIifFAAoJEPo9qoy8lh71lT0QAKJxweT+sSlXrjf0BhnJXKiy
o9ZP1ueYJyv/HrBQPyKJUf/sTi7gGfplwakqOTN7IeKHmxdtfahaKc6M3F05JiqF
Z9PXF9qTmcXr6UgTHc5tUsIx/syhS7mciv9Jc1+JeF3CqgFpJWyKprwfR59gQQ39
AtRE9yXzzfCm/CSui98n9y62bJCF5Lxa5Y28KcZMEX0FblroqOL4bzQej5Zl48vb
Rt8Y4mn6YmMv33jwwVzuS5pFPhlYh6ncH/SgNmi4830wepTSTYyF7uWZxsHiMNRm
rBQCqIfQhQNWcOCfdVB3aF65jSuq/u5imSfz56I1iKNsv6zwm2pN+wuNkRIOED/E
dTBIIr/Lq4EzHxaQKfZaYR3pTSb/YhNGe05tcgNW9pQkPOI1C11gKF/YWJ/cXobV
f5ze0D10CrVRMVTBf47JSJ1nubPVc3OFcTKzr1mD4gNR86QFEsJnjoPFweVHHiuS
bApN0ZOWEmPEh1/QNlrn1K/IDMxk8d0S+srVfFdu1WizfXGi8N5UCFuuLjiylg/d
tAaCwmAz2fuUqFERpMZph4O7rZbAELShyXIi4b5/KAAsS1DqvkEAqHSmMtL6+vWY
C/hHtz02z3jy40chj5gpWtabSMpnl9LHWJWBUo64pvVkvAw5lXAulJnYPJqVRiXi
Lous+lvVjNMkwUIcCnpN
=dg1k
-----END PGP SIGNATURE-----

--=-/1bL5WJooFSaVMQLQk1N--

