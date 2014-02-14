From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 7/8] ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
Date: Fri, 14 Feb 2014 16:01:48 +0200
Message-ID: <52FE21CC.1010200@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com> <52FE2020.2010601@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="sRUf6QcpNNtwLHKdnE6PkFcvkm8ub61QT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33848 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbaBNOCU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Feb 2014 09:02:20 -0500
In-Reply-To: <52FE2020.2010601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--sRUf6QcpNNtwLHKdnE6PkFcvkm8ub61QT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/02/14 15:54, Tero Kristo wrote:
> On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
>> Set 'ti,set-rate-parent' property for clocks in the dpll4_m4 clock
>> path, which is used for DSS functional clock. This fixes DSS driver's
>> clock rate configuration, which needs the rate to be propagated proper=
ly
>> to the divider node (dpll4_m4_ck).
>=20
>=20
> ... squash to #6?

I got no problem with that, but I think it's cleaner to separate these
two things. #6 converts the clock to use a different driver, and by
having these separate, it's easier to see that #6 converts the node 1:1
without other functional change.

 Tomi



--sRUf6QcpNNtwLHKdnE6PkFcvkm8ub61QT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/iHMAAoJEPo9qoy8lh71jXAP/2rMZhbbjiJ/bLkifq3kxxZx
3Qj2idVIX7S3B8zPTURhyzgdwLx5fb5LisLLxoUJ+zqk78xiehwmcJPri2AYlKtz
IPkddR91LcZHOL+iRlQg5DiJi3JzNK2egMbX1ze1A01XqXQmvgn2bD5R5hEesFkz
bdsnujT3T5U61s+ICabT0NunPA/ezCMDUAq8b3WNNdKGKvDuvdrS41GKI1hGM9N9
e3v2EX7q811mx1W81uXWDcdvROtW61uZ04YBn7qil5et4m6kDLc6nvKw4G04kLPX
UHyLWGz7aFq9NPu/MLE8VFg2Wx3OcDplkfOk1z6tn3nCFo6/vdBYyZYZnySIvlc1
zZHgGSpqBXyLt6SwVzi43iIuVaYGd1HUjDu9Ofygg+k0zaZC62oM7tQ9NpOao2LE
YIuO0MSVFkdzQS21PYBjz6c9g6E37rMRu+9K59r0/s5TITuoeoclvCS+XQkl3Wge
uofkL9W4qOEC4zJfizpGfC3NMiF/mkRMrLna4AcrJedi8Bi2XELB0+ivGLlf04Oh
MUsIy89dTHjw7e2jnfAMPPNnVBDc8Y7CtH8lGOWEgqxETfqlmvT+rvOeXYFkJ7Xw
6FTjkYHlLjNedjcrjRioFYpfQomp9HrDGQc/27TDdcl/Ze+QWGkwS0bu1wIN+Muo
f09PHUt9PtmOCefihJtd
=kRX8
-----END PGP SIGNATURE-----

--sRUf6QcpNNtwLHKdnE6PkFcvkm8ub61QT--
