From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RESEND PATCH] gpio: omap: Fix interrupt names
Date: Wed, 17 Sep 2014 17:36:15 +0200
Message-ID: <CABxcv=k1vz2-hi34mGBGNjuYorrppW1Zez0xmASWDAdKgN4Dhg@mail.gmail.com>
References: <1409946775-24076-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1409946775-24076-1-git-send-email-nm@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Linus,

On Fri, Sep 5, 2014 at 9:52 PM, Nishanth Menon <nm@ti.com> wrote:
> When viewing the /proc/interrupts, there is no information about which
> GPIO bank a specific gpio interrupt is hooked on to. This is more than a
> bit irritating as such information can esily be provided back to the
> user and at times, can be crucial for debug.
>
> So, instead of displaying something like:
> 31:     0       0  GPIO   0  palmas
> 32:     0       0  GPIO  27  mmc0
>
> Display the following with appropriate device name:
> 31:     0       0  4ae10000.gpio   0  palmas
> 32:     0       0  4805d000.gpio  27  mmc0
>
> This requires that we create irq_chip instance specific for each GPIO
> bank which is trivial to achieve.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> ---
> Requested to be resend by Javier with linux-gpio maintainers in CC.
>
> Original V1 of the patch: https://patchwork.kernel.org/patch/4757891/
>
> Probably belongs to 3.18 kernel series at this point in time.
>

I've no other patches for the GPIO OMAP driver for 3.18, could you
please pick this patch?

Thanks a lot and best regards,
Javier
