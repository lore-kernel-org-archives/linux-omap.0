From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] RX-51: Add missing max_current to
 rx51_lp5523_led_config
Date: Wed, 18 Sep 2013 15:26:43 -0700
Message-ID: <20130918222642.GK9994@atomide.com>
References: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21861 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3IRW0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 18:26:48 -0400
Content-Disposition: inline
In-Reply-To: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 15:02]:
> Without max_current data in board file lp5523 driver does not change =
current.

Hmm is this a regression or are there other reasons to merge
this during the -rc cycle?

Regards,

Tony
=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index 9326890..d0f857c 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -180,38 +180,47 @@ static struct lp55xx_led_config rx51_lp5523_led=
_config[] =3D {
>  		.name		=3D "lp5523:kb1",
>  		.chan_nr	=3D 0,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:kb2",
>  		.chan_nr	=3D 1,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:kb3",
>  		.chan_nr	=3D 2,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:kb4",
>  		.chan_nr	=3D 3,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:b",
>  		.chan_nr	=3D 4,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:g",
>  		.chan_nr	=3D 5,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:r",
>  		.chan_nr	=3D 6,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:kb5",
>  		.chan_nr	=3D 7,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}, {
>  		.name		=3D "lp5523:kb6",
>  		.chan_nr	=3D 8,
>  		.led_current	=3D 50,
> +		.max_current	=3D 255,
>  	}
>  };
> =20
> --=20
> 1.7.10.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
