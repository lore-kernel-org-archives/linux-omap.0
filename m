From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH REPOST] gpio: omap: use raw locks for locking
Date: Tue, 7 Jul 2015 11:58:00 +0300
Message-ID: <559B9498.5060405@ti.com>
References: <20150619170654.GA4937@linutronix.de> <5584547B.9040203@oracle.com> <CABxcv==5Fo-x9CdSu6BYNfBpAS7rp63fHA319J_KvWZZG9q=ng@mail.gmail.com> <20150622070821.GB4156@atomide.com> <559275B9.3040909@ti.com> <5592C5A2.5050809@linutronix.de> <20150701073205.GT4156@atomide.com> <20150701112928.GW4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150701112928.GW4156@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony, Sebastian,

On 07/01/2015 02:29 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150701 00:34]:
>>
>> This should be OK for most cases as the GPIO interrupt devices are
>> typically on some external bus like I2C or GPMC. The hurting case
>> would be bitbanging GPIO devices, like the CBUS I2C driver.
>
> Thinking about it the CBUS I2C driver does not need interrupts
> for the bitbanging part either :)
>
> So I think we can just make it threaded IRQ for GPIO.
>

Thanks for your comments, I'll try to do patch to make
GPIO IRQ threaded (may be as option).


-- 
regards,
-grygorii
