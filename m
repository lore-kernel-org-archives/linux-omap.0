From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
Date: Thu, 11 Oct 2018 15:42:38 +0200
Message-ID: <CAPybu_1PuRqOx-Fsmba4XCcRsJA0A9tdob1R=8N72-699cxomw@mail.gmail.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <9746eba6-63f5-feaf-e63f-7e0ea7638942@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9746eba6-63f5-feaf-e63f-7e0ea7638942@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Timur Tabi <timur@kernel.org>, Stephen Boyd <swboyd@chromium.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeffrey Hugo <jhugo@codeaurora.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Vignesh

Ups, it does not look too good :S . Can you check if this change fixes it:

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e016b22658ff..bcd0ef49ce97 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1349,6 +1349,9 @@ int gpiochip_add_data_with_key(struct gpio_chip
*chip, void *data,

        spin_unlock_irqrestore(&gpio_lock, flags);

+       for (i = 0; i < chip->ngpio; i++)
+               gdev->descs[i].gdev = gdev;
+
 #ifdef CONFIG_PINCTRL
        INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -1380,8 +1383,6 @@ int gpiochip_add_data_with_key(struct gpio_chip
*chip, void *data,
        for (i = 0; i < chip->ngpio; i++) {
                struct gpio_desc *desc = &gdev->descs[i];

-               desc->gdev = gdev;
-
                if (chip->get_direction && gpiochip_line_is_valid(chip, i))
                        desc->flags = !chip->get_direction(chip, i) ?
                                        (1 << FLAG_IS_OUT) : 0;


Thanks!
On Thu, Oct 11, 2018 at 2:18 PM Vignesh R <vigneshr@ti.com> wrote:
>
> Hi,
>
> On Friday 05 October 2018 12:23 PM, Ricardo Ribalda Delgado wrote:
> > Current code assumes that the direction is input if direction_input
> > function is set.
> > This might not be the case on GPIOs with programmable direction.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>
> This patch causes oops on TI's AM335x-ICEv2 board on next-20181011:
>
> [    0.563797] OMAP GPIO hardware version 0.1
> [    0.577589] Unable to handle kernel NULL pointer dereference at virtual address 000002b8
> [    0.586127] pgd = (ptrval)
> [    0.588934] [000002b8] *pgd=00000000
> [    0.592732] Internal error: Oops: 5 [#1] SMP ARM
> [    0.597499] Modules linked in:
> [    0.600668] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-next-20181011 #70
> [    0.608466] Hardware name: Generic AM33XX (Flattened Device Tree)
> [    0.614770] PC is at gpiod_hog+0x30/0x154
> [    0.618913] LR is at of_gpiochip_add+0x2fc/0x4e4
> [    0.623671] pc : [<c055213c>]    lr : [<c0553ff0>]    psr: 60000013
> [    0.630130] sp : ce09bba0  ip : cdf08095  fp : 00000000
> [    0.635516] r10: c0bfcf24  r9 : 00000000  r8 : 00000007
> [    0.640902] r7 : cdf08088  r6 : 00000000  r5 : 00000000  r4 : ce191e40
> [    0.647630] r3 : 00000000  r2 : 00000000  r1 : cdf08088  r0 : ce191e40
> [    0.654361] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    0.661718] Control: 10c5387d  Table: 80004019  DAC: 00000051
> [    0.667642] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> [...]
> [    0.973593] [<c055213c>] (gpiod_hog) from [<c0553ff0>] (of_gpiochip_add+0x2fc/0x4e4)
> [    0.981588] [<c0553ff0>] (of_gpiochip_add) from [<c05528a0>] (gpiochip_add_data_with_key+
> 0x5a0/0x990)
> [    0.991102] [<c05528a0>] (gpiochip_add_data_with_key) from [<c0556d8c>] (omap_gpio_probe+
> 0x37c/0x75c)
> [    1.000613] [<c0556d8c>] (omap_gpio_probe) from [<c06049c0>] (platform_drv_probe+0x48/0x9
> 8)
> [    1.009237] [<c06049c0>] (platform_drv_probe) from [<c0602a04>] (really_probe+0x220/0x2d4
> )
> [    1.017764] [<c0602a04>] (really_probe) from [<c0602c18>] (driver_probe_device+0x5c/0x164
> )
> [    1.026293] [<c0602c18>] (driver_probe_device) from [<c0600d44>] (bus_for_each_drv+0x54/0
> xb8)
> [    1.035090] [<c0600d44>] (bus_for_each_drv) from [<c060276c>] (__device_attach+0xcc/0x13c
> )
> [    1.043615] [<c060276c>] (__device_attach) from [<c0601b88>] (bus_probe_device+0x88/0x90)
> [    1.052051] [<c0601b88>] (bus_probe_device) from [<c05fea18>] (device_add+0x3d8/0x608)
> [    1.060223] [<c05fea18>] (device_add) from [<c07343b8>] (of_platform_device_create_pdata+
> 0x8c/0xc0)
> [    1.069552] [<c07343b8>] (of_platform_device_create_pdata) from [<c07345c4>] (of_platform
> _bus_create+0x190/0x228)
> [    1.080134] [<c07345c4>] (of_platform_bus_create) from [<c0734610>] (of_platform_bus_crea
> te+0x1dc/0x228)
> [    1.089909] [<c0734610>] (of_platform_bus_create) from [<c073478c>] (of_platform_populate
> +0x5c/0xac)
> [    1.099333] [<c073478c>] (of_platform_populate) from [<c0d12614>] (pdata_quirks_init+0x6c
> /0x90)
> [    1.108306] [<c0d12614>] (pdata_quirks_init) from [<c0d12144>] (omap_generic_init+0xc/0x1
> 8)
> [    1.116933] [<c0d12144>] (omap_generic_init) from [<c0d03eb0>] (customize_machine+0x1c/0x
> 30)
> [    1.125645] [<c0d03eb0>] (customize_machine) from [<c01030e4>] (do_one_initcall+0x80/0x31
> 0)
> [    1.134265] [<c01030e4>] (do_one_initcall) from [<c0d01244>] (kernel_init_freeable+0x3c4/
> 0x4ac)
> [    1.143238] [<c0d01244>] (kernel_init_freeable) from [<c0900f28>] (kernel_init+0x8/0x114)
> [    1.151673] [<c0900f28>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> [    1.159475] Exception stack(0xce09bfb0 to 0xce09bff8)
> [    1.164686] bfa0:                                     00000000 00000000 00000000 00000000
> [    1.173119] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.181551] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.188378] Code: 0a000002 e3530000 01a09003 159392b4 (e59352b8)
> [    1.194766] ---[ end trace d5c17cd400f50a22 ]---
> [    1.199606] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.199606]
> [    1.209052] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000
> 00b
> [    1.209052]  ]---
> [    3.172292] random: fast init done
>
> Full log: https://pastebin.ubuntu.com/p/jG8nN6CTBP/
>
> Reverting this patch from linux-next allows to boot to prompt.
>
> Regards
> Vignesh
>
> > ---
> >  drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 907019b67a58..e016b22658ff 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1349,20 +1349,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
> >
> >       spin_unlock_irqrestore(&gpio_lock, flags);
> >
> > -     for (i = 0; i < chip->ngpio; i++) {
> > -             struct gpio_desc *desc = &gdev->descs[i];
> > -
> > -             desc->gdev = gdev;
> > -
> > -             /* REVISIT: most hardware initializes GPIOs as inputs (often
> > -              * with pullups enabled) so power usage is minimized. Linux
> > -              * code should set the gpio direction first thing; but until
> > -              * it does, and in case chip->get_direction is not set, we may
> > -              * expose the wrong direction in sysfs.
> > -              */
> > -             desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
> > -     }
> > -
> >  #ifdef CONFIG_PINCTRL
> >       INIT_LIST_HEAD(&gdev->pin_ranges);
> >  #endif
> > @@ -1391,6 +1377,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
> >       if (status)
> >               goto err_remove_chip;
> >
> > +     for (i = 0; i < chip->ngpio; i++) {
> > +             struct gpio_desc *desc = &gdev->descs[i];
> > +
> > +             desc->gdev = gdev;
> > +
> > +             if (chip->get_direction && gpiochip_line_is_valid(chip, i))
> > +                     desc->flags = !chip->get_direction(chip, i) ?
> > +                                     (1 << FLAG_IS_OUT) : 0;
> > +             else
> > +                     desc->flags = !chip->direction_input ?
> > +                                     (1 << FLAG_IS_OUT) : 0;
> > +     }
> > +
> >       acpi_gpiochip_add(chip);
> >
> >       machine_gpiochip_add(chip);
> >
>


-- 
Ricardo Ribalda
