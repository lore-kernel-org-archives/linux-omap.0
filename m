From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 3/3] RX-51: Add platform data for bq24150a charger
Date: Tue, 19 Nov 2013 14:32:13 +0100
Message-ID: <20131119133212.GF14587@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-4-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384856285-19593-4-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On Tue 2013-11-19 11:18:05, Pali Roh=E1r wrote:
> This patch will register bq24150a charger in RX-51 board data.
>=20
> So finally charging battery on Nokia N900 (RX-51) working
> automatically without any proprietary Nokia bits in userspace.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

									Pavel
BTW, current code says:

That seems to limit charging voltage to 3.9V, with comment saying
4.11V... which means battery will not be charged fully. does it make
sense to raise limit to 4.11V here?

Aha, and actually will not 4.2V requested by
rx51_bq24150a_platform_data trigger -EINVAL?

/* set battery regulation voltage in mV */
static int bq2415x_set_battery_regulation_voltage(struct
bq2415x_device *bq,
                                                  int mV)
{
        int val =3D (mV/10 - 350) / 2;

        if (val < 0)
                val =3D 0;
        else if (val > 94) /* FIXME: Max is 94 or 122 ? Set max value
                ? */
                return -EINVAL;

        return bq2415x_i2c_write_mask(bq, BQ2415X_REG_VOLTAGE, val,
                        BQ2415X_MASK_VO, BQ2415X_SHIFT_VO);
}

> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -1275,6 +1276,16 @@ static struct aic3x_pdata rx51_aic3x_data2 =3D=
 {
>  	.gpio_reset =3D 60,
>  };
> =20
> +static struct bq2415x_platform_data rx51_bq24150a_platform_data =3D =
{
> +	.current_limit =3D 100,			/* mA */
> +	.weak_battery_voltage =3D 3400,		/* mV */
> +	.battery_regulation_voltage =3D 4200,	/* mV */
> +	.charge_current =3D 650,			/* mA */
> +	.termination_current =3D 100,		/* mA */
> +	.resistor_sense =3D 68,			/* m ohm */
> +	.notify_device =3D "isp1704",
> +};
> +
>  static struct i2c_board_info __initdata rx51_peripherals_i2c_board_i=
nfo_2[] =3D {
>  	{
>  		I2C_BOARD_INFO("tlv320aic3x", 0x18),

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
