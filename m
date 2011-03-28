From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 12:49:21 +0530
Message-ID: <17a241ba5fb52c72ed49ad345910065f@mail.gmail.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com> <1301295099-22066-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301295099-22066-3-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> +
>  static struct platform_device rx51_charger_device =3D {
> -	.name =3D "isp1704_charger",
> +	.name	=3D "isp1704_charger",

Both are same; you don=92t need this change!



> +	.dev	=3D {
> +		.platform_data =3D &rx51_charger_data,
> +	},
>  };
>
> +static void __init rx51_charger_init(void)
> +{
> +	BUG_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
> +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
> +
> +	platform_device_register(&rx51_charger_device);
> +}
> +
>  #if defined(CONFIG_KEYBOARD_GPIO) ||
defined(CONFIG_KEYBOARD_GPIO_MODULE)
>
>  #define RX51_GPIO_CAMERA_LENS_COVER	110
> @@ -928,6 +951,6 @@ void __init rx51_peripherals_init(void)
>  	if (partition)
>  		omap2_hsmmc_init(mmc);
>
> -	platform_device_register(&rx51_charger_device);
> +	rx51_charger_init();
>  }
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
