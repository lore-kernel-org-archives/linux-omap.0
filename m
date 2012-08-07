From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3] i2c: omap: switch over to autosuspend API
Date: Tue, 7 Aug 2012 15:38:05 +0300
Message-ID: <20120807123803.GB8468@arwen.pp.htv.fi>
References: <1344343036-8832-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T0u6oYl84yPn00Od"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33915 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754489Ab2HGMll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 08:41:41 -0400
Received: by lbbgm13 with SMTP id gm13so1019212lbb.4
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 05:41:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344343036-8832-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, vaibhav.bedia@ti.com


--T0u6oYl84yPn00Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 03:37:16PM +0300, Felipe Balbi wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ignore this one. sorry

--=20
balbi

--T0u6oYl84yPn00Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIQwrAAoJEIaOsuA1yqREvQQP/iPK0tTWHmooOfbx/Z2AwuEQ
csPknda358OnL+IOcG8Q3qxX25EGwz5zDJi6eBIFn5hxHXZevQG3ZaWwDbIGLd+/
exBJSMS+e1Uz3rlkcYabDVbH1la8sPwgMz//GDE7++SLKlgtBOZDKZUaD1KJs5lB
/v9uheK7TQQaVREOd5rZdZJ/SaW39AHRLLETMwS+ckg+AS4p2vnd9028zVJGB0gL
HGL45idfFxJyZS4S16m7FVe8BUvArr19t0lhL4xgecHuPGzOh6EQILBN1WrrWJ0d
v7K5PZ8K+jHt1APwcfuMga2H5C4vbuPGKKSVjeRsKhUvx8qA6hldoc6mHij4kV7C
DyGqbw53n2etjHxU+cTW6QAPacKwvxYlYv6H7jPYd9ZflWVVo8nsosB2jYzQLygh
mJPIzhyM8vC3WAHAN3esKUTrR/KUjY7HnhBESECiBuC3nXx+nAxa9XXF2qRXnqeN
y8BkDOky0kZFNoWbJSyictv+K10F58rpQaRH9yN3nPiCfDCTRnNXHbntZlusLwtt
LVD4WM5MK7BsTlGQuOvpdoE23OZwqJjLqDwvnoRheSNbL0v9PZQ1S2i/4nEnAFXT
h9cdp8CDRItjTN1hLUqaTBvr+JXR4WyKNp5tdHpG5BDqYJK2zN+tlt98CWIt0MnJ
ctEUmgM/m7jcbh01jWLn
=92GM
-----END PGP SIGNATURE-----

--T0u6oYl84yPn00Od--
