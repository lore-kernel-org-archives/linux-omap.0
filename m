From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH v3] clk/ti/adpll: allocate room for terminating null
Date: Fri, 8 Nov 2019 21:17:54 +0100
Message-ID: <20191108211754.430d4c52@heffalump.sk2.org>
References: <20191019155441.2b1b349f@heffalump.sk2.org>
        <20191019140634.15596-1-steve@sk2.org>
        <20191108170026.55DA52178F@mail.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/urfJBMy9eUwjFd6M5Ta2c=G"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108170026.55DA52178F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Nov 2019 09:00:25 -0800, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Stephen Kitt (2019-10-19 07:06:34)
> > The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> > terminating null. This patch switches to devm_kasprintf to avoid
> > overflowing.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > --- =20
>=20
> Please don't send as replies to existing threads. It screws up my
> tooling and makes it more manual to apply the patch. I guess I'll have
> to go fix my scripts to ignore certain emails.

My bad, sorry about that, I misread the In-Reply-To section of
submitting-patches :-(.

Regards,

Stephen

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl3FzXIACgkQgNMC9Yht
g5yOAhAAnGdI2emqN4a/GrokLIb57cKV63Y80R0avBz7ROKWLNIDr4LaZ9cB64Yw
7cZCVIuMbrQHY/nPkVMZEi9Ay3d/BwxDeNOEpstOd5sgPcw89uJbQ7q/+INR6lt7
REXx/NP4DTgkL+XIymdUPY0D5W7NvszWJy5XRE/UKCQZB/aPxolR+rFH23+wESdg
P0NfyarVlcSfdjBBh5f+/BzWTpYvokzQEbq1CrIMgHKZrXKy4+Up7uXyiMNrlXUG
uBcc1XrJFH80f/tRcldSsoaNBjnqtBljCfoXstvpEMs/sG6NCvOcxPH/fHfu4JLi
9B0/C32B4vOdIzL+yHdXFBYZHq33eRjc3j9+Yj7gGKpRqHji3sDL+XDjbSvZxbf9
adQ40ZQJvj/e1VDmjqT18pl8RSZnVGqGzXvVQ5WVkKvdIsHEHSlYKHmqmRwvwIMT
jD5B2zH8lkKQwQMMT0URBSVw9uKyE0QzOWfIKvO+ZpDuE+LptBl7G5KGT0019oh3
3pGYYype7J5XIs5dF0I7xVTsogwFR7X/fMK2N7yLefJbthPo1bbCx4akl5kIaXG7
/aVU0RcZzX9ta5dJ6sE+KlWP9OaRo2MoTQmSfxfnWgLP9Bk99UgltFQk+FILXiHG
+1JRD4bnI5BKUmshBpJ9Rk9h7QTYrJBmn6ed7FRxlwP0piEkFgQ=
=ZIn8
-----END PGP SIGNATURE-----

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G--
