From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/7] mfd: menelaus: add initial DT support
Date: Sat, 27 Dec 2014 15:25:53 -0600
Message-ID: <20141227212553.GA21729@saruman>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59115 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaL0V0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 16:26:52 -0500
Content-Disposition: inline
In-Reply-To: <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2014 at 07:52:55PM +0200, Aaro Koskinen wrote:
> Add initial DT support.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 +++++++++++++
>  drivers/mfd/menelaus.c                             | 52 ++++++++++++++++=
++++--
>  2 files changed, 78 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/menelaus.txt b/Documen=
tation/devicetree/bindings/mfd/menelaus.txt
> new file mode 100644
> index 0000000..5f69f23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/menelaus.txt
> @@ -0,0 +1,30 @@
> +Menelaus (Texas Instruments TWL92330) Power Management chip
> +
> +Menelaus provides facilities to control the power resources.
> +
> +Required properties:
> +- compatible: must be "menelaus"
> +- reg: I2C address of the chip
> +
> +Optional properties:
> +- interrupts: the interrupt
> +- ti,autosleep: All regulators are put to sleep by default.
> +- ti,vcore-min-microvolt: Range floor for the HW controlled VCORE
> +- ti,vcore-max-microvolt: Range roof for the HW controlled VCORE
> +
> +The use of ti,autosleep is recommended at least on Nokia N800/N810.
> +
> +Example:
> +
> +&i2c1 {
> +	clock-frequency =3D <400000>;
> +
> +	pmic@72 {
> +		compatible =3D "menelaus";
> +		reg =3D <0x72>;
> +		interrupts =3D <7 IRQ_TYPE_EDGE_RISING>;
> +		ti,autosleep;
> +		ti,vcore-min-microvolt =3D <1050000>;
> +		ti,vcore-max-microvolt =3D <1400000>;

looks like these should be first converted to actual regulators
otherwise we will have to maintain this binding forever which means that
any effort of adding regulator fwk support for menelaus will become a
lot more difficult because it'll have to cope with the legacy/bogus
binding.

I started doing irqchip/irqdomain conversion but I don't have where to
test and got side-tracked by other stuff. I'll see if I can restart that
work early next year.

Then, if you change your series so that first you add proper regulator
fwk support, we should be pretty good with menelaus.

--=20
balbi

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnyPhAAoJEIaOsuA1yqREzRkQAIAQPVIwKcSbRXU4zcMOdpe7
KgUA1Mb8WHUHY/RewjCOqZFC5MHSYbcxMl3oWHuAEZEUy+suDS5FY9p9MZD5oUMr
/E/JOvYLfUlVgka4I+UiYKH/TIjq3pjywDTLBYaJMpL47y1wAtHhjT4sVJh79R1I
xf3XakYTRfG+RrpkF05qWTnGUeNi1NaNgPSeVhBK/Lxx3F7xRJmqzIXzNWVSyvKq
FVDpjZ4G6sxLacplCah7siWSmXi1xEbtCqqMAS6FoP7BhcBuiaEkJTxvbNFtyOJu
Ymh+hfMhQLr6lkdqh5Q3jpJkv5MTxSvA1Apc0sntaNbkYEMAzbxqVt5L2hZg8Lnl
lJoya6Hl8anpoC9jHzJeYiaApP9rPWCOoyPYubKu9f92lSoGrm8LJQOB/OCpCryo
rHuBwyRWud72oIJLO0XQZzvsv6JIajOJ8o9LaAGpRco6U+dJAq/RwH6X2czA7jWd
havr9S5C3xmkvZcS+D1FAhnN2YQydazWY4xBsemuWRwQykiAgazI2OFvAhohzdYn
dWKctLHOXinJ48fwCJxj69Bqk4oXInltxmXUSmtqw7k1rlzG5nQEA+mGoa1J5qlw
xtf1vxIS6xdG9yHiMQjBTf8Jh/owyssR+2ImoR3RUqH/egVs8sVLx2PEtXmZyHD/
1FfHQHuLOZDLcjjyBw9h
=/3UG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
