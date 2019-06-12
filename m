From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 05/20] gpio: gpio-omap: remove irq_ack method
Date: Wed, 12 Jun 2019 10:42:54 +0200
Message-ID: <CACRpkdbaXFZQ3d8pQJAxd2WaCJQbBHZZ4XKS3ovrq=ZOmP8o7w@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-6-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-6-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The irq_ack method does not fit our hardware requirements. Edge
> interrupts must be cleared before we handle them, and level interrupts
> must be cleared after handling them.
>
> We handle the interrupt clearance in our interrupt handler for edge IRQs
> and in the unmask method for level IRQs.
>
> Replace the irq_ack method with the no-op method from the dummy irq
> chip.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
