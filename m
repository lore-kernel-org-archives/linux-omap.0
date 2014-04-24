From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3] gpio: omap: implement get_direction
Date: Thu, 24 Apr 2014 09:29:52 -0400
Message-ID: <535911D0.3020907@ti.com>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com> <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, yegorslists@googlemail.com, Kevin Hilman <khilman@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 24 April 2014 09:13 AM, Linus Walleij wrote:
> On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:
> 
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch implements gpio_chip's get_direction() routine, that
>> lets other drivers get particular GPIOs direction using
>> struct gpio_desc.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> Changes:
>>         v3: get rid of _get_gpio_direction() (Linus Walleij)
>>         v2: rework return value calculation
> 
> Looks good to me, Kevin, Santosh?
> 
Looks fine to me as well.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> Part of me wants to list Javier as maintainer for this driver.
> 
Am ok with it as well.

