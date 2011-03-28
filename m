From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 09:57:58 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06D0D4@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-3-git-send-email-kalle.jokiniemi@nokia.com>
 <4D9044B2.5020607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D9044B2.5020607-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: ext Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
 > Sent: 28. maaliskuuta 2011 11:20
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
 > Krogerus Heikki (Nokia-MS/Helsinki); jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; khilman-l0cyMroinI0@public.gmane.org
 > Subject: Re: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
 > 
 > On 28-03-2011 10:51, Kalle Jokiniemi wrote:
 > 
 > > The isp1704 usb tranceiver is used for charging and can be
 > > disabled when not in use. Provide the powering routine to
 > > the driver via platform data.
 > 
 > > Loosely based on earlier patches from Heikki Krogerus in
 > > Nokia N900 maemo kernel.
 > 
 > > Signed-off-by: Kalle Jokiniemi<kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 > > Cc: Heikki Krogerus<heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
 > > ---
 > >   arch/arm/mach-omap2/board-rx51-peripherals.c |   27
 > ++++++++++++++++++++++++-
 > >   1 files changed, 25 insertions(+), 2 deletions(-)
 > 
 > > diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c
 > b/arch/arm/mach-omap2/board-rx51-peripherals.c
 > > index e75e240..8584dd8 100644
 > > --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
 > > +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
 > [...]
 > > @@ -106,10 +109,30 @@ static struct spi_board_info
 > rx51_peripherals_spi_board_info[] __initdata = {
 > >   	},
 > >   };
 > >
 > > +static void rx51_charger_set_power(bool on)
 > > +{
 > > +	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
 > > +}
 > > +
 > > +static struct isp1704_charger_data rx51_charger_data = {
 > > +	.set_power	= rx51_charger_set_power,
 > > +};
 > > +
 > >   static struct platform_device rx51_charger_device = {
 > > -	.name = "isp1704_charger",
 > > +	.name	= "isp1704_charger",
 > > +	.dev	= {
 > > +		.platform_data =&rx51_charger_data,
 > > +	},
 > >   };
 > >
 > > +static void __init rx51_charger_init(void)
 > > +{
 > > +	BUG_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
 > > +		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
 > 
 >     I'm not sure we should kill the machine if this fails...

True, WARN_ON is probably sufficient.

- Kalle

 > 
 > WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
