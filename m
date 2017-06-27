From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/9] Drop unnecessary static
Date: Tue, 27 Jun 2017 16:47:37 -0700
Message-ID: <CAGXu5jK+oz7SoBKmHDjUpmZ96=keiou+75WK2or37Z8RL9jLxA@mail.gmail.com>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Linux PM list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux mtd <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com, linux-omap@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 4, 2017 at 1:10 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is either first initialized or never used, on every possible
> execution path through the function.  The static has no benefit, and
> dropping it reduces the code size.
>
> ---
>
>  drivers/block/drbd/drbd_nl.c            |    2 +-
>  drivers/clocksource/timer-fttmr010.c    |    2 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
>  drivers/mfd/max8925-i2c.c               |    2 +-
>  drivers/mfd/twl4030-irq.c               |    2 +-
>  drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
>  drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
>  drivers/power/supply/axp20x_usb_power.c |    2 +-
>  drivers/regulator/palmas-regulator.c    |    2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

It looks like most of these were taken. I pinged the other three. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
