From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 13 May 2014 13:51:15 +0300
Message-ID: <5371F923.80000@ti.com>
References: <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C8293.4070506@ti.com> <20140509155504.GE17814@atomide.com> <53707A64.2060203@ti.com> <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com> <53709706.10501@ti.com> <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com> <20140512142646.GA31772@atomide.com> <5370E0C9.8050201@ti.com> <20140512155132.GH31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="m4nXENR6kh8QUaQn7uTA02JFtCsQP3Sur"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50903 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759665AbaEMKvn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 May 2014 06:51:43 -0400
In-Reply-To: <20140512155132.GH31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--m4nXENR6kh8QUaQn7uTA02JFtCsQP3Sur
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 18:51, Tony Lindgren wrote:

>> It's already in v3.15.
>=20
> Oh great.. And you dumped it into arch/arm/mach-omap2 too and I somehow=

> even acked it :( Looks like there's also the custom mux hacks. And
> custom hwmod hacks. And ongoing soc_is_xxx tinkering. Now let's not add=


The omap2_dss_hwmod_data, create_dss_pdev and create_simple_dss_pdev,
omap_display_init stuff can be removed when the DT conversion has been do=
ne.

For the omap4_dsi_mux_pads (or the omap5 dsi muxing that was recently
discussed) I still have no solution, but I haven't spent time on it. I
have dropped the omap5 dsi muxing from the latest series for that reason.=


dispc_disable_outputs and omap_dss_reset are needed because omap_device
doesn't handle resetting DSS properly, as special steps need to be done
for that. omap_dss_reset is called from the hwmod/omap_device code, so I
don't think this code can be anywhere else.

For the omap_display_get_version() I have no good solution. Making
separate .dts versions for all the needed OMAP ES versions seems like a
huge hassle to me, but that is one solution.

I think that would mean having separate .dtsi files for omapdss for
omap3_es1, omap3_es3plus, omap4_es1, omap4_es2, omap4_es3plus, and then
having separate omapxxxx.dtsi files for all of those, and then separate
board .dts files for the ES versions used on each board.

Or is there some sane way to define such things in dts?

> _any_ new crap into arch/arm/mach-omap2/display.c.
>=20
> So please consider this a huge eternal NAK to add any more crap to
> arch/arm/mach-omap2/display.c from me. No more new soc_is beyond
> the soc_is_am43xx() you have in linux next. No more adding=20
> of_find_compatible_node() beyond ti,omap5-dss you have in linux next.
>=20
> And no more new panel remapping in this file as soon as you have found
> a better solution. Preferrably by v3.17 merge window. This file just
> needs to disappear. Yuk.

Do you object to the compatible string remapping as such, or just that
it's in arch/arm/mach-omap2?

I guess nothing prevents me from moving it to drivers/, and having some
early-ish initcall doing the job.

If the remapping as such is horrible, I'm all ears for better ideas. I
spent quite a lot of time on it, and that's the best I could come up with=
=2E

It's rather simple prefixing of the compatible strings for selected
devices. The purpose of that is to have proper data in the .dts files
(which I think is very important) with the cost of having some rather
simple internal hacks in the kernel, which can be removed immediately
when we have a common display driver framework.

>> I'm not sure what it would give us to try to be compatible with
>> simple-panel.txt. The simple-panel bindings won't probably be compatib=
le
>> with the future common display drivers in any case, as the simple-pane=
l
>> binding is just too limited and doesn't describe the hardware fully.
>=20
> Hmm what else does a panel need where the existing binding cannot be
> extended?=20

The existing simple-panel binding doesn't describe the connections of
the panel, i.e. its video input. I guess it can be extended, but I don't
see what the benefit is of trying to create new panel bindings
compatible with the simple-panel bindings. As I see, the simple-panel
bindings work only with very limited use cases, where the drivers make
assumptions. Simple panel bindings cannot be used with omapdss, nor can
it be used with the future common display framework.

But I'm not really familiar with using extending current bindings, and
making new bindings compatible with old ones. Can you explain why it'd
be good to have the sharp panel bindings compatible with simple-panel?
In what kind of scenario would it be used?

 Tomi



--m4nXENR6kh8QUaQn7uTA02JFtCsQP3Sur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcfkjAAoJEPo9qoy8lh71bsoP/2XzYVdvMZUQUVF4syv3kPQL
31dF3zZXawjParSld1VBBTI8SaStp4+YQQoS97NxbOKRJr2F6zEIleoLL2pJPUuR
pFG33yVa4mv0iKwHuJSeBVI1qBGBAE0++PC9UV2NNZvVQzpGDWWf+nyH+2kTmbwv
GsJGY+TxoRZwj8D/YxeVf0ibu3VGKY+qjsfBukIWCOOFktL46q5GoImy1qydCQJr
K650H1Tq9rJGiYeSN3YVSq2194JpmJlCWDivl0Zl07DyoFI7UG12k/cQLejBIdJf
ZvyAGf+buv+pdRXuCMZ9ecAbDLSiw/EO34wInLQGbjQP+AhsNSdIHiHmNFk5t2Iu
2/1OwJmevDnakWlV1Uj5PlG/gpwObE0kvOtUAKc3ge/JRwsWogzowuUG3mxi0y5t
B2jqzNT/Ij1dX3cqhBJyy3D+qcYfMjSep87soxZj+grXJEVzzcWKMyFj1t4ujFXm
M+EDQC+7jCtegUOzFWriQWn8NPjD2ISIumhuZQXXUu0Y2FhgMtBWHggVu4BpeKyq
EOxWBMcYNYZadWFy3atzPndcH+ZmOaxqQk446FzIw/0XbpaPjvLO0O5hYtAesLQf
oIcvXT7uC8zR93CjsRQQdv+tWv/vVlt2aGc1pE6daLj5d/WCSd6F8REBi1G08eE8
9QJN7Gpter3ANL+LVaFa
=Vvu2
-----END PGP SIGNATURE-----

--m4nXENR6kh8QUaQn7uTA02JFtCsQP3Sur--
