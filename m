From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Mon, 19 Jan 2015 11:05:17 -0800
Message-ID: <54BD556D.3080206@oracle.com>
References: <1421448650-15904-1-git-send-email-tony@atomide.com> <54B9AA9D.7080300@oracle.com> <20150117010003.GP18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150117010003.GP18552@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 1/16/15 5:00 PM, Tony Lindgren wrote:
> * santosh shilimkar <santosh.shilimkar@oracle.com> [150116 16:23]:
>> On 1/16/2015 2:50 PM, Tony Lindgren wrote:
>>> Similar to omap_gpio_irq_type() let's make sure that the GPIO
>>> is usable as an interrupt if the platform init code did not
>>> call gpio_request(). Otherwise we can get invalid device access
>>> after setup_irq():
>>>
>> I let Linus W comment on it but IIRC we chewed this issue last
>> time and the conclusion was the gpio_request() must have to be called
>> directly or indirectly in case of irq line.
>
> This is a corner case where the error is triggered by a wrong,
> non-GPIO IRQ so gpio_request() will never be called before setup_irq()
> unlike for any legacy platform code.
>
> The legacy and DT cases we're already handling in the gpio-omap.c
> driver a while back with:
>
> 2f56e0a57ff1 ("gpio/omap: use gpiolib API to mark a GPIO used as an IRQ")
> fac7fa162a19 ("gpio/omap: auto-setup a GPIO when used as an IRQ")
> fa365e4d7290 ("gpio/omap: maintain GPIO and IRQ usage separately")
>
> And most of that the bank specific hacks we can get rid of by making
> the driver multple instances as that allows replacing BANK_USED
> with just runtime PM.
>
Right. Thanks for expanding it.

Regards,
Santosh

