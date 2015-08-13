From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: Fix missing raw locks conversion
Date: Thu, 13 Aug 2015 14:44:56 +0200
Message-ID: <CACRpkdZOTE2gY20N9SzVxPYxRroaARHYeJJnPtLFZ+r0hg78Zw@mail.gmail.com>
References: <1438785461.9624.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1438785461.9624.1.camel@ingics.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 5, 2015 at 4:37 PM, Axel Lin <axel.lin@ingics.com> wrote:

> Fix below build warning:
>   CC      drivers/gpio/gpio-omap.o
> drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_type':
> drivers/gpio/gpio-omap.c:504:3: warning: passing argument 1 of 'spin_unlock_irqrestore' from incompatible pointer type [enabled by default]
> include/linux/spinlock.h:360:29: note: expected 'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'
>
> Fixes: commit 4dbada2be460 ("gpio: omap: use raw locks for locking")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Fixed by merging in -rc4 and applying this patch for next.

Thanks!

Yours,
Linus Walleij
