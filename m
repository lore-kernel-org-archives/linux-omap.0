From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 30 Mar 2011 12:14:55 +0530
Message-ID: <13db9138ec7598cfe100deae367f0b6a@mail.gmail.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <a5285450b1fc92da8a42cc0733360a30@mail.gmail.com> <9D0D31AA57AAF5499AFDC63D6472631B06F1AE@008-AM1MPN1-036.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46086 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533Ab1C3GpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:45:07 -0400
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B06F1AE@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com, linux-usb@vger.kernel.org, cbouatmailru@gmail.com
Cc: Felipe Balbi <balbi@ti.com>, Heikki.Krogerus@nokia.com, sshtylyov@mvista.com, tony@atomide.com, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, jhnikula@gmail.com

> -----Original Message-----
> From: kalle.jokiniemi@nokia.com [mailto:kalle.jokiniemi@nokia.com]
> Sent: Wednesday, March 30, 2011 12:12 PM
> To: keshava_mgowda@ti.com; linux-usb@vger.kernel.org;
cbouatmailru@gmail.com
> Cc: balbi@ti.com; Heikki.Krogerus@nokia.com; sshtylyov@mvista.com;
tony@atomide.com; khilman@ti.com;
> linux-omap@vger.kernel.org; jhnikula@gmail.com
> Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
>
> Hi,
>
>  > -----Original Message-----
>  > From: ext Keshava Munegowda [mailto:keshava_mgowda@ti.com]
>  > Sent: 30. maaliskuuta 2011 9:39
>  > To: Jokiniemi Kalle (Nokia-MS/Tampere); linux-usb@vger.kernel.org;
>  > cbouatmailru@gmail.com
>  > Cc: Felipe Balbi; Krogerus Heikki (Nokia-MS/Helsinki);
sshtylyov@mvista.com;
>  > tony@atomide.com; Kevin Hilman; linux-omap@vger.kernel.org;
>  > jhnikula@gmail.com
>  > Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
>  >
>  > > +
>  > >  static struct platform_device rx51_charger_device = {
>  > > -	.name = "isp1704_charger",
>                             ^space here
>
>
>
>  > > +	.name	= "isp1704_charger",
>                               ^tab here
>  >
>  > I don't understand what difference between above two lines?
>  > Is your mail client causing this? Or get send-mail doing this?
>
> No, changed space for tab so that all the members are indented same way.
> I had that (apparently obscure) explanation about this in the commit log
;)

Then, I am sorry; I couldn't able to notice this!



>
>  >
>  >
>  > > +	.dev	= {
>                           ^tab here also
>
>  > > +		.platform_data = &rx51_charger_data,
>  > > +	},
>  > >  };
>  > >
>  > > +static void __init rx51_charger_init(void)
>  > > +{
>  > > +	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
>  > > +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
>  > > +
>  > > +	platform_device_register(&rx51_charger_device);
>  > > +}
>  > > +
>  > >  #if defined(CONFIG_KEYBOARD_GPIO) ||
>  > defined(CONFIG_KEYBOARD_GPIO_MODULE)
>  > >
>  > >  #define RX51_GPIO_CAMERA_LENS_COVER	110
>  > > @@ -981,6 +1004,6 @@ void __init rx51_peripherals_init(void)
>  > >  	if (partition)
>  > >  		omap2_hsmmc_init(mmc);
>  > >
>  > > -	platform_device_register(&rx51_charger_device);
>  > > +	rx51_charger_init();
>  > >  }
>  > >
>  > > --
>  > > 1.7.1
>  > >
>  > > --
>  > > To unsubscribe from this list: send the line "unsubscribe
linux-usb" in
>  > > the body of a message to majordomo@vger.kernel.org
>  > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
