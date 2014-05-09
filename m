From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] backlight: gpio-backlight: Fix warning when the GPIO is
 on a I2C chip
Date: Thu, 8 May 2014 20:09:26 -0700
Message-ID: <20140509030925.GN2198@atomide.com>
References: <20140509012454.GL2198@atomide.com>
 <004701cf6b2d$e1a39c10$a4ead430$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004701cf6b2d$e1a39c10$a4ead430$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Lee Jones' <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

* Jingoo Han <jg1.han@samsung.com> [140508 19:25]:
> On Friday, May 09, 2014 10:25 AM, Lee Jones wrote:
> > 
> > If the GPIO for the backlight is on an I2C chip, we currently
> > get nasty warnings like this during the boot:
> > 
> > WARNING: CPU: 0 PID: 6 at drivers/gpio/gpiolib.c:2364 gpiod_set_raw_value+0x40/0x4c()
> > Modules linked in:
> > CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 3.15.0-rc4-12393-gcde9f4e #400
> > Workqueue: deferwq deferred_probe_work_func
> > [<c0014cbc>] (unwind_backtrace) from [<c001191c>] (show_stack+0x10/0x14)
> > [<c001191c>] (show_stack) from [<c0566ae0>] (dump_stack+0x80/0x9c)
> > [<c0566ae0>] (dump_stack) from [<c003f61c>] (warn_slowpath_common+0x68/0x8c)
> > [<c003f61c>] (warn_slowpath_common) from [<c003f65c>] (warn_slowpath_null+0x1c/0x24)
> > [<c003f65c>] (warn_slowpath_null) from [<c02f7e10>] (gpiod_set_raw_value+0x40/0x4c)
> > [<c02f7e10>] (gpiod_set_raw_value) from [<c0308fbc>] (gpio_backlight_update_status+0x4c/0x74)
> > [<c0308fbc>] (gpio_backlight_update_status) from [<c030914c>] (gpio_backlight_probe+0x168/0x254)
> > [<c030914c>] (gpio_backlight_probe) from [<c0378fa8>] (platform_drv_probe+0x18/0x48)
> > [<c0378fa8>] (platform_drv_probe) from [<c0377c40>] (driver_probe_device+0x10c/0x238)
> > [<c0377c40>] (driver_probe_device) from [<c0376330>] (bus_for_each_drv+0x44/0x8c)
> > [<c0376330>] (bus_for_each_drv) from [<c0377afc>] (device_attach+0x74/0x8c)
> > [<c0377afc>] (device_attach) from [<c03771c4>] (bus_probe_device+0x88/0xb0)
> > [<c03771c4>] (bus_probe_device) from [<c03775c8>] (deferred_probe_work_func+0x64/0x94)
> > [<c03775c8>] (deferred_probe_work_func) from [<c00572e8>] (process_one_work+0x1b4/0x4bc)
> > [<c00572e8>] (process_one_work) from [<c00579d0>] (worker_thread+0x11c/0x398)
> > [<c00579d0>] (worker_thread) from [<c005dfd8>] (kthread+0xc8/0xe4)
> > [<c005dfd8>] (kthread) from [<c000e768>] (ret_from_fork+0x14/0x2c)
> > 
> > Fix this by using gpio_set_value_cansleep() as suggested in
> > drivers/gpio/gpiolib.c:2364. This is what the other backlight drivers
> > are also doing.
> 
> OK, I see.
> However, gpio_backlight drive can be used by a lot of gpio drivers.
> In some cases, 'can_sleep' is 'false' and gpio_set_value_cansleep()
> is unnecessary.
> 
> In my opinion, gpio_set_value_cansleep() or gpio_set_value() can be
> called selectively by 'can_sleep' value.
> 
> How about the following?
> 
> -       gpio_set_value(gbl->gpio, brightness ? gbl->active : !gbl->active);
> +       if (gpio_cansleep(gbl->gpio))
> +               gpio_set_value_cansleep(gbl->gpio,
> +                                       brightness ? gbl->active : !gbl->active);
> +       else
> +               gpio_set_value(gbl->gpio, brightness ? gbl->active : !gbl->active);

It should be always fine to use gpio_set_value_cansleep(), see your
old thread from few years ago related to another backlight driver:

https://lkml.org/lkml/2012/12/5/343

Regards,

Tony
