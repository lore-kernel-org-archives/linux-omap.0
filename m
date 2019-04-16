From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED
 support is disabled
Date: Tue, 16 Apr 2019 07:44:12 -0700
Message-ID: <20190416144412.GF2839@atomide.com>
References: <20190415233732.3612-1-aaro.koskinen@iki.fi>
 <20190416071420.GA14538@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416071420.GA14538@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190416 07:14]:
> On Tue 2019-04-16 02:37:32, Aaro Koskinen wrote:
> > When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
> > gpio_led_register_device() will return a NULL pointer and we try
> > to dereference it. Fix by checking also for a NULL pointer.
> > 
> > Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device")
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v5.1/fixes thanks.

Tony
