From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 23 Oct 2012 12:29:28 +0200
Message-ID: <CACRpkdb+f44jw1vTYvJT0bnMOP8XQe8ztDUHiwtS2JHtPWAGXw@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
	<20121022155028.GA13791@core.coreip.homeip.net>
	<CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
	<508664CA.7000601@ti.com>
	<CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
	<20121023100333.GA24418@arwen.pp.htv.fi>
	<20121023122312.56b23e1c@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121023122312.56b23e1c@skate>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>
Cc: balbi@ti.com, Benoit Cousson <b-cousson@ti.com>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 23, 2012 at 12:23 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
>
> On Tue, 23 Oct 2012 13:03:33 +0300, Felipe Balbi wrote:
>
>> > But it appears that shmobile prefer to get all resources using
>> > bus notifiers.
>> >
>> > So we need to form some kind of consensus ... or live with
>> > the fact that different systems do it different ways. Which will
>> > explode the day we need to use a driver on two systems,
>> > each using the other approach :-)
>>
>> I much prefer having drivers explicitly manage all their resources,
>> which would mean that pinctrl calls need to be done on probe() and, if
>> necessary, during suspend()/resume().
>>
>> Using bus notifiers for that is quite a hack IMHO.
>
> Agreed. Just like drivers do their ioremap, request_irq and others,
> they should also request their pin resources using the pinctrl API.
> Hiding this behind a bus notifier is not nice.

So the biggest implementation of the notifier approach to resource
handling is the SH clock thing:
drivers/base/power/clock_ops.c

It's made to be generic but AFAICT only SH is using this.

So according to that paradigm most device resources should
be handled that way if I understand correctly the basic idea.

So let's get Rafael, Paul and Magnus in here to beat us up
a bit :-)

Yours,
Linus Walleij
