From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 03/21] ARM: tegra: skip gic_arch_extn setup if DT has
 a LIC node
Date: Thu, 8 Jan 2015 11:16:29 +0100
Message-ID: <20150108101628.GE1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-4-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-4-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 05:42:38PM +0000, Marc Zyngier wrote:
> If we detect that our DT has a LIC node, don't setup gic_arch_extn,
> and skip tegra_legacy_irq_syscore_init as well.
>=20
> This is only a temporary measure until that code is removed for good.
>=20
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c   | 11 +++++++++++
>  arch/arm/mach-tegra/tegra.c |  1 -
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> index 7f87a50..b37141d 100644
> --- a/arch/arm/mach-tegra/irq.c
> +++ b/arch/arm/mach-tegra/irq.c
> @@ -255,11 +255,21 @@ static void tegra114_gic_cpu_pm_registration(void)
>  static void tegra114_gic_cpu_pm_registration(void) { }
>  #endif
> =20
> +static const struct of_device_id tegra_ictlr_match[] __initconst =3D {
> +	{ .compatible =3D "nvidia,tegra-ictlr" },

Like I said elsewhere, I think this should be "nvidia,tegra20-ictlr" and
there should be another entry for "nvidia,tegra30-ictlr".

Otherwise looks good, so with that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrlj8AAoJEN0jrNd/PrOhb8MQAMHDTTj20AM/NDN5LUzrw4xB
ZRAUXiNgtcTlLKbX0z43Hw230GdjBael5TJv5U5cOYOCwJKmS97AP/4Sae6UM5fV
JM9du3jIYRFpVoIjtKvyleM4PnQWjS2HF0XYTns5SYt6zt2tXzgdxuAKr1o5g4Xo
3GaoxJQYdrEJ0ReWufD3w9D3tpGBXuAO1JfI8kBxAvvLAfe9rlcFJ9a1OvNPWvfS
uFttNfSsGDAFnoDhaCph6hnlOs3vMtgy6oresQ4k/NpmI+Juj4cH7js/3zozQK22
tlwpRjmM2I08sfFFqGTQqgUNGyjVY133mcLTfLXrPPLpjG2Wo0IhzJ0MMbJ3d+jb
tOBlGJ5zckTJGUL56Ef7hDqKoKFmhtwbpx5SAtNGD1MXGqBLQyWVlGEg6OuGon2l
6cEe7EaBDaqPEWFr50pmfM5Gh7CqM/I9uou3uwuzn5p+6Mc2t3qJj2ZT0JLqkPPi
+4Z8uiS2GOP+ky9+wm4evfPOlAyNX7V6BXOjf1lgFg6D/K6rCR2fNSaryDKaltDZ
e3f2E6omGFYzmoVg7zWSON8MVBGWDc6vfFe0x4t12MnuaGiaxsUDl+BvdFV8MluY
Tbc6HKAlYVVeLV30tPOUaoeEaEt84EQpMiSVarGjuZEVsztPSCERn6SNbrztgef/
BhYqxhA2pB4rFdLEazaG
=dmmp
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
