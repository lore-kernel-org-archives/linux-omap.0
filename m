From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED
 device
Date: Thu, 29 Nov 2018 12:02:00 -0800
Message-ID: <20181129200200.GA53235@atomide.com>
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
 <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-leds@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [181114 12:51]:
> On Tue, Nov 6, 2018 at 12:22 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Global GPIO numbers no longer have to be passed to leds-gpio driver,
> > replace their assignment with a lookup table.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Excellent Janusz! :)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applying into omap-for-v4.21/omap1 thanks.

Tony
