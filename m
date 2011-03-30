From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 30 Mar 2011 06:41:58 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06F1AE@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <a5285450b1fc92da8a42cc0733360a30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a5285450b1fc92da8a42cc0733360a30-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Keshava Munegowda [mailto:keshava_mgowda-l0cyMroinI0@public.gmane.org]
 > Sent: 30. maaliskuuta 2011 9:39
 > To: Jokiniemi Kalle (Nokia-MS/Tampere); linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
 > cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 > Cc: Felipe Balbi; Krogerus Heikki (Nokia-MS/Helsinki); sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org;
 > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Kevin Hilman; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
 > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
 > Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
 > 
 > > +
 > >  static struct platform_device rx51_charger_device = {
 > > -	.name = "isp1704_charger",
                            ^space here



 > > +	.name	= "isp1704_charger",
                              ^tab here
 > 
 > I don't understand what difference between above two lines?
 > Is your mail client causing this? Or get send-mail doing this?

No, changed space for tab so that all the members are indented same way.
I had that (apparently obscure) explanation about this in the commit log ;)

 > 
 > 
 > > +	.dev	= {
                          ^tab here also

 > > +		.platform_data = &rx51_charger_data,
 > > +	},
 > >  };
 > >
 > > +static void __init rx51_charger_init(void)
 > > +{
 > > +	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
 > > +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
 > > +
 > > +	platform_device_register(&rx51_charger_device);
 > > +}
 > > +
 > >  #if defined(CONFIG_KEYBOARD_GPIO) ||
 > defined(CONFIG_KEYBOARD_GPIO_MODULE)
 > >
 > >  #define RX51_GPIO_CAMERA_LENS_COVER	110
 > > @@ -981,6 +1004,6 @@ void __init rx51_peripherals_init(void)
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
 > > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
 > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
