From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 12:08:04 +0200
Message-ID: <50939B84.6090602@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig937DABBD3B3C7387202A4C1D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40198 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758917Ab2KBKII (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:08:08 -0400
In-Reply-To: <5090D28E.6050703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enig937DABBD3B3C7387202A4C1D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-31 09:26, Archit Taneja wrote:
> On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:

>> -    if (dpi_use_dsi_pll(dssdev)) {
>> -        enum omap_dss_clk_source dispc_fclk_src =3D
>> -            dssdev->clocks.dispc.dispc_fclk_src;
>> -        dpi.dsidev =3D dpi_get_dsidev(dispc_fclk_src);
>> +    /*
>> +     * XXX We shouldn't need dssdev->channel for this. The dsi pll cl=
ock
>> +     * source for DPI is SoC integration detail, not something that
>> should
>> +     * be configured in the dssdev
>> +     */
>=20
> It is SoC integration detail, but it's flexible, it depends on which
> manager is connected to DPI output. If it's connected to LCD1, the

Hmm, yes, the comment is a bit misleading. The DSI PLL is not used for
DPI, but for DISPC's LCD output. And DPI uses one of those LCD outputs.

> source can be DSI1 PLL, if it's LCD2, it's source can be DSI2 PLL, if
> it's connected to TV manager, it's source "has to be" HDMI PLL. And
> these connections vary based on which OMAP revision we are on. We can
> only be certain on OMAP3 that the source for DPI pixel clock can be
> either PRCM or DSI PLL.

On OMAP2 we can be certain the clock is PRCM =3D).

> At the point of probe, we really don't know which manager is the DPI
> output connected to. Hence, we sort of use dssdev->channel to make a
> guess what manager we connect to in the future.

Yep. My point was mainly that dssdev needs to go away, and we should
somehow decide the used channel internally.

> The right approach would be to figure this out at the time of enable,
> where we know which manager the DPI output is connected to. We could
> probably move the verification there too.

Who chooses which manager to use for DPI?

I'm not sure... I would really like to manage the basic setup, acquiring
the resources, etc. at probe time, and enable would only enable the displ=
ay.

That means that we should somehow get a manager for DPI at probe time,
which may be a bit difficult, as we don't know what other displays there
will be. So if, say, DPI can use LCD1 or LCD2, but DSI can only use
LCD2, and at DPI's probe (presuming it's before DSI) we pick LCD2, DSI
won't work.

Anyway, while I'm not sure how to solve the above problem, I think we
should improve our init a bit. For DPI there are the following steps
done, in order:

- DPI device added
- DPI driver probe
- DPI panel device added
- DPI panel driver probe

We currently add the panel device in DPI driver's probe, and figure out
the DSI PLL at the same time. I think that should happen only when the
panel driver probe happens. The panel driver should call something like
dpi_get_output() or whatever, which acquires the DPI bus for the panel
driver, and this would probably also choose the manager.

 Tomi



--------------enig937DABBD3B3C7387202A4C1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQk5uEAAoJEPo9qoy8lh71B7AP/20eJC+AYvaREyTDkicEIVnN
BpyUCndJxMcxxIcCH+RoY2UdDCEo4OZYJR7g6c6AeLpHoWQZ0XZPfQu6bdQBhYn0
9ftuA1hXX8PM/qjMN3Z3FVF6XOx0E+mj85LOfhX89Wvbgsh7rJu++C41ieonaafI
M+XvZzoJhsG3kzAVmeppNjgiPNN73lzrLDCbQORpwQyIrjqTBBvxpsVptYyBu+am
KLHXIdI34P75FHY/yHS/CWLCfIOVaWZDYdEOYOA9al/cNonkjTV3f+mYOZnHBlM/
03UUx6LXKZIeWgKEjWFm2g0pMBE0hADccMZg9Op6NW6q86wpRaTvBob1PBk/RjHr
GscMzFqV07d3w+Un5ZCMYzgKQovbboll7z4N365yXcfR7U543DheAibZD+II8rb/
qCyvk8p95R9+LDo68R7AiN654vtuwuX0v4PrMY/3V49qmYwkBHof4BwNC+123QqQ
vOa/Q9iE1nWg3bKJEXSAYJEzVXD7+V0eVZEx+nW4a1zGToEWVs9Oc8tkTDcEB4MS
b6Nc2LVqNH9nlAfU/1vR/cDH+8REt2sCvgN3BqKt98Qg/mil5JvumubnxrcXLWCA
2xNK+a6mcy8+QaoA63tCe+1CtiaI3hcyMMCS6OLsffVaUQCSIL6S6KYywtUlmTRE
B4MIHHqSl5mZIbs+stpG
=W6i3
-----END PGP SIGNATURE-----

--------------enig937DABBD3B3C7387202A4C1D--
