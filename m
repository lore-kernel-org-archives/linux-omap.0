From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 10 Mar 2014 09:45:44 +0000
Message-ID: <20140310094544.GM28112@sirena.org.uk>
References: <cover.1394440470.git.jsarha@ti.com>
 <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
 <531D885C.5010104@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XNnk+1bw058nV8qh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51220 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaCJJpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 05:45:52 -0400
Content-Disposition: inline
In-Reply-To: <531D885C.5010104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--XNnk+1bw058nV8qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 03:09:40PM +0530, Lokesh Vutla wrote:
> Hi Jyri,
>=20
> Just a few minor comments...
> On Monday 10 March 2014 02:22 PM, Jyri Sarha wrote:
> > This commit adds a bare bones driver support for TLV320AIC31XX family
> > audio codecs. The driver adds basic stereo playback trough headphone
> > and speaker outputs and mono capture trough microphone inputs.

You've quoted the entire mail here but added only (as far as I can tell)
three lines of content - don't do that, it makes it harder to find what
you've added to the mail.  Instead delete context that you're not
replying to from the mail.

--XNnk+1bw058nV8qh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHYnEAAoJELSic+t+oim93lQP/17Zwcu64J9tbqC2bmtWpN66
nyxuT/3JWagvh7O3KbUwcuxsAMeJGyX9kisx5b5o4Mn16oPUXtwtjklLuYqywFBW
77h3m2PODLux6kAY1UdFRBKmv6ZLhL0uFqUJwggEnsrKlJx6imh7P3TcGBM63kMN
4zXqWBq+/PDR1oNurJ/unG/FkYI3Jc+q3b1V24CTW6JZ7rEMIvI3GFyObY9x4vtp
jxPA3sc1mWj78+MkkCBFPX+v9FICQHBYJfIC2MUmYlzIj0inVLHkZPFhoDdcryGT
SJ1MJAJRpgHEHR0vUGttdUrs5Lq/sZTh2uX3cp9Ehw/SdR5VerxJcIgYrxWdpoHE
/pm9+RSJh7hhT7DWaOKZgN3tCAAkzORh9sZqa/XXuwgdGqqmUr1NclcFs5+PAjMJ
ZaJZHWV/GU/2IOtGsMt/QmhYOH7vOkGhFQEwPwnsGNK3AzYT/uIzuleFQy+BWW0g
FL5a4mysfMJWgyno+ms7s3eMURMlajmM1MnNO4rgOPJ3Ixh05i75QM61hlt3EdLZ
wUYtw8zFGgncFlz5bo8ymcUJwVtS2eJXhxUK/EKhWr5rD2LMB9jVJGDXle2NwMFp
jBvtA1baFfn9e4e2NK0AlCAir/U5XmsU4VaMxqdIH+It07Ykjd5NR6lZgYGWJyYp
jIme2CAqbXg838jDO6cj
=FEmz
-----END PGP SIGNATURE-----

--XNnk+1bw058nV8qh--
