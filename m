From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] gpio/omap: use gpiolib API to mark a GPIO used as an IRQ
Date: Wed, 16 Oct 2013 10:06:52 +0200
Message-ID: <CACRpkdYWtgExaaFZ_nV_yX43FXpMCeskjGtKMyVySd+awuepOQ@mail.gmail.com>
References: <1381884450-2358-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1381884450-2358-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 16, 2013 at 2:47 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> The OMAP GPIO driver keeps track about GPIO pins that are
> used as IRQ lines for two reasons:
>
> 1) To prevent GPIO banks to be disabled while one of their
>    GPIO pins are only used as an interrupt line.
>
> 2) To not allow another caller to set the GPIO pin as output.
>
> Now gpiolib has an API to mark GPIO pins as used as IRQ lines
> so the GPIO core only allows to set as output GPIO pins not
> tied to an IRQ. So there is no need to have custom code for 2).
>
> The IRQ usage still has to be maintained locally for 1) though.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Patch applied. I had to merge in v3.12-rc4 to get the dependency
fixes, so I guess you did something similar when developing
this...

Yours,
Linus Walleij
