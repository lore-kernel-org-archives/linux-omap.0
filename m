From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [RESEND PATCH] gpio: omap: Fix interrupt names
Date: Fri, 19 Sep 2014 16:27:12 +0900
Message-ID: <CAAVeFuLfBataUkhj=jq7xsZZ8iiSK4dyPYW2hLHRwz-OaL9NhQ@mail.gmail.com>
References: <1409946775-24076-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409946775-24076-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 6, 2014 at 4:52 AM, Nishanth Menon <nm@ti.com> wrote:
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

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
