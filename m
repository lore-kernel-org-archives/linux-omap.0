From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-tipwmss: Remove all pm_runtime gets and puts
 from the driver
Date: Mon, 5 Sep 2016 08:51:09 +0200
Message-ID: <20160905065109.GE3532@ulmo.ba.sec>
References: <20160808100915.30149-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160808100915.30149-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 08, 2016 at 03:39:15PM +0530, Vignesh R wrote:
> From: Jyri Sarha <jsarha@ti.com>
>=20
> Remove all pm_runtime gets and puts, and dummy pm_ops, from the
> pwm-tipwmss driver as there is no direct hardware access. The runtime PM
> needs to be enabled, so that the runtime PM framework takes care of
> enabling/disabling of PWMSS clock when submodules of PWMSS (ECAP or
> EHRPWM) call pm_runtime APIs. With this change PWMSS clock goes to
> idle when none of the submodules are in use.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pwm/pwm-tipwmss.c | 19 -------------------
>  1 file changed, 19 deletions(-)

Applied, with a slightly modified commit message.

Thanks,
Thierry

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzRXdAAoJEN0jrNd/PrOh5pIP/A2HAy2srZRO/Q+nsChB2nyp
ciWfGBXXdh2Y6swndxGM42wTfjhdoJGkmCCReH/cIUgghSLIaZNu0C6oh1zRwMoz
2QHAlmj+ig/z/eRHrbLGzo4H6BPzpQCt/z99FTb93dOdW/ElXDFy0q82zbTJUqPV
HvG3prxl3pYYvVuv3k2/8Nb/mgB/LkTRNVmlXd7Oska1nwAHjxyySpen8QGiITQm
4B8RPyoDBNknpadqIc0jmJMdFdlvg+oR3FGN6oYAm/IPCOl5WmZY98s7Z1BSrZg0
qP6rQHNbBGj0AJUhJDoxYeeXqPWIy7k5NsrP6sFWF81FnYL8PhkwF8d1JOImNlxq
ZXjJqRJkwUUyK7yRQiZXgFFVI3KYV2eQO76k2eIQwpSB4nH2MESd2Jl5jNrfH+AZ
9R80Q4CTg0Gf0PLn9Hfwbuqm7juJXAFR/ntYnDA4CgGQW4AXHqyd5m2JGCVLgqtl
tctGLIY98ROkn0yq5VIYZODUoZRO0vaXhhP32ISQAec7Bs0PObqTl0XviL/160M9
gI6J6Yu75uwT3Y/v6QDA4IkZppsPIgLsR9np2cq9lJhYXFN7Kjj0tbxWwy2+jP3E
YjbX7MJPJfrxptNaiJaGl440A0w5LlmHxbASSRnL3zNMq+8sm0Z7kUSswwyVT1ZD
/98OZQxnja28nqD9sB2g
=Sg+8
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
