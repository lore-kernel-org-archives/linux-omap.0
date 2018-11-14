From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
Date: Wed, 14 Nov 2018 13:51:23 +0100
Message-ID: <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-leds@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 6, 2018 at 12:22 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Global GPIO numbers no longer have to be passed to leds-gpio driver,
> replace their assignment with a lookup table.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Excellent Janusz! :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
