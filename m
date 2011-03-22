From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Tue, 22 Mar 2011 12:54:51 +0200
Message-ID: <20110322105451.GE4286@esdhcp034230>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
 <20110322091314.GB4286@esdhcp034230>
 <9D0D31AA57AAF5499AFDC63D6472631B06AFCF@008-AM1MPN1-036.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:52834 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab1CVKz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 06:55:28 -0400
Content-Disposition: inline
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B06AFCF@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Jokiniemi Kalle (Nokia-MS/Tampere)" <kalle.jokiniemi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "Koskinen Ilkka (Nokia-MS/Tampere)" <ilkka.koskinen@nokia.com>

Hi,

On Tue, Mar 22, 2011 at 12:24:27PM +0200, Jokiniemi Kalle (Nokia-MS/Tampere) wrote:
>  > > +static int rx51_xceiv_power(struct device *dev, int iD, int on)
>  > > +{
>  > > +	unsigned long	timeout;
>  > > +
>  > > +	if (!on) {
>  > > +		/* Let musb go stdby before powering down the transceiver */
>  > > +		timeout = jiffies + msecs_to_jiffies(100);
>  > > +		while (!time_after(jiffies, timeout))
>  > > +			if (omap2_cm_read_mod_reg(CORE_MOD,
>  > CM_IDLEST1)
>  > > +				&
>  > OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK)
>  > > +				break;
>  > > +		if (!(omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
>  > > +			& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK))
>  > > +			WARN(1, "could not put musb to sleep\n");
>  > > +	}
>  > > +	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
>  > > +
>  > > +	return 0;
>  > > +}
>  > 
>  > The busy loop is not needed, and not what we want. We need to be able
>  > to toggle the CHIP_SEL even if the USB block is not IDLE or STDBY.
> 
> I basically just took what was in the maemo kernel. Was there some reason
> originally to include the busyloop? Do I get it now correctly that the ISP is
> only needed active when we are charging?

OK, my comment was incorrect. The gpio is clearly set regardless of the
outcome of the loop. To answer your question, we only need the ISP to
be active when _detecting_ the charger and obviously when USB is in
use.

We had problems hitting off-mode if we switched the transceiver off
before the controller had entered STDBY. I think this needs to be
tested again. The code in drivers/usb/musb/omap2430.c is quite
different then what we had in maemo kernel. It could be that there is
no need for the loop anymore. If you want to play it safe, fix it and
leave it there.

-- 
heikki
