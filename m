From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 4/6] gpio: tps65218-gpio: Add platform_device_id table
Date: Wed, 29 Jun 2016 10:56:21 +0200
Message-ID: <CACRpkdb=jz-=K-itevZtvPtHF05pKdhkSp1USaf5LzQWaxckJw@mail.gmail.com>
References: <1467117054-12943-1-git-send-email-j-keerthy@ti.com> <1467117054-12943-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1467117054-12943-5-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 28, 2016 at 2:30 PM, Keerthy <j-keerthy@ti.com> wrote:

> platform_device_id table is needed for adding the tps65218-gpio
> module to the mfd_cell array.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Changes in v4:
>
>   * Retained the compatible strings in order to interrogate the DT in the
>     normal way.

So do I just apply this or do you need it applied through another tree?

It looks standalone, should I just merge it?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
