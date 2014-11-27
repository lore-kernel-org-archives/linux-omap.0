From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/8] net: can: c_can: Disable pins when CAN interface
 is down
Date: Thu, 27 Nov 2014 14:28:30 +0100
Message-ID: <CACRpkdZoLgwwMbCL1yEQPVqM1Q9NYEYGySZW12xxm4zH3Fbi+Q@mail.gmail.com>
References: <1415371762-29885-1-git-send-email-rogerq@ti.com>
	<1415371762-29885-7-git-send-email-rogerq@ti.com>
	<5464CCFF.5010004@ti.com>
	<5464D661.7080505@pengutronix.de>
	<546606F4.6020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <546606F4.6020102@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Mugunthan V N <mugunthanvnm@ti.com>, George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>Nishanth Menon <nm@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-can@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 14, 2014 at 2:43 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 11/13/2014 06:03 PM, Marc Kleine-Budde wrote:
>> On 11/13/2014 04:23 PM, Roger Quadros wrote:

>> I just stumbled over pinctrl_pm_select_sleep_state(), is it possible to
>> integrate this into runtime pm?
>>
>> http://lxr.free-electrons.com/source/drivers/pinctrl/core.c#L1282
>
> I think those functions are there for the same reason but not sure why aren't
> they used in runtime pm core.
>
> Linus W. any hints?

It is not used from PM core because there are cases where
you may want to put pins to sleep for completely PM-core
unrelated things.

Things like turning off a serial port from userspace,
for example. That should put the pins to sleep.

Yours,
Linus Walleij
