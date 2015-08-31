From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Fix gpiochip_add() handling for deferred
 probe
Date: Mon, 31 Aug 2015 07:11:34 -0700
Message-ID: <20150831141134.GA4215@atomide.com>
References: <1440787489-15992-1-git-send-email-tony@atomide.com>
 <55E4186E.7090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E4186E.7090605@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150831 02:07]:
> Hi Tony,
> 
> On 08/28/2015 09:44 PM, Tony Lindgren wrote:
> >Currently we gpio-omap breaks if gpiochip_add() returns -EPROBE_DEFER:
> >
> >[    0.570000] gpiochip_add: GPIOs 0..31 (gpio) failed to register
> >[    0.570000] omap_gpio 48310000.gpio: Could not register gpio chip -517
> >...
> >[    3.670000] omap_gpio 48310000.gpio: Unbalanced pm_runtime_enable!
> 
> I have no objection to the patch itself.
> 
> But I curious, How have you got this error output? Was it simulated?

I ran into it when trying to get rid of all the custom initcalls
for various drivers. And especially if adding dts mappings for
gpio-ranges to try to find some solution for the 1.158 issue that
keeps me from having a mainline GPIO PM regresion test with
pinging wl12xx during off idle :)

Regards,

Tony
