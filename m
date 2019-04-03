From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
Date: Wed, 3 Apr 2019 23:33:05 +0700
Message-ID: <CACRpkdb-x0wja_k7r_Dj0VO8E-TEE2_iebswBnvEoA-Ghddiug@mail.gmail.com>
References: <20190307103348.1591457-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307103348.1591457-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Nick Desaulniers <ndesaulniers@google.com>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 7, 2019 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:

> clang warns about a tentative array definition in the gpio-omap driver:
>
> drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id omap_gpio_match[];
>
> It's best to just reorder the entire file to avoid forward declarations,
> which lets us use the regular declaration. To do this, the unnecessary
> CONFIG_OF check must also be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
