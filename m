From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 30 Mar 2011 12:08:32 +0530
Message-ID: <a5285450b1fc92da8a42cc0733360a30@mail.gmail.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com> <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301405280-16899-3-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> +
>  static struct platform_device rx51_charger_device =3D {
> -	.name =3D "isp1704_charger",
> +	.name	=3D "isp1704_charger",

I don=92t understand what difference between above two lines?
Is your mail client causing this? Or get send-mail doing this?


> +	.dev	=3D {
> +		.platform_data =3D &rx51_charger_data,
> +	},
>  };
>
> +static void __init rx51_charger_init(void)
> +{
> +	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
> +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
> +
> +	platform_device_register(&rx51_charger_device);
> +}
> +
>  #if defined(CONFIG_KEYBOARD_GPIO) ||
defined(CONFIG_KEYBOARD_GPIO_MODULE)
>
>  #define RX51_GPIO_CAMERA_LENS_COVER	110
> @@ -981,6 +1004,6 @@ void __init rx51_peripherals_init(void)
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
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
