From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 0/2] OMAPDSS: Enable dynamic debug printing
Date: Wed, 26 Sep 2012 17:29:52 +0300
Message-ID: <1348669792.2376.51.camel@deskari>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
	 <cover.1348636132.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+UQZObn+EuSANdPe7Gbl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36478 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756520Ab2IZOaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 10:30:05 -0400
Received: by lbon3 with SMTP id n3so1767834lbo.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 07:30:03 -0700 (PDT)
In-Reply-To: <cover.1348636132.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-+UQZObn+EuSANdPe7Gbl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-09-26 at 10:45 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> this patch series aims at cleaning up of DSS of printk()'s enabled with
> dss_debug and replace them with generic dynamic debug printing.
>=20
> The 1st patch=20
>  * replaces printk() in DSSDBG definition with pr_debug()
>  * removes DSSDBGF definition and replaces its instances with DSSDBG()=
=20
> The 2nd patch
>  * cleans up printk()'s in omap_dispc_unregister_isr() and=20
>    _dsi_print_reset_status() with pr_debug()
>  * removes dss_debug variable
>=20
> Changes with respect to V1:
>  * added debug messages to DSSDBG calls replacing DSSDBGF
>  * added patch "OMAPDSS: Remove dss_debug variable"
>=20
> All your comments and suggestions are welcome.

This doesn't work quite correctly. The problem is in dss.h, where we
define DEBUG if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set. The thing is,
DEBUG should be defined before including the kernel headers where the
pr_debug etc are defined.

So if you try the patches without dynamic debugging enabled, you won't
get any debug outputs at all, even if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is
set.

And for dynamic debug, the Kconfig help says:

If a source file is compiled with DEBUG flag set, any      =20
pr_debug() calls in it are enabled by default, but can be  =20
disabled at runtime as below.  Note that DEBUG flag is     =20
turned on by many CONFIG_*DEBUG* options.                  =20

So if we have CONFIG_OMAP2_DSS_DEBUG_SUPPORT set, all the pr_debugs
should be enabled by default, which is not the case, again because DEBUG
is defined too late.

I think setting DEBUG in dss.h should be removed, and instead DEBUG
should be set in the makefile if CONFIG_OMAP2_DSS_DEBUG_SUPPORT is set.

 Tomi


--=-+UQZObn+EuSANdPe7Gbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYxFgAAoJEPo9qoy8lh71XgwQAKuUo4P1OXLiegYgoMkZ5cbd
VbCfGcKv9YCqiZD/ve+Q0qpedgTG49mCpDFubfVd505qI+cFgqd3f8Sr9EKu/lcD
bVGfOdXxBIGS6mf8iW+d3I+m0s/Z/JfZCGvyRp8XQ5am/X+3Wnhangm5+GVSqogw
qK9aMl1YljMBKVCIWeD509Oyi621tSfsWLFNEAEptuYU5X+tBW1/l4mLN1ZwasKU
QJ1B13BohE76A/xdUdUcf/o61t8MrWREJELV1Nl7r5Bg6sY8Ih8CRKL130PFjZ8H
f8eR+dMeLqVBSfTey7Klw/GY/uNTUcQfkFdKXRBpSNeb9DZlWgzKfHnZw5DE6Ln1
UhSbO5a7/L69QsZDZyihQFr5RcG+Add6hmpptU5hfmkws9db+dWP/DLE6tRglnh9
GHFJK4D5UmNo2z+iaYXtBnyCCHehiFy2aCHPcZzoOZpUMOSx0sWS4NdFQwlyExDX
WjlmQoqkZIdciA7eygO7BBxCvNzbUgd3oKP3BaSHFj/jcw7AqwoVmYT7CpG4VgSV
KGwsv1pqjBvIF+HtGRuz1j/H87reyIDsMwLGnapzItKs5L5deAyucAHG86A+P077
jeqYaGqc48aAnVzQE7eipw+tpMpoezzof5rkSWZEk/d1PzDjgXP6Cvcwb93FBKgN
pADi1KsefDGM3B29WVUB
=I0gt
-----END PGP SIGNATURE-----

--=-+UQZObn+EuSANdPe7Gbl--

