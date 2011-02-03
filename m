From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 12:22:42 +0200
Message-ID: <20110203102242.GN23561@legolas.emea.dhcp.ti.com>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
 <20110203095845.GK23561@legolas.emea.dhcp.ti.com>
 <20110203100528.GA6508@pengutronix.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45995 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756128Ab1BCKWr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:22:47 -0500
Content-Disposition: inline
In-Reply-To: <20110203100528.GA6508@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, dmitry.torokhov@gmail.com, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Thu, Feb 03, 2011 at 11:10:33AM +0100, Wolfram Sang wrote:
> On Thu, Feb 03, 2011 at 11:58:45AM +0200, Felipe Balbi wrote:
> > On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
> > > The ads7846 driver requests a gpio to detect pendown events,
> > > but does not configure its direction. Configure this gpio
> > > as an input after requesting it.
> > > 
> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > ---
> > > changes between v2 and v1: Added return error support in v2. 
> > >  
> > > drivers/input/touchscreen/ads7846.c |    7 +++++++
> > > 1 files changed, 7 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> > > index 036f245..f30768b 100644
> > > --- a/drivers/input/touchscreen/ads7846.c
> > > +++ b/drivers/input/touchscreen/ads7846.c
> > > @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
> > >  		return err;
> > >  	}
> > >  
> > > +	err = gpio_direction_input(pdata->gpio_pendown);
> > > +	if (err) {
> > > +		dev_err(&spi->dev, "failed to configure pendown GPIO input direction %d\n",
> > > +			pdata->gpio_pendown);
> > > +		return err;
> > 
> > and now you miss a gpio_free().
> 
> Better use gpio_request_one()?

Why not ?!? I'm not sure if $SUBJECT is the best for that though.

-- 
balbi
