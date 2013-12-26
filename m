From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V5 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
Date: Thu, 26 Dec 2013 14:01:06 -0600
Message-ID: <20131226200106.GA30559@saruman.home>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, rob.herring@calxeda.com, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 03, 2013 at 03:57:23PM +0530, Sricharan R wrote:
> +static const struct of_device_id crossbar_match[] __initconst =3D {
> +	{ .compatible =3D "ti,irq-crossbar" },
> +	{}
> +};
> +
> +int irqcrossbar_init(void)
> +{
> +	struct device_node *np;
> +	np =3D of_find_matching_node(NULL, crossbar_match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	crossbar_of_init(np);
> +	return 0;
> +}

instead, please use IRQCHIP_DECLARE() then you won't need to expose this
symbol to be used by arch/arm/ code.

--=20
balbi

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSvIsCAAoJEIaOsuA1yqREoGEP/3GFpG5Hsh/dUlQEidzogeXz
b8m1nmUnGOP/FsXE2oEXpnDnh/yGL37Kp84guIpHawKwXKqHvuUC1IZQrwRZngQC
LahlYvUMoITTPonPNpIUcXwRQekknhYRrbRvxt8i8aj9bAkYGI5AdS2bY/MqEB/8
0TuwXNFJSzbDzat+c1uWNFJs+EwRyuiWHa+VsQ1mOTH1E8gaPxD6yNUKpomDDqB+
5O8piuEmadf8sS0bF1ER4IYDe+5ZNUn08wO+Brt9WmDYbvB3LvCwhR8K/qYYgPad
IZaMgSKkdudYJkgrMqoU1t6tuk63dWJAdUPZ+mGhaJsqakP+cod2N3M2PZxPI6PC
IQY4mory1E8dYwOEGvT6MvZARcqK3Bz/hCu2/eYYdaakGL8rcqLxSITgFWnHG8jT
IotmQadDKH3vwGRgYIOY7loAvglecmBtszJ8HnILJ1vLm9e5mMiNhxYUDg7j3CbW
1DOomKcjcpJ5D4fX6XgOzIJZ9qhVik4ypGOC3+hugaQBfOHNZvfPlITktvln7SO2
1uCFGCXj1BmY8NOTRVdhINWZ0U1lLaya08N59cjOC9/SedtwIl5wvNf07+CjASoa
2AmJCmm5QbF6hJ5YmrOBckF+pKaNRUghbY8O0FVSq+GGhTitQWeCIHk/Qoj4XtFC
FKHJWls6EbMxszX6SjWo
=CY58
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
