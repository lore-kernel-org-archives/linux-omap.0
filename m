From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 3/5] mfd: tps65217: Add a dependency on OF
Date: Wed, 7 Jun 2017 16:27:53 +0200
Message-ID: <CABxcv=mBXBYvi1z4pdeeA-nDuo10a1uJMe9=ZSqdRo-Q7uHQbg@mail.gmail.com>
References: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
 <1496760340-27959-4-git-send-email-j-keerthy@ti.com> <CAFqH_52OncBvwCmu6JiFSdVckky9Gqzm7ZoUNxpqF-82oO2GAw@mail.gmail.com>
 <c13efc60-d4fd-7c1a-e889-f867ebd18446@ti.com> <20170607103753.n3entu2ylxvhdax7@dell>
 <20170607103839.2bydxqxussxyahvn@dell> <41600d7d-3754-2907-151e-57fa20f88222@ti.com>
 <CAFqH_53jSPcKB8rOiODDv3Jmbrq6h3UvW+gZLSV7JFXM1j_bWA@mail.gmail.com>
 <c5b31280-28fb-3dc3-dd7b-bcd9294e5b61@ti.com> <CABxcv=mSqGOG+Z9eHhAnfw=ZR4-US_zVzvo3kNWY4o2mT_C-Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=mSqGOG+Z9eHhAnfw=ZR4-US_zVzvo3kNWY4o2mT_C-Ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Milo Kim <milo.kim@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 7, 2017 at 4:10 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

[snip]

>>
>> chip_id = (unsigned long)match->data;
>>
>
> ...but this particular driver only has a single entry in the OF table
> and so you can just do:
>
> tps->id = TPS65217;
>

In fact, it seems that the whole chip id logic can go away since no
one is using it. I see that the regulator driver checks for the chip
id value but I don't think that makes sense since the regulator
driver's probe function won't be called for other chips since they
won't match.

Best regards,
Javier
