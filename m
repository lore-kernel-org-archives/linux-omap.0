From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH v2 1/2] isp1704_charger: allow board specific powering
 routine
Date: Mon, 28 Mar 2011 09:57:09 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06D0BA@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-2-git-send-email-kalle.jokiniemi@nokia.com>
 <20110328091240.GA3969@esdhcp034230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:55544 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab1C1J5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 05:57:15 -0400
In-Reply-To: <20110328091240.GA3969@esdhcp034230>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki.Krogerus@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, jhnikula@gmail.com, khilman@ti.com

Hello,

 > -----Original Message-----
 > From: Heikki Krogerus [mailto:heikki.krogerus@nokia.com]
 > Sent: 28. maaliskuuta 2011 12:13
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; balbi@ti.com;
 > jhnikula@gmail.com; khilman@ti.com
 > Subject: Re: [PATCH v2 1/2] isp1704_charger: allow board specific powering
 > routine
 > 
 > Hi,
 > 
 > Add Anton Vorontsov <cbouatmailru@gmail.com> to your v3. This will
 > need ack from him, or this needs to go to him. In this case I guess we
 > are only dealing with RX51 stuff, so maybe this should go to Tony.

Thanks, I'll add Anton to cc.

 > 
 > On Mon, Mar 28, 2011 at 09:51:38AM +0300, Kalle Jokiniemi wrote:
 > > The ISP1704/1707 chip can be put to full power down
 > > state by asserting the CHIP_SEL line. This patch enables
 > > platform or board specific hooks to put the device into
 > > power down mode in case not needed.
 > >
 > > These patches are preparatio for enabling this powering
 > > routine in n900 (rx-51) devices.
 > >
 > > Thanks to Heikki Krogerus for helping out with the patch.
 > >
 > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
 > > Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
 > > ---
 > >  drivers/power/isp1704_charger.c       |   26 ++++++++++++++++++++++++++
 > >  include/linux/power/isp1704_charger.h |   29
 > +++++++++++++++++++++++++++++
 > >  2 files changed, 55 insertions(+), 0 deletions(-)
 > >  create mode 100644 include/linux/power/isp1704_charger.h
 > >
 > > diff --git a/drivers/power/isp1704_charger.c
 > b/drivers/power/isp1704_charger.c
 > > index 2ad9b14..c796b9f 100644
 > > --- a/drivers/power/isp1704_charger.c
 > > +++ b/drivers/power/isp1704_charger.c
 > > @@ -33,6 +33,7 @@
 > >  #include <linux/usb/ulpi.h>
 > >  #include <linux/usb/ch9.h>
 > >  #include <linux/usb/gadget.h>
 > > +#include <linux/power/isp1704_charger.h>
 > >
 > >  /* Vendor specific Power Control register */
 > >  #define ISP1704_PWR_CTRL		0x3d
 > > @@ -63,6 +64,7 @@ struct isp1704_charger {
 > >  	char			model[8];
 > >  	unsigned		present:1;
 > >  	unsigned		online:1;
 > > +	unsigned		init_done;
 > 
 > Do we need this?

Good point. I needed this for 2.6.37 meego kernel, because it calls
otg_get_last_event in middle of the probing, which causes the
isp1704_charger_work to be run with USB_EVENT_NONE, which
then caused the power to be shut down from the isp during probe.

But it seems the get_last_notifier is not called in upstream code,
So I probably can drop that init_done variable.

 > 
 > >  	unsigned		current_max;
 > >
 > >  	/* temp storage variables */
 > > @@ -71,6 +73,18 @@ struct isp1704_charger {
 > >  };
 > >
 > >  /*
 > > + * Disable/enable the power from the isp1704 if a function for it
 > > + * has been provided with platform data.
 > > + */
 > > +static void isp1704_charger_set_power(struct isp1704_charger *isp, bool
 > on)
 > > +{
 > > +	struct isp1704_charger_data	*board = isp->dev->platform_data;
 > > +
 > > +	if (board->set_power)
 > > +		board->set_power(on);
 > > +}
 > > +
 > > +/*
 > >   * Determine is the charging port DCP (dedicated charger) or CDP (Host/HUB
 > >   * chargers).
 > >   *
 > > @@ -222,6 +236,9 @@ static void isp1704_charger_work(struct work_struct
 > *data)
 > >
 > >  	mutex_lock(&lock);
 > >
 > > +	if (event != USB_EVENT_NONE)
 > > +		isp1704_charger_set_power(isp, 1);
 > > +
 > >  	switch (event) {
 > >  	case USB_EVENT_VBUS:
 > >  		isp->online = true;
 > > @@ -269,6 +286,9 @@ static void isp1704_charger_work(struct work_struct
 > *data)
 > >  		 */
 > >  		if (isp->otg->gadget)
 > >  			usb_gadget_disconnect(isp->otg->gadget);
 > > +		/* If we're initialized, we can power down the isp */
 > > +		if (isp->init_done)
 > > +			isp1704_charger_set_power(isp, 0);
 > >  		break;
 > >  	case USB_EVENT_ENUMERATED:
 > >  		if (isp->present)
 > > @@ -394,6 +414,8 @@ static int __devinit isp1704_charger_probe(struct
 > platform_device *pdev)
 > >  	isp->dev = &pdev->dev;
 > >  	platform_set_drvdata(pdev, isp);
 > >
 > > +	isp1704_charger_set_power(isp, 1);
 > > +
 > >  	ret = isp1704_test_ulpi(isp);
 > >  	if (ret < 0)
 > >  		goto fail1;
 > > @@ -437,8 +459,11 @@ static int __devinit isp1704_charger_probe(struct
 > platform_device *pdev)
 > >  	if ((ret & ULPI_INT_VBUS_VALID) && !isp->otg->default_a) {
 > >  		isp->event = USB_EVENT_VBUS;
 > >  		schedule_work(&isp->work);
 > > +	} else {
 > > +		isp1704_charger_set_power(isp, 0);
 > >  	}
 > 
 > I think the transceiver can be powered down even if we just scheduled
 > the work. This will basically cause hw reset on the transceiver which
 > is only a good thing IMO. Drop the else condition.

Ok, I'll test that out and include it if it works w/o problems.

Thanks for the excellent comments.

- Kalle

 > 
 > > +	isp->init_done = 1;
 > >  	return 0;
 > >  fail2:
 > >  	power_supply_unregister(&isp->psy);
 > > @@ -459,6 +484,7 @@ static int __devexit isp1704_charger_remove(struct
 > platform_device *pdev)
 > >  	otg_unregister_notifier(isp->otg, &isp->nb);
 > >  	power_supply_unregister(&isp->psy);
 > >  	otg_put_transceiver(isp->otg);
 > > +	isp1704_charger_set_power(isp, 0);
 > >  	kfree(isp);
 > >
 > >  	return 0;
 > 
 > --
 > heikki
