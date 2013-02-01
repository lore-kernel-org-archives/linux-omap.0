From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] RX-51: Add leds lp5523 names from Maemo 5 2.6.28 kernel
Date: Fri, 1 Feb 2013 10:46:11 -0800
Message-ID: <20130201184610.GO22517@atomide.com>
References: <1358650244-29722-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358650244-29722-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130119 18:54]:
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

Thanks applying into omap-for-v3.9/board with the subject
also pasted to the description.

Tony
=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index 7611958..9a0dbb7 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -168,30 +168,39 @@ static struct tsl2563_platform_data rx51_tsl256=
3_platform_data =3D {
>  #if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE=
)
>  static struct lp5523_led_config rx51_lp5523_led_config[] =3D {
>  	{
> +		.name		=3D "lp5523:kb1",
>  		.chan_nr	=3D 0,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:kb2",
>  		.chan_nr	=3D 1,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:kb3",
>  		.chan_nr	=3D 2,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:kb4",
>  		.chan_nr	=3D 3,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:b",
>  		.chan_nr	=3D 4,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:g",
>  		.chan_nr	=3D 5,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:r",
>  		.chan_nr	=3D 6,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:kb5",
>  		.chan_nr	=3D 7,
>  		.led_current	=3D 50,
>  	}, {
> +		.name		=3D "lp5523:kb6",
>  		.chan_nr	=3D 8,
>  		.led_current	=3D 50,
>  	}
> --=20
> 1.7.10.4
>=20
