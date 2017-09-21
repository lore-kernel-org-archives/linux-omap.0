From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: omap_gpio_show_rev is not __init
Date: Thu, 21 Sep 2017 14:02:39 +0200
Message-ID: <CACRpkdajuXZyg547s5Jss5-gffu6yazNrWpzOOo49oQZFCSodQ@mail.gmail.com>
References: <20170916204234.725130-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170916204234.725130-1-arnd@arndb.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 16, 2017 at 10:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The probe function calls omap_gpio_show_rev(), which on most
> compilers is inlined, but on the old gcc-4.6 is not, causing
> a valid warning about the incorrect __init annotation:
>
> WARNING: vmlinux.o(.text+0x40f614): Section mismatch in reference from the function omap_gpio_probe() to the function .init.text:omap_gpio_show_rev()
> The function omap_gpio_probe() references
> the function __init omap_gpio_show_rev().
> This is often because omap_gpio_probe lacks a __init
> annotation or the annotation of omap_gpio_show_rev is wrong.
>
> This removes the __init.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied for fixes.

Yours,
Linus Walleij
