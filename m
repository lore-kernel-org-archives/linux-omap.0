From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Wed, 18 Dec 2013 09:35:45 -0600
Message-ID: <20131218153545.GA1593@saruman.home>
References: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab3LRPgb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 10:36:31 -0500
Content-Disposition: inline
In-Reply-To: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anaumann@ultratronik.de
Cc: notasas@gmail.com, linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 17, 2013 at 05:48:33PM +0100, anaumann@ultratronik.de wrote:
> From: Andreas Naumann <anaumann@ultratronik.de>
>=20
> This is a hard to reproduce problem which leads to non-functional
> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
> e25bec160158abe86c276d7d206264afc3646281, which introduces save/restore
> of OTG_INTERFSEL over suspend.
> Since the resume function is also called early in driver init, it uses a
> non-initialized value (which is 0 and a non-supported setting in DM37xx
> for INTERFSEL). Shortly after the correct value is set. Apparently this
> works most time, but not always.

yeah, but the problem is not on the glue layer. The bug is omap_device
and pm_runtime not agreeing on device's state. I suppose there was a fix
for that recently in linux-omap@vger mailing list.

--=20
balbi

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSscDQAAoJEIaOsuA1yqREfWoQAIh8aqHSN3PMvW3C2f8hKO5o
7HNOiXMfjvDcapscrLJ3BfNRX29mgXQh8cYQV/a0Gsy0XmiGms3ffD/4SDbd7enw
DO30Fq4MBpLrYfe5QBkImn69sKxfBc6aY8jHqeuA8OeNeJL+0wvopFIpQk1P8YJS
12qRFlHNOV2SzicTfHgOi6+cuABCOVENjvXGZIyDWoxzhxB4bgoQsnc2hXLMULV+
IAFGi+yk8NPJ4YKudDL8btq20AXm3kHb96P+1IStMh3BP4qFmj5OA4AJBWUs4nuE
gPV5SeB4AeDmJ2i8RRLw98xg0uBwrirBxxD8W/hT+7Qw1UwZjONwFFya0jyoT961
qChhb3DzHze4oMrlbMTDXa72IDzVIyn+GejtbAeBMtSJHF3FdKWLy7xZaGjpDQ0j
VAMHe4DiWjNgB8pzRTedUH+OyP2+jNfi+eWdXyjIQiszorfAS1Vi8/ZFW7kA+s37
m6RE9p7PCnj1JQMRABZ/GiQcKhckMLPa1B61/vk1K38LIu6GztS1XkfkC8UyEZDr
1KH29l31v5U4qtA71LnkS2NUxQz0WHkzPAi78BtQ3JqKUJiCmeUpYFAZzMOgaxq8
qS2YZLIEUjuFyoMac6daCJzbrqvP/+tDGIZSb7c4mEW2cdQ2v3UvqP+EWtmQ5llB
/ChYLDuqta2/Ug5R/rgi
=u5sT
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
