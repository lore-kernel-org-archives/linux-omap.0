From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure pendown_gpio
Date: Fri, 4 Feb 2011 18:29:23 +0530
Message-ID: <AANLkTi=xhKxLooW2BraibKYv=0Ju_so1P2UyW5YFUOVY@mail.gmail.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
	<20110203165405.GB12802@core.coreip.homeip.net>
	<20110203171953.GA13997@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:32937 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244Ab1BDM7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 07:59:24 -0500
In-Reply-To: <20110203171953.GA13997@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LW@karo-electronics.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com

On Thu, Feb 3, 2011 at 10:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>> On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>> > The ads7846 driver requests a gpio but does not currently
>> > configure it explicitly as an input. Use gpio_request_one
>> > to request and configure it at one shot.
>> >
>> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> > Cc: Dmitry Torokhov <dtor@mail.ru>
>>
>> Will apply this one, the other one is a bit messy IMO, will have to
>> think about it.
>>
>
> Something like below should do I think.
>
> --
> Dmitry
>
>
> Input: ads7846 - check proper condition when freeing gpio
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> When driver uses custom pendown detection method gpio_pendown is not
> set up and so we should not try to free it, otherwise we are presented
> with:
>
> ------------[ cut here ]------------
> WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
> Modules linked in:
> [<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>](warn_slowpath_common+0x4c/0x64)
> [<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>](warn_slowpath_null+0x18/0x1c)
> [<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>](gpio_free+0x100/0x12c)
> [<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>](ads7846_probe+0xa38/0xc5c)
> [<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>](spi_drv_probe+0x18/0x1c)
> [<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>](driver_probe_device+0xc8/0x184)
> [<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>](__driver_attach+0x68/0x8c)
> [<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>](bus_for_each_dev+0x48/0x74)
> [<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>](bus_add_driver+0xa0/0x220)
> [<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>](driver_register+0xa8/0x134)
> [<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>](do_one_initcall+0xcc/0x1a4)
> [<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>](kernel_init+0x14c/0x214)
> [<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>](kernel_thread_exit+0x0/0x8)
> ---[ end trace 4053287f8a5ec18f ]---
>
> Also rearrange ads7846_setup_pendown() to have only one exit point
> returning success.
>
> Reported-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---

Acked-by: Sourav Poddar <sourav.poddar@ti.com>
