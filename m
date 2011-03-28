From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 08:06:32 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06CEE3@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-3-git-send-email-kalle.jokiniemi@nokia.com>
 <17a241ba5fb52c72ed49ad345910065f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17a241ba5fb52c72ed49ad345910065f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Keshava Munegowda [mailto:keshava_mgowda-l0cyMroinI0@public.gmane.org]
 > Sent: 28. maaliskuuta 2011 10:19
 > To: Jokiniemi Kalle (Nokia-MS/Tampere); linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
 > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Felipe Balbi
 > Cc: Krogerus Heikki (Nokia-MS/Helsinki); jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Kevin Hilman
 > Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
 > 
 > > +
 > >  static struct platform_device rx51_charger_device = {
 > > -	.name = "isp1704_charger",
 > > +	.name	= "isp1704_charger",
 > 
 > Both are same; you don't need this change!

No, actually they are not same. I added tab instead of space to match indentation with the .dev member. This is the correct way IMHO.

- Kalle

 > 
 > 
 > 
 > > +	.dev	= {
 > > +		.platform_data = &rx51_charger_data,
 > > +	},
 > >  };
 > >
 > > +static void __init rx51_charger_init(void)
 > > +{
 > > +	BUG_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
 > > +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
 > > +
 > > +	platform_device_register(&rx51_charger_device);
 > > +}
 > > +
 > >  #if defined(CONFIG_KEYBOARD_GPIO) ||
 > defined(CONFIG_KEYBOARD_GPIO_MODULE)
 > >
 > >  #define RX51_GPIO_CAMERA_LENS_COVER	110
 > > @@ -928,6 +951,6 @@ void __init rx51_peripherals_init(void)
 > >  	if (partition)
 > >  		omap2_hsmmc_init(mmc);
 > >
 > > -	platform_device_register(&rx51_charger_device);
 > > +	rx51_charger_init();
 > >  }
 > >
 > > --
 > > 1.7.1
 > >
 > > --
 > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
 > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
