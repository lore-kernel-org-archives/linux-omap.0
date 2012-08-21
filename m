From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V5 5/6] ARM: OMAP: Disable venc for OMAP4
Date: Tue, 21 Aug 2012 13:32:39 +0300
Message-ID: <1345545159.4085.45.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <a07a3a216827e830cfa249f4f39ad26e75dc0afd.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VFDOLI4TAz7ehIS3V98n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:52552 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756253Ab2HUKco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:32:44 -0400
Received: by lage12 with SMTP id e12so6318372lag.27
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:32:42 -0700 (PDT)
In-Reply-To: <a07a3a216827e830cfa249f4f39ad26e75dc0afd.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-VFDOLI4TAz7ehIS3V98n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-20 at 18:54 +0530, Chandrabhanu Mahapatra wrote:
> This is a alternative to "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 t=
o
> prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> to =
prevent
> VENC from crashing OMAP4 kernel. This prevents OMAPDSS from initial regis=
tration
> of a device for VENC on OMAP4.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  arch/arm/mach-omap2/display.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.=
c
> index af1ed7d..ee40739 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -95,7 +95,6 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod=
_data[] __initdata =3D {
>  	{ "dss_core", "omapdss_dss", -1 },
>  	{ "dss_dispc", "omapdss_dispc", -1 },
>  	{ "dss_rfbi", "omapdss_rfbi", -1 },
> -	{ "dss_venc", "omapdss_venc", -1 },
>  	{ "dss_dsi1", "omapdss_dsi", 0 },
>  	{ "dss_dsi2", "omapdss_dsi", 1 },
>  	{ "dss_hdmi", "omapdss_hdmi", -1 },

You need to reorder this and the previous patch. If you first remove the
workaround from the previous patch, the kernel will crash if after that
patch. So this one should be before the previous patch.

 Tomi


--=-VFDOLI4TAz7ehIS3V98n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM2PHAAoJEPo9qoy8lh71kvYQAKmrX5C+65ceDZjYFvwqQUqy
iPn6jVn/prVPueaYF7H0AG8QPDNTjG47OO73BYBLKxWN/JVAD5AZMP1oY18mQhlu
lIF71iGNxYnPV3Ae1MxLIlMnBCQewAfJ+foFrheWb3zHZjOgmOzeDMVEuaTd/hVr
1+OyMEqTqYFiCqLEpt3Xvr6wo0FUbRMYwCkL/bN5G4iJiyAiFeb9DdB9U2ihXS24
A2qJsIJB4Re4Ahjxo7lcQkUBgb+6Pll495cpcZ5jGw69as6Ilr4ATVg15TSGjYkc
2YpiMU84D8onf/eS05Br2KFv//6oYK7nu9CNVGeJglVhhCI9wUhDCCRm9M7YeePV
LMQLQ9u4MqBk1UWYqQlLwA66E7Qa/j5AIVDUFt/nY9bLGc0f51PTHOM6z9Nm0Vm1
snqARFpwZMOS+Ea/b4f6MvHebjW7jjPqlAhVxdSdoK2wHXUDmgsFn5+ye4LNr0+w
rXdtkflosxMeapMh138cmEvpApNhA18FnNSIOCsyUM4AJ4oPYJJ5mgga1gxrDl0q
uiInjMsFT5zxf6z9pNVM8j2KKwwfHvT0wN6RBRtPgEDgMlRZqRpQky2ceYHnWxFA
du1H5wWJ6wPRVILkLfyx12qUdcixMryAUva4GpDuEz/so+1emkdewz7M3LXVyYDd
vFfYSUyOfOUqifjS7vMx
=1tvx
-----END PGP SIGNATURE-----

--=-VFDOLI4TAz7ehIS3V98n--

