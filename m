From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix bus recovery setup
Date: Wed, 29 Jul 2015 12:27:30 +0200
Message-ID: <1438165650.20986.2.camel@pengutronix.de>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
	 <20150714111004.GB1517@katana> <55A4FC19.4040709@ti.com>
	 <20150714121207.GI1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150714121207.GI1517@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Di, 2015-07-14 at 14:12 +0200, Wolfram Sang wrote:
> On Tue, Jul 14, 2015 at 03:10:01PM +0300, Grygorii Strashko wrote:
> > Hi Wolfram,
> > 
> > On 07/14/2015 02:10 PM, Wolfram Sang wrote:
> > > On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> > >> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
> > > 
> > > Felipe: it seems you did not need this; is this AM335x specific?
> > 
> > We need it (Felipe's reply can be delayed).
> 
> So, how did it work for him?
> 
> > It's not AM335x specific. TMODE has to be configured for all OMAP4+ SoCs too.
> 
> Okay, thanks for the stepping in!

Wolfram, will you pick this as-is?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
