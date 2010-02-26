From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Fri, 26 Feb 2010 00:28:04 -0800
Message-ID: <20100226082803.GC17444@core.coreip.homeip.net>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
 <1267103701-23823-2-git-send-email-srk@ti.com>
 <20100225184702.GA5125@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100225184702.GA5125@gandalf>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Sriramakrishnan <srk@ti.com>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 25, 2010 at 08:47:03PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 25, 2010 at 06:44:59PM +0530, Sriramakrishnan wrote:
> > This patch implements a simple Keypad driver that functions
> > as an I2C client. It handles key press events for keys
> > connected to TCA6416 I2C based IO expander.
> 
> what's wrong with gpio-keys ??
> 
> > + * Implementation based on drivers/input/keyboard/gpio_keys.c
> 
> I see,
> 
> shouldn't you instead provide a gpiolib driver for tca6416 and use the
> generic gpio_keys driver ??
> 

Right. The fact that the driver precludes all otehr gpios from being
used is a major drawback.


> > +	if (!chip->use_polling) {
> 
> IMO, you should only use polling if the irq line isn't connected.
> 
> > +		if (pdata->irq_is_gpio)
> > +			chip->irqnum = gpio_to_irq(pdata->irqnum);
> 
> you can pass the irq number via i2c_board_info. Use it.
> 
> > +		else
> > +			chip->irqnum = pdata->irqnum;
> > +
> > +		ret = request_irq(chip->irqnum, tca6416_keys_isr,
> 
> it's an i2c driver!!! this should be request_threaded_irq()
> 

Threaded IRQ probably does not fit well when you want to support both
interrupt and polling in the same driver...

-- 
Dmitry
