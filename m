From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Tue, 22 Mar 2011 10:30:44 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06AFF6@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
 <20110321172058.a8b66331.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110321172058.a8b66331.jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Jarkko Nikula [mailto:jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
 > Sent: 21. maaliskuuta 2011 17:21
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
 > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Krogerus Heikki (Nokia-MS/Helsinki); Koskinen Ilkka
 > (Nokia-MS/Tampere)
 > Subject: Re: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
 > 
 > On Mon, 21 Mar 2011 15:50:20 +0200
 > Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
 > 
 > > This patch allows the ISP1707 USB tranceiver on Nokia
 > > N900 to be disabled when usb cable is disconnected.
 > > This saves approximately 14mA of battery current.
 > >
 > I can measure that these two patches save about 14 mA.
 > 
 > > +static void __init rx51_xceiv_init(void)
 > > +{
 > > +	if (gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0)
 > > +		BUG();
 > > +	gpio_direction_output(RX51_USB_TRANSCEIVER_RST_GPIO, 1);
 > > +}
 > 
 > gpio_request_one makes this function needless.

Thanks for the pointer, I'll look that up. Though, I want to still keep a function for the init for readability to clearly point out what is being initialized.

 > 
 > > +static int rx51_xceiv_power(struct device *dev, int iD, int on)
 > > +{
 > > +	unsigned long	timeout;
 > > +
 > > +	if (!on) {
 > > +		/* Let musb go stdby before powering down the transceiver */
 > > +		timeout = jiffies + msecs_to_jiffies(100);
 > > +		while (!time_after(jiffies, timeout))
 > > +			if (omap2_cm_read_mod_reg(CORE_MOD,
 > CM_IDLEST1)
 > > +				&
 > OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK)
 > > +				break;
 > > +		if (!(omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
 > > +			& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK))
 > > +			WARN(1, "could not put musb to sleep\n");
 > > +	}
 > > +	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
 > > +
 > 
 > Hmm... 100 ms busy loop. I wonder are there better ways in usb to
 > achieve this gpio control than this loop here and playing with these
 > registers? I believe musb/phy/etc has knowledge when they are idle and
 > can do some board specific stuff?

Will clean this up. Have to look at that isp1704_charger to see if it can be responsible of the correct state checks...

- Kalle

 > 
 > --
 > Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
