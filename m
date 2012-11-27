From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Tue, 27 Nov 2012 13:23:35 +0200
Message-ID: <50B4A2B7.9080806@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com> <1353663278.25248.4.camel@sokoban> <50B310D3.9050202@ti.com> <50B35D0E.6000509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig794E98B7711049BB183C7307"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51863 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2K0LXq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 06:23:46 -0500
In-Reply-To: <50B35D0E.6000509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--------------enig794E98B7711049BB183C7307
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-26 14:14, Archit Taneja wrote:

> So Rajendra and I found the problem.
>=20
> The function _omap4_update_context_lost() reads the register
> RM_DSS_DSS_CONTEXT for all DSS hwmods, and increments the count if we
> read a non zero value. The issue is that the DSS's parent platform
> device (tied to dss_core hwmod) is called first when resuming, it
> correctly reads the register and observes that DSS lost context, and
> then clears the register.
>=20
> When the children hwmods are enabled, the see that the registers are
> cleared, and hence never increment their count.
>=20
> One option is to make the DSS driver use the context lost count of the
> hwmod corresponding to the parent platform device. It sort of makes a
> bit of sense as all the DSS platform devices belong to the same power
> domain, so considering only the parent's context lost count is not so b=
ad.
>=20
> The second option would be to have some usecounting mechanism in
> omap_hwmod where different hwmods belonging to the same power domain
> don't have their PM_CONTEXT registers cleared until all the hwmods are
> enabled.
>=20
> The first option is easier to implement, here is a patch for the DISPC
> driver:
>=20
>=20
> From 619276fa0e62b90875475eb345a310f1223e82f6 Mon Sep 17 00:00:00 2001
> From: Archit Taneja <archit@ti.com>
> Date: Mon, 26 Nov 2012 17:22:27 +0530
> Subject: [PATCH] OMAPDSS: DISPC: Use DISPC's parent device to get conte=
xt
>  lost count
>=20
> When enabling a hwmod, omap_hwmod refers to the register mentioned in t=
he
> hwmod struct's member 'prcm.omap4.context_offs' to see whether context =
was
> lost or not. It increments the context lost count for the hwmod and the=
n
> clears
> the register.
>=20
> All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as
> context_offs.
> When DSS is enabled, the first hwmod to be enabled is the "dss_core"
> hwmod since
> it's the parent platform device. The dss_core hwmod updates it's contex=
t
> lost
> count correctly and clears the register. When the hwmods corresponding
> to the
> children platform devices are enabled. They see that the register is
> clear, and
> don't increment their context lost count. Therefore, all the children
> platfrom
> devices never report a change in context.
>=20
> The DISPC driver currently gets the context lost count for DSS from it'=
s
> corresponsing platform device instance. The DISPC platform device is on=
e
> of the
> child devices, and doesn't report the context lost count correctly.
>=20
> Make the DISPC driver get the context lost count from it's parent. The
> parent
> platform device's hwmod is the only one which correctly updates the
> context lost
> count.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index a5ab354..d9dfc4ad 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -374,7 +374,7 @@ static void dispc_save_context(void)
>      if (dss_has_feature(FEAT_CORE_CLK_DIV))
>          SR(DIVISOR);
>=20
> -    dispc.ctx_loss_cnt =3D dss_get_ctx_loss_count(&dispc.pdev->dev);
> +    dispc.ctx_loss_cnt =3D dss_get_ctx_loss_count(dispc.pdev->dev.pare=
nt);
>      dispc.ctx_valid =3D true;
>=20
>      DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
> @@ -389,7 +389,7 @@ static void dispc_restore_context(void)
>      if (!dispc.ctx_valid)
>          return;
>=20
> -    ctx =3D dss_get_ctx_loss_count(&dispc.pdev->dev);
> +    ctx =3D dss_get_ctx_loss_count(dispc.pdev->dev.parent);
>=20
>      if (ctx >=3D 0 && ctx =3D=3D dispc.ctx_loss_cnt)
>          return;

Hmm, well this feels like a hack. DISPC driver doesn't know how the DSS
modules are arranged, which module belongs to which power domain, etc.

If it cannot be fixed in the arch code, I guess we could just have
dss_get_ctx_loss_count(void) function which always returns the
dss_core's ctx loss count, and define that on all the platforms omapdss
is used, the dss_core's ctx loss count is the same as ctx loss count for
all the dss submodules.

I think the above is true for all OMAPs. But it feels like a hack too,
but not as bad as the above patch.

 Tomi



--------------enig794E98B7711049BB183C7307
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtKK3AAoJEPo9qoy8lh71cRIQAIO1yyM4YZTw3AiHKORdyKU3
m2vrMYyKumrRNDrofBE+RkM72eI12LgL3iuhK1ZDblL0XYNrKGqZijomZdSOJW7j
SDQ4Xqc07376EZ4PBHBY88s4aL1bzKuL8OxEkyRu+47pbpFxASTSS7QAF52ljsfS
0NQiM+8HXZEalmGWXFUg11tY3WFf4jJGtZabdrjy1JqcjxdWLudtEp6MpEweQw2b
ttigdGSG24qOsTuFKy3TPr0HBV0LKHaiDep/qIWEJDkAw/subtLwZ4Yf5Rt/OE8G
owoNE+FSVTkxqXujQVas9QRznOTXii5v69KfZ5EuiwpqWVVtFPpkoOqMA4tMfuAS
iH6vno3CHF+3sv8gwyNfcHZcJiux5Vcl3eWMYO0N3/8ZrNy66C2fuynulzxhlh2p
FvtuKL+9r0x4wiLU1jlQnPEFXTtnhk1AYdUBxBlUaKmXwZaZ6kczmUlmhCfX5sia
9pqxEXmTc9nTBorAEDQMWswaK0HaoZU1KBOCkqLFAsEf8DmJrQW/Ih2mgGYyPYV7
JOm9nERcimLiAen01Mdg1fMz77g9gtYpDAvK7P94TX99nmQdiA8YaIVlFzLgeRQu
IsCPwDoQFNtvXpH0eASowRtltRsuUe3pfvuR+OhCbfTUfuXia8paMnzLs2gM4Ges
hdV50kLE6eyASv+Hkj5v
=5lZd
-----END PGP SIGNATURE-----

--------------enig794E98B7711049BB183C7307--
