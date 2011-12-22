From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP3: hwmod_data: add HWMOD_INIT_NO_RESET flag for
 dss_dispc
Date: Thu, 22 Dec 2011 12:13:05 +0200
Message-ID: <1324548785.13282.10.camel@deskari>
References: <1324515653-17287-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MTg020uw+BmRkZfEL11F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58437 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752029Ab1LVKNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 05:13:10 -0500
Received: by lami14 with SMTP id i14so4676244lam.34
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 02:13:07 -0800 (PST)
In-Reply-To: <1324515653-17287-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Paul Walmsley <paul@pwsan.com>


--=-MTg020uw+BmRkZfEL11F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-12-22 at 02:00 +0100, Ilya Yanok wrote:
> Resetting DISPC when a DISPC output is enabled causes the DSS to go into
> an inconsistent state.
>=20
> commit b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
> Author: Archit Taneja <archit@ti.com>
> Date:   Thu Oct 6 18:04:08 2011 -0600
>=20
>     ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is
> enabled in bootloader
>=20
> tries to deal with this problem by checking if display is enabled and
> disabling it before doing reset.
>=20
> But in my setup dss_dispc is resetted from omap_hwmod_setup_all function
> _before_ calling omap_dss_reset. So when dispc_disable_outputs is
> executed dispc is already reset and nothing happens.

Hmm, why is that? You don't have the dss hwmod before dispc in the list
of hwmods? The code presumes that dss hwmod is handled first.

> This patch and HWMOD_INIT_NO_RESET flags to dss_dispc hwmod thus leaving
> DISPC untouched so that omap_dss_reset can take care of it.

omap_dss_reset() doesn't reset dispc, so this will leave dispc
un-reseted.

The idea of the current code is to do the reset similarly on all OMAPs.
The sequence should be:

- omap_dss_reset(), which disables dispc outputs and manually resets dss
registers.
- then the rest of the dss modules reset themselves normally, using the
softreset bit.

Your patch would break that.

 Tomi


--=-MTg020uw+BmRkZfEL11F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO8wKxAAoJEPo9qoy8lh71YmoP/3r3lrX1IkHX1PRitBp08+Sh
DUlTRB5hg0cQIpci6oaSFXlSoGJitbxPsyl3zRhR8KMv2+14I7a5woRndLf29TpO
u1tJWSEw7P0JdVPk7K6BLGmBgrmxx1XSKUK8ObEIaettFV29XZeJcJFIQxPfko6z
UnNtfzs5yI3Xwyycn+2n5zAv1xfTKw9gR3PKy8tPsivkOzPOR+nDZqAMMMMwr6L9
7wqrfEOWCPcrZ0wHf3S2V/GYWjKg7wJuK967NfyHsDNLTfxR9YAc5bR+nyRUXCIi
8TXT1UDRZMkvUM+I3xu/XD4bimcP1k/7amRYTuafy86Y3KtkCcPhDDCv11Pb65L/
96np9dYWFqEf+tMcxt7tE0m7ZeWgBpsmxAKZw4hD82201dZQH5dxYXckhgFvjkUC
zkDYHva4yQ+/rWBd+nYAK8rtr8QjcP0GQElDJAUJn+leRuEEvCHtTsQ2F84lnFB2
wUChaLnpAgAFw14pVt0bYA4Czu2g9WwujMo+L6nlge5qIViNgKnKIlpVyXuqZF5m
fRCguF0IvEEAO9RImJCqKnpjEnULlLASMRKop6D7k9Ain08SPCnUsiS0YRnXUUoJ
N6sz9Si9eJE1/oUHZJE7SnwMGpBUVPzV5OcdjzEdGNv2SF3aKa/WX1iGVxl+z4p7
j5zZbrGfBjEsZ/cNSN6G
=1CB4
-----END PGP SIGNATURE-----

--=-MTg020uw+BmRkZfEL11F--

