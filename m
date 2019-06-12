From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 02/20] gpio: gpio-omap: fix lack of irqstatus_raw0
 for OMAP4
Date: Wed, 12 Jun 2019 09:55:59 +0200
Message-ID: <CACRpkdZdCxvFQp9xssmqToeT5FrC4quusEgJOAbYo+TxUzGujw@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-3-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-3-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Commit 384ebe1c2849 ("gpio/omap: Add DT support to GPIO driver") added
> the register definition tables to the gpio-omap driver. Subsequently to
> that commit, commit 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx()
> checks from *_runtime_resume()") added definitions for irqstatus_raw*
> registers to the legacy OMAP4 definitions, but missed the DT
> definitions.
>
> This causes an unintentional change of behaviour for the 1.101 errata
> workaround on OMAP4 platforms. Fix this oversight.
>
> Fixes: 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
