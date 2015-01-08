From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 05/21] DT: tegra: add binding for the legacy interrupt
 controller
Date: Thu, 8 Jan 2015 11:51:34 +0100
Message-ID: <20150108105133.GG1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 05:42:40PM +0000, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../interrupt-controller/nvidia,tegra-ictlr.txt    | 39 ++++++++++++++++=
++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/nvidia,tegra-ictlr.txt
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidi=
a,tegra-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/=
nvidia,tegra-ictlr.txt
> new file mode 100644
> index 0000000..44fd873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra=
-ictlr.txt
> @@ -0,0 +1,39 @@
> +NVIDIA Legacy Interrupt Controller
> +
> +All Tegra SoCs contain a legacy interrupt controller that routes
> +interrupts to the GIC, and also serves as a wakeup source. It is also
> +refered to as "ictlr", hence the name of the binding.
> +
> +The HW block exposes a number of frames, each implementing a set of 32
> +interrupts.

I don't think I've ever seen them referred to as "frames". They are
technically separate instances of the same controller. Maybe:

	"The HW block exposes a number of controllers, ..."

?

> +
> +Reguired properties:
> +
> +- compatible : should contain at least "nvidia,tegra-ictlr".

As previously discussed I think this should be something along the lines
of:

	should be one of:
	- "nvidia,tegra20-ictlr"
	- "nvidia,tegra30-ictlr"

Or similar. In the past, we've used "nvidia,tegra<chip>-foo" to wildcard
the compatible string so that we don't have to modify the documentation
for every new chip. The above has the disadvantage that it omits that we
should always provide a most specific compatible string, too, so maybe
something like the following would be even better:

	should be: "nvidia,tegra<chip>-ictlr". The LIC on subsequent
	SoCs remained backwards-compatible with Tegra30, so on Tegra
	generations later than Tegra30 the compatible value should
	include "nvidia,tegra30-ictlr".

> +- reg : Specifies base physical address and size of the registers.
> +  Each frame must be described separately.

"Each controller must be described separately."? Also maybe mention that
this Tegra20 has 4 of them, whereas Tegra30 and later have 5? That way
people will know how many entries are required.

Thierry

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrmE1AAoJEN0jrNd/PrOhGmEQAJPETy7c1GIS+hwL1N0iKaP4
YSNcKzLd7grrmbOgO/x+FhDiwPR/7+rJeiWBKZRZ4PZfjtLLnpxuCs2caM0oqFf1
z7ua4KIPXe3cWa2N7zQNtdaUW2ITnVBx3Caanw/rxWqM1gRc3MFsP3vBBzqGok/z
FoglVIQQPBwsBiSjWqrlQt+X16ycYKNw+f/uMNkAReDeQPe1++VoekLcUHZB8LSj
wsYao8A4PiNRvn4KqOYHt1ewf+kHoXeubjrnPorWx23PrcCCqBCUY1HwHK4QFsDU
kcioRYdVd6qOqIimWhI+CCoefhKQNW/BFawEcnj38Q/npdEdSmBgYOUH+FiQfPkh
enMDqsejqeUj0AL6NtDbtFu4zac63RTD4vZ+WQnyWx3mUVrH82Ngm1AwgW/C0IMZ
N7fIN4XcJ6q5SwapitVC/av0+oKvIqSo0/m35Hk40xHoQ7fXz2kECWAN5+k3Z4sA
L2wYPy2aii943zf3PBmDhFGZJQzsz9MbYpIW9lN7W0ado9KLDzYVmavldKlQ7wrN
g2ugfJTMtuDbntoIDHp4UkAJ3YzENoCMmNrbwhYVTeZ3abmyCWh5X1hjrf24KzLl
X6IRQqXxRbOX05PoFqb1Ra1pFr/f5HEGuvk+RU/VLy38osRVql/PA4dStVF/gO0L
vO2aXnL0/PiRp2YeCYfB
=6kOi
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
