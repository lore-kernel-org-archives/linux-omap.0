From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS build breakage
Date: Wed, 6 Feb 2013 11:42:38 +0200
Message-ID: <5112258E.50804@ti.com>
References: <20130205213853.GB3739@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DD9D06D22843A63A7F5E778"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3BFJmp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 04:42:45 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r169giFj031493
	for <linux-omap@vger.kernel.org>; Wed, 6 Feb 2013 03:42:44 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id r169gibT011186
	for <linux-omap@vger.kernel.org>; Wed, 6 Feb 2013 03:42:44 -0600
In-Reply-To: <20130205213853.GB3739@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--------------enig5DD9D06D22843A63A7F5E778
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-02-05 23:38, Felipe Balbi wrote:
> Hi Tomi,
>=20
> DSS doesn't build with allyesconfig:
>=20
> drivers/video/omap2/dss/dss.c: In function 'dss_calc_clock_div':
> drivers/video/omap2/dss/dss.c:572:20: error: 'CONFIG_OMAP2_DSS_MIN_FCK_=
PER_PCK' undeclared (first use in this function)
> drivers/video/omap2/dss/dss.c:572:20: note: each undeclared identifier =
is reported only once for each function it appears in
> make[4]: *** [drivers/video/omap2/dss/dss.o] Error 1
>=20
> Found when debugging another problem reported by Arnd.

Thanks for reporting. It looks like omapdrm and omap_vout use "select"
to enable omapdss, instead of depending on omapdss. This causes omapdss
to be enabled in the config, even if the omapdss Kconfig dependencies
don't allow this.

 Tomi



--------------enig5DD9D06D22843A63A7F5E778
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJREiWSAAoJEPo9qoy8lh71gOgP/RzGO691AqhT+J687PID6nJX
Eoc7b06uLTmlZWIc98DV8YXJE9WkT2Vqu7Pna/T+a96W3Q8iyIogXIWXGP4C2bsQ
gxQlxiD94yIq0lbQh+1vOAKQtw72oSyhJv7B/tOFgSIHlmkyXYMxMJUldi13R9C3
Gl/iTH1KXoCpMkF5F0vBmPEo0T1v0tPCf85QprYWILZeATj0Y/NlS3VqC2ntJsRM
utVIcTwMo40PtS7lsBmst/a05DTDNVAVgeolsnuKqk0NyFbqmGhccFcINJHrj8ry
OdP7wCBpSzJE6FnijFL31rwXjro/otD/SOoNlFpxtRHFzRBi0rz0IW1g8VcUIiKK
4w0hpTBBGW+8AogKUwk8/dy4El1BjfEbiwgM9xOZAAZ6qmaiREV4t6K8qIq/t6Xo
IT0o8B01QwMI6LRmfLqjz3djywq7Bmui4W6jqGolN6/jv3ZNaLiGoizcmXM2E3nS
rP4K4ZGq+TrY1olNb2LDAjB/2K2o3U4moay30FxWcdJznNpRToFxsbFpJn0RKSQZ
SK4M2yEBrTEPb3Vor1DQ74e4UsBOBrMhkK2RIvJz/r6HkjABeMkdcHkG+WetD5S7
l8WmLgmTgevUkyNKoRIaQpTB6UYKedq85DkFZfHK3z376/E7wd8Qn0AtoCLU8Gun
VZObHiWtLkIladnC48gm
=n7nm
-----END PGP SIGNATURE-----

--------------enig5DD9D06D22843A63A7F5E778--
