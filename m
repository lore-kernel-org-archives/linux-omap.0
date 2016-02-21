From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] power_supply: bq2415x_charger: Do not add acpi
 modalias when CONFIG_ACPI is not enabled
Date: Sun, 21 Feb 2016 14:33:58 +0100
Message-ID: <20160221133358.GB22958@amd>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
 <1456054103-19551-4-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456054103-19551-4-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2016-02-21 12:28:20, Pali Roh=E1r wrote:
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


> @@ -1759,6 +1759,7 @@ static const struct i2c_device_id bq2415x_i2c_i=
d_table[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, bq2415x_i2c_id_table);
> =20
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id bq2415x_i2c_acpi_match[] =3D {
>  	{ "BQ2415X", BQUNKNOWN },
>  	{ "BQ241500", BQ24150 },
> @@ -1776,6 +1777,7 @@ static const struct acpi_device_id bq2415x_i2c_=
acpi_match[] =3D {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, bq2415x_i2c_acpi_match);
> +#endif
> =20
>  static struct i2c_driver bq2415x_driver =3D {
>  	.driver =3D {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
