From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 15:37:06 +0200
Message-ID: <513F2F82.2040604@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com> <513F05A0.6040204@ti.com> <513F2639.5060008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F7FDF15BD22A295C17A22CC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab3CLNhJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 09:37:09 -0400
In-Reply-To: <513F2639.5060008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig6F7FDF15BD22A295C17A22CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-12 14:57, Archit Taneja wrote:

>>> We could also use the recommended channel way for omapdrm, I can't
>>> figure out what's the better approach at the moment.
>>
>> Hmm, I think it'd be safer to use the recommended channel from omapdss=

>> for now. The current omapdss code doesn't really let you use any other=

>> channel than the recommended one (which was thus renamed to
>> dispc_channel in my later version).
>=20
> I think omapdss needs to give the freedom to set a different dispc
> manager for an output. This is because in omapdrm crtcs are sort of
> floating, and when a connector(and it's encoder) needs to be enabled, i=
t
> tries to look search for a crtc it can connect to. If omapdss sort of
> fixes the output->manager link, which is not how it should work.
>=20
> I think it is fine for us to use this approach for omapfb when creating=

> the links, but not within dss.
>=20
> For example, the code here:
>=20
> -    /*
> -     * XXX We shouldn't need dssdev->channel for this. The dsi pll clo=
ck
> -     * source for DPI is SoC integration detail, not something that sh=
ould
> -     * be configured in the dssdev
> -     */
> -    dsidev =3D dpi_get_dsidev(dssdev->channel);
> +    dsidev =3D dpi_get_dsidev(dpi.output.dispc_channel);
>=20
> We are sort of using the recommended channel to figure out which DSI pl=
l
> to use. We don't have much of an option here because dpi_init_display()=

> happens much earlier. But if it were to connect to a different manager
> later on, we would get into trouble.

Right. It should be changed to allow dynamic dispc channel changes (as I
said in my mail). But that requires changing how the output drivers and
the output.c work. Perhaps nothing too difficult, but just something
that has not been done =3D).

>> Or does your patch do a better job at selecting the outputs (I'm mostl=
y
>> thinking about OMAP5 here, which has a bit more conflicts with the mgr=
s
>> and outputs than earlier omaps).
>=20
> My approach is very drm oriented, the problem with omapdrm right now is=

> that we want to limit the number of crtcs(which map to managers). The
> lesser the number of crtcs, the more free planes we have for overlaying=
=2E
>=20
> If through bootargs or CONFIG, we set NUM_CRTCs to 2. We can only set u=
p
> only 2 overlay managers. My patch just tries to figure out which are th=
e
> best 2 managers to choose out of the total number of managers, in such =
a
> way that most encoders/panels on the platform are supported.
>=20
> The drm framework(I think) keeps the connections between crtc and
> encoders flexible through the possible_crtcs flag maintained by
> encoders. It figures out which crtc is free, and tries to use that one
> at that moment. Once that encoder is done using it, the crtc can be use=
d
> by another encoder later. We can also change the crtc of an
> encoder(after it's off).
>=20
> So omapdss fixing the dispc channel for an output doesn't seem suitable=

> for drm.

So, I don't disagree with you. But I don't quite understand why we could
not use the fixed channels for now? They should work in all the boards
we have, right? Or is there something with DRM that forces the driver to
select the channel dynamically?

As long as omapdss doesn't handle switching the clock sources (and
perhaps some other settings also, like OMAP5's DPI video source
selection. we've never had support for changing the channel later.),
having omapdrm select the channels could lead to problems if it happens
to select the wrong channel.

 Tomi



--------------enig6F7FDF15BD22A295C17A22CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPy+CAAoJEPo9qoy8lh712OIP/3f283i07FQtHWQLBRs5vcic
VUGEOPg2wicAArh2tOxbkMi4JbJU2pFs4ppyGdVbeZCc0ako3wRXV1yq96HgINYK
xYasht0f3z1Pk3NTs/7AYK8JXkJJw0wcSvROxcK4Okv8rK7Vf9E0ZyIdBHez+NPq
GQIxQ8dsMVy9YiFv4pnYWsTBLWfPzDeVIup6xUwsU+ttHsVOPv5nYj13wiuwkLeJ
BaN8je8A9g0zNjcqB0KnJ7oas408JkljQWxJML7x8zp6HZqhOKigCrWouvuxeuiX
quuyDZt07B58/opt6/oRiqftCdfTOO90i1NDHjjgs51BsEvhjKYUlme9XMueLCbk
6kWmoCkDMY3+YZ4Eq4h34NPPBB69bbCCN1grURS6uVWCGG+z1DpxaAhV4IlvzZaK
k58p/N0kZNxDn/8j5h4M88XxZCTov36dMMGhWeOeMPeS6m1FjsVpjsOro8Gy0qid
uQhFiQnb7RpGsralCjWTOU950Qt5SO9e6v8RwQc+tq/90OXtW/ahG7La5dWT7bCW
hkM/mr5k0v7xv3eh1pi7anFpRLLyVRebMftpR6Hg4qFSONqdRU2Ixvb7RCMPaY8H
ss7NCOsP6tXx5vTNHzIfCqqU7QadaBaFvqxGXwzKijC4QuP/CGGgjB4JQCD7coCp
i1hAmRlbrALM/aso9lti
=JZpx
-----END PGP SIGNATURE-----

--------------enig6F7FDF15BD22A295C17A22CC--
