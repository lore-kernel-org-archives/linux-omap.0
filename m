From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH v4 1/1] extcon: usb-gpio: Introduce gpio usb extcon
 driver
Date: Mon, 16 Mar 2015 16:23:31 +0200
Message-ID: <1426515811.2330.16.camel@linaro.org>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
		 <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com>
		 <54CF4FC7.2050309@ti.com> <1426509149.2330.5.camel@linaro.org>
	 <5506D675.8010006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37949 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933380AbbCPOXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 10:23:36 -0400
Received: by wifj2 with SMTP id j2so44935137wif.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2015 07:23:34 -0700 (PDT)
In-Reply-To: <5506D675.8010006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Roger, 

On Mon, 2015-03-16 at 15:11 +0200, Roger Quadros wrote:
> Hi Ivan,
> 
> On 16/03/15 14:32, Ivan T. Ivanov wrote:
> > Hi,
> > 
> > On Mon, 2015-02-02 at 12:21 +0200, Roger Quadros wrote:
> > > This driver observes the USB ID pin connected over a GPIO and
> > > updates the USB cable extcon states accordingly.
> > > 
> > > The existing GPIO extcon driver is not suitable for this purpose
> > > as it needs to be taught to understand USB cable states and it
> > > can't handle more than one cable per instance.
> > > 
> > > For the USB case we need to handle 2 cable states.
> > > 1) USB (attach/detach)
> > > 2) USB-HOST (attach/detach)
> > > 
> > > This driver can be easily updated in the future to handle VBUS
> > > events in case it happens to be available on GPIO for any platform.
> > > 
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > ---
> > > v4:
> > > - got rid of id_irqwake flag. Fail if enable/disable_irq_wake() fails
> > > - changed host cable name to "USB-HOST"
> > 
> > I am sorry that I am getting a bit little late into this.
> > 
> > Isn't supposed that we have to use strings defined in
> > const char extcon_cable_name[][]?
> > 
> > 
> > > +
> > > +/* List of detectable cables */
> > > +enum {
> > > +       EXTCON_CABLE_USB = 0,
> > > +       EXTCON_CABLE_USB_HOST,
> > > +
> > 
> > Same here: duplicated with enum extcon_cable_name
> > 
> > > +       EXTCON_CABLE_END,
> > > +};
> > > +
> > > +static const char *usb_extcon_cable[] = {
> > > +       [EXTCON_CABLE_USB] = "USB",
> > > +       [EXTCON_CABLE_USB_HOST] = "USB-HOST",
> > > +       NULL,
> > > +};
> 
> I'm not exactly sure how else it is supposed to work if we
> support only a subset of cables from the global extcon_cable_name[][].

I don't see issue that we use just 2 events. I think that we can
reuse  enum extcon_cable_name and strings already defined in 
extcon_cable_name[][] global variable. It is defined extern in
extcon.h file exactly for this purpose, no?

> 
> > 
> > <snip>
> > 
> > > +
> > > +static int usb_extcon_probe(struct platform_device *pdev)
> > > +{
> > > 
> > 
> > <snip>
> > 
> > > +
> > > +       ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
> > > +                                       usb_irq_handler,
> > > +                                       IRQF_TRIGGER_RISING |
> > > +                                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > 
> > Shouldn't triggers be defined in DTS files?
> 
> Could be but we're sure that we always need the trigger for both rising/falling edges
> in this case. So the usage is more appropriately decided from application point of view
> rather than h/w point of view. h/w is generic GPIO.

No strong opinion on this. Could it be that GPIO did't support edge
triggered interrupt, but just level triggered?

Regards,
Ivan

