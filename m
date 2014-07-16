From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 6/6] tty: serial: Add 8250-core based omap driver
Date: Wed, 16 Jul 2014 18:30:30 +0530
Message-ID: <53C6776E.9050804@ti.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de> <1404928177-26554-7-git-send-email-bigeasy@linutronix.de> <20140710070948.GH28884@atomide.com> <53BEB5AF.7010604@linutronix.de> <20140711064151.GJ28884@atomide.com> <53C66C0D.5060501@linutronix.de> <20140716123208.GA18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140716123208.GA18374@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 July 2014 06:02 PM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140716 05:14]:
>> On 07/11/2014 08:41 AM, Tony Lindgren wrote:
>>>
>>> If the RX pin does not wake it up, you need to configure the
>>> pinctrl-single entry for it, and configure that pin as a wake-up
>>> interrupt. See the interrupts-extended entry in omap3-beagle-xm.dts.
>>
>> This does not help. Checking the manual, there is not something like
>> PIN_OFF_WAKEUPENABLE for am33xx. There is just INPUT/OUTPUT, pull
>> up/down + enabled/disabled and the mux_mode. For the interrupt, the HW
>> referenced as omap3_pmx_core touches some bits in the pinmux register
>> which do not exists on am33xx.
> 
> Right, on am33xx there's no IO chain wake-up path. AFAIK the only way
> to provide wake events on am33xx would be to mux the RX pin temporarily
> to a GPIO input. And sounds like that may work only if the GPIO is
> in the first GPIO bank that's always on. I don't know if the other
> GPIO banks on am33xx can provide wake up events.

No, they cannot.

Thanks,
Sekhar
