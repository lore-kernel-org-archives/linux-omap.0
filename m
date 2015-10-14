From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] hsi: omap_ssi_port: Prevent warning if cawake_gpio
 is not defined.
Date: Wed, 14 Oct 2015 13:40:15 +0200
Message-ID: <20151014114014.GD14340@earth>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444819456-26728-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Oct 14, 2015 at 01:44:15PM +0300, Roger Quadros wrote:
> The error handling path is broken as cawake_gpio was defined as
> unsigned integer causing the following warnings on boards that don't
> use SSI port and so don't have cawake_gpio defined. e.g. beagleboard C4.
>
> [...]

Thanks, I queued this one together with a

Fixes: b209e047bc743 ("HSI: Introduce OMAP SSI driver")

-- Sebastian

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHj8eAAoJENju1/PIO/qavHUP/23EJeckwo2fnIVx7o7jgL/n
VbLziSKIxeoKB7Aj3rkiFt3pPVtEEFYo68FbINwim+7wlQO5pvHxZD7ouwEQurBY
HnfzKfIPBj52FReqNIwIIs7/W2ycwl/1xe8A+u/KglHlh6dCze9+RjzeVOsrpH0K
FPZ7Luh8NZIjsOorXbXStw2cHOY2msL9SNAzExOI+7Pctl4gKY9CYiaiz74t4OkH
cqF/bUrYCONextZW9mCSE2dG17CaSKIGLMvtKw6lvE1ARg10gyOz+Ot0TNyE5gU8
kLe+xr5/SZTWbnbH+g+8M2j/EA2RtcOq0HLGTqf6tFTC3pA2kk/FLH/j/rZU0h8J
X/XW5rfANQfKPgRWzAXAT068wVDDSkVxFpgT5HXGYc4dSus+a218hPXozet2iFlq
WKIfWW52uzesV0Il0RiOynZTx5qwLpTojrTVWi9O1Ue4jSytg8CzuVLdd28dyEPK
Xv9sx8Bq953hQmOyUav9dg0QiX4HAH+yW46Gmucr3AkfPrOolq6QS7VXhy788KIf
RLJ9MKMNzA5mPCbQYDIJgHdvtj3+38e8E5Y2OCAC9Y4aOFUOCXmL77OOoczm/dSr
jmwtD1zirYgD6qFjVs+bO2dC6+CrJCtr9qN9LK5eN7b4wax3OoRw9FRv2n05sWwO
8AadBmHCmxrubO+b4qGu
=uKQ1
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
