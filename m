From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Fri, 25 Apr 2014 20:37:10 +0200
Message-ID: <CAGm1_kvd7G0HthX1dRqRK52nDSPfDqHwAZ2EDn+CUbSpzJv-Mw@mail.gmail.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
 <535669DB.8010109@visionsystems.de> <CACQ1gAiDw3XcspRwSEEX9e9rH=qFMvyW2ic+SmugMDi8kNKEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CACQ1gAiDw3XcspRwSEEX9e9rH=qFMvyW2ic+SmugMDi8kNKEaQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Richard Genoud <noreply.rgenoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, mpfj-list@newflow.co.uk, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 25, 2014 at 4:56 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> 2014-04-22 15:08 GMT+02:00 Yegor Yefremov <yegor_sub1@visionsystems.de>:
>> On 10.03.2014 17:45, Richard Genoud wrote:
>>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>>> GPIO.
>>> This will be useful for many boards which have a serial controller that
>>> only handle CTS/RTS pins (or even just RX/TX).
>>>
>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>
>> ....
>>
>>> +
>>> +struct mctrl_gpios {
>>> +     struct gpio_desc *gpio[UART_GPIO_MAX];
>>> +};
>>> +
>>> +static const struct {
>>> +     const char *name;
>>> +     unsigned int mctrl;
>>> +     bool dir_out;
>>> +} mctrl_gpios_desc[UART_GPIO_MAX] = {
>>> +     { "cts", TIOCM_CTS, false, },
>>> +     { "dsr", TIOCM_DSR, false, },
>>> +     { "dcd", TIOCM_CD, false, },
>>> +     { "rng", TIOCM_RNG, false, },
>>> +     { "rts", TIOCM_RTS, true, },
>>> +     { "dtr", TIOCM_DTR, true, },
>>> +     { "out1", TIOCM_OUT1, true, },
>>> +     { "out2", TIOCM_OUT2, true, },
>>> +};
>>> +
>>> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>>> +{
>>> +     enum mctrl_gpio_idx i;
>>> +
>>> +     if (IS_ERR_OR_NULL(gpios))
>>> +             return;
>>> +
>>> +     for (i = 0; i < UART_GPIO_MAX; i++)
>>> +             if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
>>> +                 mctrl_gpios_desc[i].dir_out)
>>> +                     gpiod_set_value(gpios->gpio[i],
>>> +                                     !!(mctrl & mctrl_gpios_desc[i].mctrl));
>>> +}
>>> +EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>>> +
>>> +struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>>> +                                   enum mctrl_gpio_idx gidx)
>>> +{
>>> +     if (!IS_ERR_OR_NULL(gpios) && !IS_ERR_OR_NULL(gpios->gpio[gidx]))
>>> +             return gpios->gpio[gidx];
>>> +     else
>>> +             return NULL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>>> +
>>> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
>>> +{
>>> +     enum mctrl_gpio_idx i;
>>> +
>>> +     /*
>>> +      * return it unchanged if the structure is not allocated
>>> +      */
>>> +     if (IS_ERR_OR_NULL(gpios))
>>> +             return *mctrl;
>>> +
>>> +     for (i = 0; i < UART_GPIO_MAX; i++) {
>>> +             if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
>>> +                 !mctrl_gpios_desc[i].dir_out) {
>>> +                     if (gpiod_get_value(gpios->gpio[i]))
>>> +                             *mctrl |= mctrl_gpios_desc[i].mctrl;
>>> +                     else
>>> +                             *mctrl &= ~mctrl_gpios_desc[i].mctrl;
>>> +             }
>>> +     }
>>> +
>>> +     return *mctrl;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mctrl_gpio_get);
>>
>> Should this routine be renamed to msr_gpio_get() or perhaps better to give all values (inputs and outputs)?
>>
>> I'm trying to port this approach to omap-serial to implement RS485 switching. I need to know if RTS is already on or not and set it accordingly.
>>
>> What would be the best solution for this task using this new API?
> Sorry, but I don't really get what you're trying to do.
> Could you explain a little bit more ?

Never mind, I've solved this in this patch:
http://www.spinics.net/lists/arm-kernel/msg325197.html via using

gpiod_set_value() and gpiod_get_value() directly.


Yegor
