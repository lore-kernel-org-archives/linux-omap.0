From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/15] ARM: tegra: Correct interrupt type for ARM TWD
Date: Tue, 5 Apr 2016 16:04:17 +0200
Message-ID: <20160405140417.GB28814@ulmo.ba.sec>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458224359-32665-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 02:19:05PM +0000, Jon Hunter wrote:
> The ARM TWD interrupt is a private peripheral interrupt (PPI) and per
> the ARM GIC documentation, whether the type for PPIs can be set is
> IMPLEMENTATION DEFINED. For Tegra20/30 devices the PPI type cannot be
> set and so when we attempt to set the type for the ARM TWD interrupt it
> fails. This has done unnoticed because it fails silently and because we
> cannot re-configure the type it has had no impact. Nevertheless fix the
> type for the TWD interrupt so that it matches the hardware configuration.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> ---
> Ideally, we would not be attempting to set the type for an interrupt
> where it cannot be programmed but this would require changes to the
> device-tree bindings for the GIC. This series adds a WARNING to catch
> any of these silent failures.
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 2 +-
>  arch/arm/boot/dts/tegra30.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXA8XhAAoJEN0jrNd/PrOhmSIP/RpZIhUQLSn6Taxbhlrp3/qe
UYoyMSNefCJo7iuP6fXp2DDYZ24bjwJLcqrZ6KVy8y8QKzQ2KLGjdJUk7pp4w5Ar
fbGGLFVwNjnogxtXWp8rknJ7f49FqQLvZShvXJGsBDsBatyDF8fjuyqofzEaLXZj
hZFMrWHDVSFYili3iNE2t0zu4zbLzv5SXgJn4PO98hhSY9FMe6MDh4qUGNbLf/qQ
J92oJgetHx0cFf57G+BL6AGjwhaiaeSF1VwwOqz7P8sez+6X97FIaRUVud9lTB19
75cEK1mEAvmFxNB7gD3jz/x0SJ+iYkPwzsRq5t+ZRPQf8AK1ACQXVl0Il6kqb9l+
ndeE0PuFSOrykj5hzHD5+kI1ZBZun5Xil3jmXH1cdVscLpSDz9WJjWD6wLVcchXE
dtjAQ8JQJHBNC92KQCzKUGF8PsaWPm5bxbflpattNvgprdPdemmURDrRE/Ajm7Zq
7xUMcrSJwSwiH7dryYGunFLnHJ39OE01Sv+abPQ/3djctHB7OrIAl23WrDfscdzt
j8FtlwvvoTjaxi40WRY6jhNoR9Ln7Hx6B5XVJQWg7KBqtefFBsVj9scRfTnQeUNX
dhC3FeKKixsY359oEqxR6/sm8EQJnToSOVdQr2rkY+cNU2CpzN/ArCKIreNvlpkN
Gx0Eky2xdyfuSGfverPJ
=UF16
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
