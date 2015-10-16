From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 1/3] arm: plat-omap: dmtimer: Add clock source from DT
Date: Fri, 16 Oct 2015 10:40:43 -0500
Message-ID: <87k2qmlt38.fsf@saruman.tx.rr.com>
References: <5620ED30.2050507@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5620ED30.2050507@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Neil Armstrong <narmstrong@baylibre.com> writes:
> Add a function which sets the timer source from the clocks
> binding on dm_timer_prepare call.
>
> In case the clocks property is not valid, it falls back to
> the set_source() with 32_KHZ clock as default.
>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/plat-omap/dmtimer.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 8ca94d3..5e8aece 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -137,9 +137,33 @@ static int omap_dm_timer_reset(struct omap_dm_timer =
*timer)
>  	return 0;
>  }
>
> +static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
> +{
> +	int ret;
> +	struct clk *parent;
> +
> +	if (unlikely(!timer))
> +		return -EINVAL;

IMO, let this crash. If this happens we have bigger problems.

> +	if (IS_ERR(timer->fclk))
> +		return -EINVAL;

We bail out if we can't get fclk, this check is unnecessary.

> +	parent =3D clk_get(&timer->pdev->dev, NULL);

why NULL ? You could use something more descriptive, but no strong
feelings.

> +	if (IS_ERR(parent))
> +		return -ENODEV;
> +
> +	ret =3D clk_set_parent(timer->fclk, parent);
> +	if (ret < 0)
> +		pr_err("%s: failed to set parent\n", __func__);
> +
> +	clk_put(parent);
> +
> +	return ret;
> +}
> +
>  static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
> -	int rc;
> +	int rc, ret;

doesn't seem like you need this extra 'ret' variable. Just use 'rc'.

> @@ -166,7 +190,11 @@ static int omap_dm_timer_prepare(struct omap_dm_time=
r *timer)
>  	__omap_dm_timer_enable_posted(timer);
>  	omap_dm_timer_disable(timer);
>
> -	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +	ret =3D omap_dm_timer_of_set_source(timer);
> +	if (ret < 0 && ret =3D=3D -ENODEV)

this < 0 check is pointless if you're going to check for equality to -ENODEV

> +		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +
> +	return ret;
>  }
>
>  static inline u32 omap_dm_timer_reserved_systimer(int id)
> --=20
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWIRp8AAoJEIaOsuA1yqREvcoP/i8AOIrVXk1mbhWtn55ORaVI
nI77xWS5yRLiI5vs2puMy7F7D5+v8VW1I4oBaaqYKPDAd8pUwdQGFHM7csR9WUxq
xirbg2xGeTMouM6bkEZyvY3gcMvFWqLUuPtu5y+DSm2lJG66ld65MYQHW1HB8zlp
RT4YNIuAZRYbn3ax1G8An4dU9vU9mkf9JxuBqhqVPh4PPIgGeNYvxL3LS0znGEcp
cv4r22dsJCffzFh5721F2nLmf9A0MrVmFTD4W6NBjHkuZMxHGnWyVWoPDxOdCHvC
CaQKBqIbzB1soixPPVY2BoZlDkFUXUvlqdP/6OhIP2K4fNmnFA2QrLPBGAJ909e6
lr3jgzOQKzyUUARjTH7s06b/ypYRWPOpDQyIINw8+0Z9PUJkwDfpEepAojlcKqHO
2T45sth61dIELLlgVtJ7mB8bf/DGA+Jviu2wb8GfSBTnnNUfaDLDLM7o3KZVRn2H
ROOowNzzE0RtQ0TFNU8/HiefyVWlDnf+5IwMFZN6msK13l8Y7wW7BzseOpSxwMAw
+5DnvpAvttVBaMHsJ8Obx9j/73GhFTfCcc1IYJmhjSRtDQk0JL6d5O3EYG5z3rQx
KSDpTnPNrYyJgV9Cda0ActnD+hnZd2KH+SXUis/F2UmygMBsMx0SCXGGiZAnXXZi
Uk2QKJs+kJq8s0aaJDh6
=dTo+
-----END PGP SIGNATURE-----
--=-=-=--
