From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] memory: omap-gpmc: Don't try to save the GPMC context
Date: Wed, 5 Aug 2015 14:45:02 +0200
Message-ID: <CABxcv=mOziw-iiyWO91Bam_hvxjg8mZs1zo=MMP4XjijkDyqmA@mail.gmail.com>
References: <1438777455-28009-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438777455-28009-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Tomeu,

On Wed, Aug 5, 2015 at 2:24 PM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> ...if there isn't one already.
>

I think is better to instead splitting the subject line like this, to
change it for something that fits like "memory: omap-gpmc: Don't try
to save uninitialized GPMC context"  or "memory: omap-gpmc: Fix
gpmc_base NULL pointer dereference"

> If for some reason the GPMC device hasn't been probed yet, gpmc_base is
> going to be NULL. Because there's no context yet to be saved, just turn
> these functions into no-ops until that device gets probed.
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
> pgd = c0204000
> [00000010] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:

Also, I don't know if the kernel backtrace makes the commit message
more readable. Maybe instead you can add an explanation of who is
calling this function? That this function is called from OMAP2+
CPUidle code that tries to save the state of several IP blocks but
omap3_gpmc_{save,restore}_context() assumes that it will be called
after the probe() function has initialized gpmc_base and that might
not be true?

The patch looks good to me though so after these changes feel free to
also add my:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
