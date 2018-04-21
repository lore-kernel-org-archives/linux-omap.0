From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Sat, 21 Apr 2018 18:23:33 +0200
Message-ID: <20180421162333.d4jtidmbxrx76k4x@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etezdywpoq6lir6p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--etezdywpoq6lir6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michal,

Thanks for the reviews!

> There are two more occurences in this gpio-zynq driver.
> zynq_gpio_resume, zynq_gpio_suspend. It wasn't detected because these
> two lines are not together. But the same change can be applied for them too.

Not really. The rule would have matched if there was just "something"
inbetween. It did not match because the "something" involves the
variable 'pdev', so we can't remove it. And just changing towards
'dev_get_drvdata' and keeping 'pdev' was not worth the hazzle in my
book. Especially since I think the code should probably get refactored.
Calling platform_get_irq() in suspend/resume paths in order to get the
irq_data looks a little expensive to me, but I haven't tested it.

Best wishes,

   Wolfram

PS: Please quote only relevant parts of the message, it is a lot easier
to find comments then IMO.


--etezdywpoq6lir6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrbZYAACgkQFA3kzBSg
Kbbs9Q/8CL8LUkArsY2fuzYW2Su/J3zMzkR+T15UyicBY0On6vsRRNvm74+Ll0Ot
RL2LKMT8vTDuX1/rxX4hkeVNyMe+YCvl2zSTYjBMBGhP3nKbw0RZ9T6oQrPYlFlS
G7H0ye0KDb7Kv1YsoDzoTtMAJHezvGslA3Jh4mWnkQWjPhzLJAIpCCD7sQyGmNq8
kMofA51jGYZtoPNlvIli1focrJ73x4Ws5zj+GVhVQdEGdsBHRzPK4RGavxFMeH0u
fJ1FcqusTkuDWCnf2XTorFHUqk4/4RSrdiV5J8vrgdiB76Q8iztNg8mBR5vG0J7t
NEG1aO4P2yNbFBrIgh/1MgihVIRyTkEuZuEFgPcoDslK8YYMOHvN9AjEHJsD6TsX
Fp3EQVBD/dMgIKQZc9jIzKZvO6vd7yW1i5iQDmECUbpt0PnQhr8YnDArdEfwFDF5
DKk5PZKAiOCwi4Kqfcwpr9mhUOln96atjcIPBxC0nBh3leyGwE3qRQjWw+IDB9v3
5Q8sle2qEa4jfkPk5FQ9kCtOh9/MbWgxZrrPFZwzQUAJgAfcDbgAacLSpNYfaCnj
sj6Ds5eKt19K2tg/Mg5DLDflzYMwz5ET4TmKHrX+ihi7pzxerVUeEiwiXdo5/62o
8ywmeyKdIhROHZ1b5GbhnafbZQgPm+p0RQGNp1FMePpg7Xa5Ef8=
=uQyw
-----END PGP SIGNATURE-----

--etezdywpoq6lir6p--
