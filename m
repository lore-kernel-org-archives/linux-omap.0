From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH v2 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Tue, 30 Mar 2010 12:23:55 +0200
Message-ID: <201003301223.57206.jkrzyszt@tis.icnet.pl>
References: <201003291619.25878.jkrzyszt@tis.icnet.pl> <201003291630.43694.jkrzyszt@tis.icnet.pl> <20100330065618.GB12764@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100330065618.GB12764@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

Tuesday 30 March 2010 08:56:19 Dmitry Torokhov wrote:
> On Mon, Mar 29, 2010 at 04:30:41PM +0200, Janusz Krzysztofik wrote:
> > The patch introduces a serio driver that supports a keyboard serial port
> > found on the Amstrad Delta videophone board.
> >
[snip]
> > +#define MAX_SCANCODE 0x84
>
> Not needed anymore?
>
[snip]
> > +		printk(KERN_WARNING
> > +				"Invalid stop bit in AMS keyboard"
> > +				" data=0x%X\r\n", data);
>
> Consider switching top dev_err(), dev_warning(), etc. Also do not split
> text strings, even if you run over 80 column limit. BTW, why "\r\n" in
> the message?
>
[snip]
> > +	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
>
> kzalloc() please.
>
[snip]
> > +		snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", "GPIO");
>
> strlcpy(serio->phys, "GPIO/serio0", sizeof(serio->phys)); ?
>
[snip]
> > +	if (gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_DATA, "kbd-data")) {
> > +		printk(KERN_ERR "Couldn't request gpio pin for keyboard data");
> > +		err = -EINVAL;
>
> Why do you mangle return value of gpio_request()? Just return what it
> reported. Same goes for request_irq() below.
>
[snip]
> > +	/* enable keyboard */
> > +	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR,
> > +			AMD_DELTA_LATCH2_KEYBRD_PWR);
>
> This shoukd probably go into open() method of the serio port.
>
[snip]
> > +	/* disable keyboard */
> > +	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR, 0);
>
> And this into close().
>

Hi Dmitry,
Thanks for your review time. I agree with all your comments and will address 
them in next version.

Regards,
Janusz
