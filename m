From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 17:37:45 +0300
Message-ID: <51700539.7080603@ti.com>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars>  <516FB845.3070505@ti.com>  <516FBB19.4090609@ti.com> <1366280026.4085.55.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D8641BAB21A52E42329DAE7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42907 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965340Ab3DROhu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 10:37:50 -0400
In-Reply-To: <1366280026.4085.55.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enig9D8641BAB21A52E42329DAE7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-04-18 13:13, Christoph Fritz wrote:
> On Thu, 2013-04-18 at 12:21 +0300, Tomi Valkeinen wrote:
>> On 2013-04-18 12:09, Tomi Valkeinen wrote:
>>> On 2013-04-18 11:37, Christoph Fritz wrote:
>>
>>>> With linux-next this patch breaks compiling here because DPI now dep=
ends
>>>> on DSI - but my omap3 board here doesn't use DSI at all:
>>>>
>>>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_cb=E2=
=80=99:
>>>> drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of fu=
nction =E2=80=98dsi_hsdiv_calc=E2=80=99
>>>> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_calc=
=E2=80=99:
>>>> drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of fu=
nction =E2=80=98dsi_get_pll_clkin=E2=80=99
>>>> drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of fu=
nction =E2=80=98dsi_pll_calc=E2=80=99
>>>>
>>>> Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You ma=
y be want to merge it?
>>>
>>> Thanks for reporting this. We shouldn't make DPI depend on DSI. We
>>> should make dummy functions for the above when DSI is not enabled so
>>> that DPI compiles. I'll make a fix.
>>
>> Patch below. Can you try it out? It works for me on Panda.
>=20
> Thanks, it compiles here fine too.
>=20
> and while booting I'm now getting as with 3.9-rc:
> [    0.409729] OMAP DSS rev 2.0
> [    0.410980] omapdss DPI error: can't get VDDS_DSI regulator
> [    0.410980] omapdss DPI error: device ips-056t init failed: -517
>=20
> But here with linux-next (in contrast to 3.9-rc) removing all regulator=

> dependencies from drivers/video/omap2/dss/dpi.c does not make the trick=
=2E
> The display stays dark :-( ...

That's with your DT hacked kernel, right? Not the official supported one.=


I don't think anything changed related to regulators in omapdss.

 Tomi



--------------enig9D8641BAB21A52E42329DAE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRcAU5AAoJEPo9qoy8lh71CjMP/3v6+ccVP3BCJ8JEqmq6JsdM
mtFy19fReemjCIGRNYI5FuHEeHS3VL1eSBXkvIFOTupTSKAT8JCDzvhc+DEYrBT3
iuHRBhlfQC+VTceQczR4l1tuSDivI/Q1AIwiMsEUk25FC4r4PBBLOVa89mZK+BKw
VXSfj1QaSLV6XksXPkGsIUqjBKuxUrKyfTELumwI0vuAWNlySJM+NSQk0d7IxLgd
GNuGIenVF79PWmtEuURlkhp2IDrXBKiiP9A8Ren90q+zSJimHaYWF9C9DIT02CN8
xlXtU1CzSoppQVme8nl+PlFTxlZ+Vr35VeKQdABCKqB4m4KdNmMER0qKR3qc6aLb
24zpjJ19dhUuvGGJ9FPG9QTlRByy0RJR6G1tgoVHcfHQmAFoFWYDtrLVOTPGa0AM
n9tRwDZamVvl0qOY+FOjsf64gxCjO9YPXnkiTrZHOO+LRfAy8E+IVy6Vq+/hpkGE
p2C/hyYelaZNwnBHvFoiH3Af0grS5rEFNdjgL/wvFDAFOBYgzalt8U+qHwl8HMzW
W6Av3gYgis0MZvJ7KS+tBpDOi/gOYiBb5QGwNT5jY++xhfCbvfWQeoKfey+6U6L8
eDfpjm+/q9wrypmEgZIqGbdJ9cPtJzLi28DGPMDEPSeAjR25LEoaQzZwG6tb32Pa
lKtABF4k/pDhZWzZQvdI
=rZUn
-----END PGP SIGNATURE-----

--------------enig9D8641BAB21A52E42329DAE7--
