From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Fri, 26 Feb 2010 20:13:28 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304194AD0@dbde02.ent.ti.com>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
 <1267103701-23823-2-git-send-email-srk@ti.com>
 <20100225184702.GA5125@gandalf>
 <20100226082803.GC17444@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40758 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875Ab0BZOnj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 09:43:39 -0500
In-Reply-To: <20100226082803.GC17444@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, February 26, 2010 1:58 PM
> To: Felipe Balbi
> Cc: Govindarajan, Sriramakrishnan; linux-omap@vger.kernel.org; linux-
> input@vger.kernel.org
> Subject: Re: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
> interfaced to TCA6416
> 
> On Thu, Feb 25, 2010 at 08:47:03PM +0200, Felipe Balbi wrote:
> > Hi,
> >
> > On Thu, Feb 25, 2010 at 06:44:59PM +0530, Sriramakrishnan wrote:
> > > This patch implements a simple Keypad driver that functions
> > > as an I2C client. It handles key press events for keys
> > > connected to TCA6416 I2C based IO expander.
> >
> > what's wrong with gpio-keys ??
> >
> > > + * Implementation based on drivers/input/keyboard/gpio_keys.c
> >
> > I see,
> >
> > shouldn't you instead provide a gpiolib driver for tca6416 and use the
> > generic gpio_keys driver ??
> >
> 
> Right. The fact that the driver precludes all otehr gpios from being
> used is a major drawback.
[Sriram] gpio_keys implementation assumes that every key can generate an interrupt to the processor and also the state machine to process events will handle each line individually. Imagine if 16 keys are connected to the TCA controller and you have to query(assume it is polling, interrupt mode not possible - as you have single interrupt line to the processor for event on any of the 16 input lines) 16 lines individually over i2c bus - the associated overhead is too high. Instead this implementation handles the necessary book-keeping in one simple function (get status of all 16 lines in one read transaction). Building on a GPIO implementation and using gpio-keys above will be both clumsy and incur runtime overhead as against a direct keypad driver.

More often(as on AM3517EVM) the keypad keys are not mixed with other GPIO keys. The initial implementation includes key_mask to identify the keys to be used for keypad and the others are logically not modified. Hence the implementation can be extended if need arises to overcome this restriction.
> 
> 
> > > +	if (!chip->use_polling) {
> >
> > IMO, you should only use polling if the irq line isn't connected.
> >
> > > +		if (pdata->irq_is_gpio)
> > > +			chip->irqnum = gpio_to_irq(pdata->irqnum);
> >
> > you can pass the irq number via i2c_board_info. Use it.
> >
> > > +		else
> > > +			chip->irqnum = pdata->irqnum;
> > > +
> > > +		ret = request_irq(chip->irqnum, tca6416_keys_isr,
> >
> > it's an i2c driver!!! this should be request_threaded_irq()
> >
> 
> Threaded IRQ probably does not fit well when you want to support both
> interrupt and polling in the same driver...
[Sriram] All the core logic (including I2C transactions) is implemented through a work queue implementation. The ISR is slim and only schedules the work queue. This also enables the implementation to be easily adaptable for both interrupt/polled mode.

