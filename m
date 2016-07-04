From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 3/3] gpio: lp873x: Add support for General Purpose Outputs
Date: Mon, 4 Jul 2016 13:22:38 +0200
Message-ID: <CACRpkdZ-gcedMc53V8LZm3vhhd+n0PPudF_fSd_5kSmKX3obkg@mail.gmail.com>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com> <1467215067-6486-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467215067-6486-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 29, 2016 at 5:44 PM, Keerthy <j-keerthy@ti.com> wrote:

> Add driver for lp873x PMIC family GPOs. Two GPOs are supported
> and can be configured in Open-drain output or Push-pull output.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Looks all right to me.

> +#include <linux/mfd/lp873x.h>

I guess this means Lee must merge this.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
