From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v5 3/3] gpio: lp873x: Add support for General Purpose
 Outputs
Date: Tue, 5 Jul 2016 10:19:16 +0530
Message-ID: <577B3C4C.1090008@ti.com>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
 <1467215067-6486-4-git-send-email-j-keerthy@ti.com>
 <CACRpkdZ-gcedMc53V8LZm3vhhd+n0PPudF_fSd_5kSmKX3obkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ-gcedMc53V8LZm3vhhd+n0PPudF_fSd_5kSmKX3obkg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On Monday 04 July 2016 04:52 PM, Linus Walleij wrote:
> On Wed, Jun 29, 2016 at 5:44 PM, Keerthy <j-keerthy@ti.com> wrote:
>
>> Add driver for lp873x PMIC family GPOs. Two GPOs are supported
>> and can be configured in Open-drain output or Push-pull output.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> Looks all right to me.
>
>> +#include <linux/mfd/lp873x.h>
>
> I guess this means Lee must merge this.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus!

>
> Yours,
> Linus Walleij
>
