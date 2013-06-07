From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] i2c: omap: handle all irqs befor unblocking
 omap_i2c_xfer_msg()
Date: Fri, 7 Jun 2013 22:05:43 +0300
Message-ID: <20130607190543.GD15295@arwen.pp.htv.fi>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
 <1370630768-4077-4-git-send-email-grygorii.strashko@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370630768-4077-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2013 at 09:46:06PM +0300, Grygorii Strashko wrote:
> ARDY|NACK and ARDY|AL are set together in OMAP_I2C_STAT_REG, which will be

Have you seen that happen ever ? AL is Arbitration Lost, we never put
OMAP in a multi-master environment before.

ARDY | NACK I also find it a bit hard for those two to happen together
since ARDY will be set when you can change controller's register
*again*, mening that a transfer has completed.

Also, we need to follow what the programming model says. And, I don't
have docs with me right now, but IIRC it tells us to bail out if any of
the error conditions are met.

--=20
balbi

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRsi8HAAoJEIaOsuA1yqRELAgP/joYRVxoz4XuBODyelCVUVIG
dw9OOtolUyaBhLUgDybfvvl9C1QDvb6bRB2m5sn1WpNBYUe7HTyc7rfr6X5ka7Wh
xUSeUP3LMqV3gJKt7yhMPJXvj2TeLfKH+6HSSh3RFu0lvvimPZ+o7CTeMTEXJCYo
XghUGa8mvoRPxqpOdazeWfvhbOXibzhYGIMZK9CxV1lEW/NKMp/QhuX+QSku4zZ2
N0zTO0tcSbdleQYtNdkdiVxNuAbS7Oimlfj9cSUkY2V+Tknw6dRA085LtEKvBtv2
BYxc0zOdTf4n+KTDgzEeWHWXo8GaiohwSe0SSptmXjLcaMlguX1blyXBTYgDnJg5
cqlMBppMWZkLHZvXU8fYdn0SMXyftrzvadQ7GyjQoTTeFWSY3yKAjEGsbS0HG6l8
ZVvLUhpkUtaLXns5DKbnd3LXEvpeADkzz2GKX1r3l+i7ZlQMO/woeEMtig5SLh/K
+7tR717CoPz3Cr9QmAffK4JysFPPNLDjUcN1gy3oJrmd53rp77XCOA/AwgHvU7J9
SXyxj6r8Tv4fU0Kz6HAqNiB5g/Y5xKZq7Rz99uHL5TkgRMvgcBNNzD/gDO7a5UYe
ptQxaSbQMDYlSN7Q3IajYBcq14g1fdD6tyZ82hDn0Q6ZY1NNThigXGRZQobGHNJe
Kd2PpvRVxGesarmCARDP
=zHoN
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
