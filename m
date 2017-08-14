From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: make regmap_irq_chip const
Date: Mon, 14 Aug 2017 16:06:58 +0200
Message-ID: <CACRpkdYsf79xkHJvqG3_LEcjyn=gmKQQn58HXkMx-jn2BecGuw@mail.gmail.com>
References: <1502518149-11663-1-git-send-email-bhumirks@gmail.com> <1502518149-11663-3-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1502518149-11663-3-git-send-email-bhumirks@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Marek Vasut <marek.vasut+renesas@gmail.com>, Lee Jones <lee.jones@linaro.org>, ext Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 12, 2017 at 8:09 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:

> Make the structure const as it is only passed to the function
> devm_regmap_add_irq_chip having the corresponding argument as const.
> Done using Coccinelle.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch applied.

Yours,
Linus Walleij
