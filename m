From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv10 1/7] I2C: OMAP: I2C register restore only if context
 is lost
Date: Mon, 25 Jun 2012 15:30:01 +0300
Message-ID: <20120625123000.GB30463@arwen.pp.htv.fi>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39654 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756228Ab2FYMcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 08:32:24 -0400
Received: by lboj14 with SMTP id j14so7396856lbo.35
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 05:32:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Kevin Hilman <khilman@ti.com>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2012 at 04:41:36PM +0530, Shubhrajyoti D wrote:
>  Currently i2c register restore is done always.
>  Adding conditional restore.
>  The i2c register restore is done only if the context is lost
>  or in case of error to be on the safe side.
>=20
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

how will this ever work with DT ? I say we get rid of the OMAP-specific
API and build this "context lost" status directly on dev_pm_info and
have something like pm_runtime_lost_context() or something with pm QoS
tell you if a device has lost its context.

Also, your commit log doesn't really state any problems you might have
reached before, or any improvements wrt latency coming out of suspend
and so on.

IMHO, drivers need a generic way to differentiate if they're resuming
=66rom OFF or RET, otherwise we will end up with a bunch of OMAP-specific
hackery on all drivers

--=20
balbi

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6FnIAAoJEIaOsuA1yqREYJUQAK517FVu8D225pG+CNf3S02R
DDsF9yJidFvfOmjiJj7MeicudC7KUpxSvFt5uYuxuVmjGcrWRLzlXW9oTgBDhSMd
ViFkmWYOZGRIZQMqWcX9WateyYlE+4FShduVXoVQ1TzNOdcP+iVG/OaquhI1HD/X
NY4oEKrIQYYTrAGPbB29bg45zCqz0y64pEKn9cAVkkq9hXPwNX/Fxub1qMoo7WBg
XhVWa6kMXHB/g6DzLsZy/kwoAxz8bNcOUUxug7zdXXVstGl9tPyjYeeWrYWiIR2E
IppYD/r4TvIwuq8vN8KU31MoOra7YAtOsr5i7frhch3IfgbKRDL/yaCgFJ5sAq48
dMQajJfrtdo2rN/i+NGBGlKxzTj5TPWLZIx/mHn8s761UBgxAzlU1EFJGK+AosSS
RX/3XAcrp/P2qhQCt1jRoXFf+f2PKx5dcNdK1FN4+dqGIl5wmBS4rGlSghHbCcvG
YXgSb7SKzwOZwCmy10YRCKYDIqJwG9B06mJl7eIzFHAyyDiUiu0eZucM2zVq4DZt
cvbvnY3FJKBxJww0J7HW9VOZxpM0X4zfVNoAB1Ju5vlMqOja6JdEvyG+BCwh3JCX
N6oR6Roz9uk2AZ9lhKeMPWDVVEnAP1pJV4qh4M6vGULy2qt4HEtIJc+wbu7NLIIx
7bBV0X5x9FtHgjv6kyy1
=n/o1
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
