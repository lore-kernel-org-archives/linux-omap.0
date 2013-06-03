From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 15:16:49 +0300
Message-ID: <51AC8931.8050808@ti.com>
References: <20130602165019.655da2eb@notabene.brown> <CAGGh5h0ZsY0J4o6TbMDjD+kOs94SqkFv4gxEhQLgiX9ihdYnPA@mail.gmail.com> <20130603212050.5a28fad6@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2EBGOLWNJVHJMFOTIXQCF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46490 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757164Ab3FCMRA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 08:17:00 -0400
In-Reply-To: <20130603212050.5a28fad6@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: jean-philippe francois <jp.francois@cynove.com>, linux-omap <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

------enig2EBGOLWNJVHJMFOTIXQCF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/13 14:20, NeilBrown wrote:

> Panel isn't 100% yet - sometimes uniform white again after resume from
> suspend, and I see
>=20
> [  202.881500] omapdss APPLY error: cannot set timings for lcd: manager=
 needs to be disabled
> [  202.881530] omapdss APPLY error: cannot apply lcd config for lcd: ma=
nager needs to be disabled
>=20
> which I don't think I saw before, but I'm happy to track that down myse=
lf

One quite recent change was that omapdss only allows changing output
config, including video timings, when the output is disabled. Changing
timings when output is enabled did not work very reliably even before,
but now omapdss makes sure it's not done. There may be a bug somewhere
related to that.

You only see those when resuming?

 Tomi



------enig2EBGOLWNJVHJMFOTIXQCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrIkxAAoJEPo9qoy8lh714ucP/2SXFAczG66g+j7r+Ij9pweP
2VKfsI7PSnOkzItitmE4LTSneKMicDCbZg7R18El8HC4VcW6yIaL4X3NzpKJRyb5
4PPd8FM2lTkf+wdhSeo61g+eVbHrnGj3R49/b10hs862TRLpUqMFgtsk3tOuhFPt
Rxhftt3khC92ZjL7Dwnr+9+jMRTMKEzw2PvgoCXTRaxVPoSg1NkxeJHjwEHsKQ/1
owpfv4kM68u2l0KknaXnP5m3WS3J5kjQDA6FF3eMZ3/EelyoC4s7NcGNAjT8Tjy/
BOpROf3GRolboTl4yqfxHrcz6+2vEpSyMBz987HAblS0YaB/guSXBO7sZ8/SRWhy
wlvo9/UzgbBIKFXc/SaRaD87UB13EN/tw6Y5pYE40GtipbpOyAD1SH193Mdkao7Q
1T7Y87G274ZjL4AldMbBjUUJIWk51SSv5ufS1MxGCRprpKezwILdMxcyEb1Jb9tW
JaIXvVwLk3Elxoedjjv5QaTJHpr/DXwBM136eGj8b0c7uRB3zkcg54DLGIwBCOc6
Au+YWHAyfOEtZpqh4Ak820NenFAM7fWDGOVFo9tUYTPDk4K8gZQQ4Lz1Pxn+3Uvj
g9gO2u0JtbKS4TGwT+j1QJsbiJSL0iN9FpSnGDutnSksf4w5sfeENsE3huxwEleQ
adIbWryRiN0/QaSHbw19
=HKOJ
-----END PGP SIGNATURE-----

------enig2EBGOLWNJVHJMFOTIXQCF--
