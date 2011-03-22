From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Tue, 22 Mar 2011 10:13:37 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06AF54@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
 <4D8760AB.1080307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D8760AB.1080307-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
 > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of ext Sergei Shtylyov
 > Sent: 21. maaliskuuta 2011 16:29
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
 > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Krogerus Heikki (Nokia-MS/Helsinki);
 > jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Koskinen Ilkka (Nokia-MS/Tampere)
 > Subject: Re: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
 > 
 > Hello.
 > 
 > Kalle Jokiniemi wrote:
 > 
 > > This patch allows the ISP1707 USB tranceiver on Nokia
 > > N900 to be disabled when usb cable is disconnected.
 > > This saves approximately 14mA of battery current.
 > 
 > > Patch based on work done by Heikki Krogerus on N900
 > > maemo kernel.
 > 
 > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 > > Cc: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 > > ---
 > >  arch/arm/mach-omap2/board-rx51-peripherals.c |   32
 > ++++++++++++++++++++++++++
 > >  1 files changed, 32 insertions(+), 0 deletions(-)
 > 
 > > diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c
 > b/arch/arm/mach-omap2/board-rx51-peripherals.c
 > > index e75e240..9dd22bc 100644
 > > --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
 > > +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
 > [...]
 > > @@ -534,8 +537,36 @@ static struct twl4030_gpio_platform_data
 > rx51_gpio_data = {
 > >  	.setup			= rx51_twlgpio_setup,
 > >  };
 > >
 > > +static void __init rx51_xceiv_init(void)
 > > +{
 > > +	if (gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0)
 > > +		BUG();
 > 
 >     Why not:
 > 
 > 	BUG_ON(gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) <
 > 0);

Makes sense, will change that. Thanks for the comments.

- Kalle

 > 
 > WBR, Sergei
 > 
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
 > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
