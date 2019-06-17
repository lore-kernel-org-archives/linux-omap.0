From: grygorii <grygorii.strashko@ti.com>
Subject: Re: [PATCH-next 20/20] gpio: gpio-omap: clean up register access in
 omap2_set_gpio_debounce()
Date: Mon, 17 Jun 2019 21:57:13 +0300
Message-ID: <0ab98094-f8b2-69a3-e73c-1dfdf812d627@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
 <20190610171103.30903-21-grygorii.strashko@ti.com>
 <CACRpkda2FhYNYA2TkVANOF5GWd3hE9cqM7N_pFDFj9nh-fh=iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda2FhYNYA2TkVANOF5GWd3hE9cqM7N_pFDFj9nh-fh=iA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org



On 12/06/2019 12:11, Linus Walleij wrote:
> On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> From: Russell King <rmk+kernel@armlinux.org.uk>
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Patch applied.

Thanks Linus.

> 
> At your convenience please look at the debounce function a bit
> closer because I think there is a bug/unpredictable behavior:
> 
> IIUC the whole bank/block of GPIOs share the same debounce
> timer setting, and it is currently handled in a "last caller wins"
> manner, so if the different GPIOs in the bank has different
> debounce settings, the call order decides what debounce time
> is used across all of them.

Yeah. this is a "known" problem :(

> 
> In drivers/gpio/gpio-ftgpio.c function ftgpio_gpio_set_config()
> I simply reject a dounce time setting
> different from the currently configured if any GPIOs are
> currently using the deounce feature.
> 
> (It's the semantic I came up with but maybe there are other
> ideas here.)


There is one more patch in int. queue for debounce, but I've
decided to send it after this series as OMAP debounce changes are
usually debatable.

I'll look at gpio-ftgpio also.

By the way, there seems no ABI for debounce cfg in gpio_dev interface.
(or i'm missing smth?)

-- 
Best regards,
grygorii
