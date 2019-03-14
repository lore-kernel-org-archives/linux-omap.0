From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
Date: Thu, 14 Mar 2019 12:58:06 +0200
Message-ID: <e15686f1-7ec7-194f-d5f2-0892964f91c5@ti.com>
References: <20190307103348.1591457-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307103348.1591457-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On 07.03.19 12:33, Arnd Bergmann wrote:
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
> ---
>  drivers/gpio/gpio-omap.c | 549 +++++++++++++++++++--------------------
>  1 file changed, 267 insertions(+), 282 deletions(-)

Sry, for delayed reply

I do not have objection to the patch itself, so
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

but personally i do not like such changes as they kill "git blame" :(,


I assume there would be merge conflict with 
https://lkml.org/lkml/2019/3/11/945


-- 
Best regards,
grygorii
