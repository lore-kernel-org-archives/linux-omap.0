From: Lee Jones <lee.jones@linaro.org>
Subject: Re: LED backlight on Droid 4 and others
Date: Mon, 6 Jan 2020 08:45:49 +0000
Message-ID: <20200106084549.GA14821@dell>
References: <20200105183202.GA17784@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200105183202.GA17784@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, agx@sigxcpu.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, jjhiblot@ti.com
List-Id: linux-omap@vger.kernel.org

On Sun, 05 Jan 2020, Pavel Machek wrote:

> Hi!
> 
> It would be good to get LED backlight to work in clean way for 5.6
> kernel.
> 
> As far as I can see, these are neccessary (but not enough; it does not
> work for me): lm3532 changes to register LED with of node, plus device
> tree changes for droid 4, and these generic changes:
> 
> commit d457d0c97d6d55fe3e62633791ac05d289a37d2e
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Thu Oct 3 10:28:12 2019 +0200
> 
>     backlight: add led-backlight driver
>     
>     This patch adds a led-backlight driver (led_bl), which is similar to
>     pwm_bl except the driver uses a LED class driver to adjust the
>     brightness in the HW. Multiple LEDs can be used for a single backlight.
>     
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> commit 44b7adbf0b07904e4198ae1d0a763917d1c68a23
> Author: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Date:   Thu Oct 3 10:28:10 2019 +0200
> 
>     leds: Add managed API to get a LED from a device driver
>     
>     If the LED is acquired by a consumer device with devm_led_get(), it is
>     automatically released when the device is detached.
>     
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Pavel <pavel@ucw.cz>
> 
> commit 93b98c570d7f898063ab6204e1b3950a3335dd12
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Thu Oct 3 10:28:09 2019 +0200
> 
>     leds: Add of_led_get() and led_put()
>     
>     This patch adds basic support for a kernel driver to get a LED device.
>     This will be used by the led-backlight driver.
>     
>     Only OF version is implemented for now, and the behavior is similar to
>     PWM's of_pwm_get() and pwm_put().
>     
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Pavel <pavel@ucw.cz>
> 
> [If you have an idea what else is needed, it would be welcome; it
> works for me in development tree but not in tree I'd like to
> upstream.]
> 
> Lee, would you be willing to take "backlight: add led-backlight
> driver"? Would it help if I got "leds: Add managed API to get a LED
> from a device driver" and "leds: Add of_led_get() and led_put()" into
> for_next tree of the LED subsystem?

It looks like you have an open question from Tony on v10.

Is that patch orthogonal, or are there depend{ants,encies}?

> It is kind of important as, well, phone without screen looks pretty
> much dead, and same issue hits Droid 4 and Librem 5 phones at least...
> 
> Best regards,
> 									Pavel



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
