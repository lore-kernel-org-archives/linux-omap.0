From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Fri, 5 Mar 2010 20:36:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030435E531@dbde02.ent.ti.com>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
 <1267103701-23823-2-git-send-email-srk@ti.com>
 <20100225184702.GA5125@gandalf>
 <20100226082803.GC17444@core.coreip.homeip.net>
 <FCCFB4CDC6E5564B9182F639FC3560870304194AD0@dbde02.ent.ti.com>
 <20100227090017.GI793@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100227090017.GI793@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Saturday, February 27, 2010 2:30 PM
> To: Govindarajan, Sriramakrishnan
> Cc: Felipe Balbi; linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
> interfaced to TCA6416

---snip---
> > > > I see,
> > > >
> > > > shouldn't you instead provide a gpiolib driver for tca6416 and use
> the
> > > > generic gpio_keys driver ??
> > > >
> > >
> > > Right. The fact that the driver precludes all otehr gpios from being
> > > used is a major drawback.
> 
> > [Sriram] gpio_keys implementation assumes that every key can generate
> > an interrupt to the processor and also the state machine to process
> > events will handle each line individually. Imagine if 16 keys are
> > connected to the TCA controller and you have to query(assume it is
> > polling, interrupt mode not possible - as you have single interrupt
> > line to the processor for event on any of the 16 input lines) 16 lines
> > individually over i2c bus - the associated overhead is too high.
> > Instead this implementation handles the necessary book-keeping in one
> > simple function (get status of all 16 lines in one read transaction).
> > Building on a GPIO implementation and using gpio-keys above will be
> > both clumsy and incur runtime overhead as against a direct keypad
> > driver.
> >
> > More often(as on AM3517EVM) the keypad keys are not mixed with other
> > GPIO keys. The initial implementation includes key_mask to identify
> > the keys to be used for keypad and the others are logically not
> > modified. Hence the implementation can be extended if need arises to
> > overcome this restriction.
> 
> In this case you should not build on gpio_keys at all but select some
> other keyboard as an example that smply uses keytable with set of
> keycodes, single interrupt, etc. The overhead of all gpio_keys data
> structures is not needed here.
> 
[Sriram] I am working on cleaning up the driver to use a simpler book keeping structure(move away from gpio_keys). Will post the reworked patch shortly.

---snip ---
> 
> > [Sriram] All the core logic (including I2C transactions) is
> > implemented through a work queue implementation. The ISR is slim and
> > only schedules the work queue. This also enables the implementation to
> > be easily adaptable for both interrupt/polled mode.
> >
> 
> Fair enough but you need to ensure that you do not leave irq unbalances
> (in regards to enable/disable) when you using workqueue and disabling
> interrupt in the ISR.

[Sriram] Will ensure that this is addressed appropriately (including cleanup on error conditions).

---
Sriram
