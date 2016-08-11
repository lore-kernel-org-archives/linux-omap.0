From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 1/5] mfd: tps65218: Remove redundant read wrapper
Date: Thu, 11 Aug 2016 14:10:24 +0200
Message-ID: <CACRpkdbLXDknZpVbofFC7dBb_4hLaurScXBDzL_xGtD+8AcBLA@mail.gmail.com>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com> <1470833545-29462-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1470833545-29462-2-git-send-email-j-keerthy@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Russ Dill <russ.dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 10, 2016 at 2:52 PM, Keerthy <j-keerthy@ti.com> wrote:

> Currently read directly calls the repmap read function. Hence
> remove the redundant wrapper and use regmap read wherever
> needed.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume an immutable branch will not be needed for this,
this small changed "should not" collide with anything in
my tree (famous last words)...

Yours,
Linus Walleij
