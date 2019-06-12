From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 00/20] gpio: gpio-omap: set of fixes and big clean-up
Date: Wed, 12 Jun 2019 11:23:07 +0200
Message-ID: <CACRpkdamKFMrvfi4+L95KqJzPkX69er=CBC3ShUwj0VWArnQRg@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> This series contains set of patches from Russell King which were circulated
> internally for quite some time already and I fill it's reasonable to move
> future discussion upstream (and also avoid rebasing).
> Fisrt two patches are fixes and the rest are big, great clean up
> from Russell King.
>
> Personally, I like this clean up and refactoring very much and don't want
> it to be lost.

I share your view, it is very nice to have Russell's attention to detail
shaping up this driver.

I vaguely remember at some point wondering why we were
not using gpio-mmio.c at least partially
for this driver, as it share this characteristic of keeping a shadow
copy of the registers around and seem to have offsets from 0..n
in the registers, but I guess there is some specific
good reason for not using the library?

Yours,
Linus Walleij
