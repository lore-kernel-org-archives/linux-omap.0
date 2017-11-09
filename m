From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 4/7] dmtimer: Add timer ops to the platform data
 structure
Date: Thu, 9 Nov 2017 17:27:42 +0100
Message-ID: <20171109162742.mrdvh5cvom577whh@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uel3l4gi7hvmsh4i"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-5-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--uel3l4gi7hvmsh4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:25PM +0530, Keerthy wrote:
> Add timer ops to the platform data structure
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

I think the solution to provide private functions is not very nice,
but it improves the current situation and does not touch any ABI (so
can easily be changed later on), so:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  include/linux/platform_data/dmtimer-omap.h | 38 ++++++++++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/p=
latform_data/dmtimer-omap.h
> index a19b78d..a3e1794 100644
> --- a/include/linux/platform_data/dmtimer-omap.h
> +++ b/include/linux/platform_data/dmtimer-omap.h
> @@ -20,12 +20,50 @@
>  #ifndef __PLATFORM_DATA_DMTIMER_OMAP_H__
>  #define __PLATFORM_DATA_DMTIMER_OMAP_H__
> =20
> +struct omap_dm_timer_ops {
> +	struct omap_dm_timer *(*request_by_node)(struct device_node *np);
> +	struct omap_dm_timer *(*request_specific)(int timer_id);
> +	struct omap_dm_timer *(*request)(void);
> +
> +	int	(*free)(struct omap_dm_timer *timer);
> +
> +	void	(*enable)(struct omap_dm_timer *timer);
> +	void	(*disable)(struct omap_dm_timer *timer);
> +
> +	int	(*get_irq)(struct omap_dm_timer *timer);
> +	int	(*set_int_enable)(struct omap_dm_timer *timer,
> +				  unsigned int value);
> +	int	(*set_int_disable)(struct omap_dm_timer *timer, u32 mask);
> +
> +	struct clk *(*get_fclk)(struct omap_dm_timer *timer);
> +
> +	int	(*start)(struct omap_dm_timer *timer);
> +	int	(*stop)(struct omap_dm_timer *timer);
> +	int	(*set_source)(struct omap_dm_timer *timer, int source);
> +
> +	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
> +			    unsigned int value);
> +	int	(*set_match)(struct omap_dm_timer *timer, int enable,
> +			     unsigned int match);
> +	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
> +			   int toggle, int trigger);
> +	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
> +
> +	unsigned int (*read_counter)(struct omap_dm_timer *timer);
> +	int	(*write_counter)(struct omap_dm_timer *timer,
> +				 unsigned int value);
> +	unsigned int (*read_status)(struct omap_dm_timer *timer);
> +	int	(*write_status)(struct omap_dm_timer *timer,
> +				unsigned int value);
> +};
> +
>  struct dmtimer_platform_data {
>  	/* set_timer_src - Only used for OMAP1 devices */
>  	int (*set_timer_src)(struct platform_device *pdev, int source);
>  	u32 timer_capability;
>  	u32 timer_errata;
>  	int (*get_context_loss_count)(struct device *);
> +	struct omap_dm_timer_ops *timer_ops;
>  };
> =20
>  #endif /* __PLATFORM_DATA_DMTIMER_OMAP_H__ */
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--uel3l4gi7hvmsh4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEgfsACgkQ2O7X88g7
+poxzw//XV1DB5qsqTHU0wpODUPyYBjevzYIMcpB5pEp74OfyS6djDvr7kwUP2AU
uN6+kJ+6x0u1nfQIZ4jLkkV1bcakSs3M6hd82DMraQ2+bEw0ZS5CYuUMx4thkIRw
6W9yCqK2OyfDWLOUAJh1sFah2OxwUVbLidxcc9izYqjlqAxVI5B5UntQFcGk8cKK
8SDPffkL9SAw2sFTXXHGRVXhcMmwdbWPrjevWd2eBaVAK1crHLeAWZ9mJ/QtaVy+
oN5rnjMk8NHyN1XCACKYP0BpHTdsib87fAqr4zQtwaWDaVMPdkFR0gYm9xQ612vF
kV2i9VY8rqkt2aMudbkpEYiUv9ne9Zo7WncI92RvP1hw5c6Y/1U9436cjZdtZZMA
CPwYoSpBW5Zi4olDtaYhx/7ppHi+F3QbrNWyIVUMCUWYb/rQxLM/Uf/pSuXEU6IY
XbxGz9ignPXmh2N6KlhmcWQrYiZaU9WfbwC4snx82Pl4TG3t9Lns5RBccwMe1/JE
x5NZT0sjuoiDRLj/5G10g2OsDVNUCc0s+kZqB7lZgOdDr4BwLBRNmP2WTF8im4Ff
sLmMOhdo7RjxvQGZRlhl7fMDrwkT+i/XAWzIVhQSRSWFAB6mxdwbJW4ObbIT7748
jQ0kjuPGhLIQRCUKdV3QEigkr76JYlpE4KjYj0kLwUEr/MnfhVs=
=kc/W
-----END PGP SIGNATURE-----

--uel3l4gi7hvmsh4i--
