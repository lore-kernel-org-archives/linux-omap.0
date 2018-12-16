From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: gpio-omap: Revert deferred wakeup quirk handling
 for regressions
Date: Sun, 16 Dec 2018 01:10:11 +0100
Message-ID: <CACRpkdZU768jeD0MS1kqX29W2gfmaQ5Oigt1LDWrJjwrNoV0Pg@mail.gmail.com>
References: <20181207190829.57864-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207190829.57864-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Ladislav Michl <ladis@linux-mips.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 7, 2018 at 8:08 PM Tony Lindgren <tony@atomide.com> wrote:

> Commit ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
> based SoCs") attempted to fix omap4 GPIO wakeup handling as it was
> blocking deeper SoC idle states. However this caused a regression for
> GPIOs during runtime having over second long latencies for Ethernet
> GPIO interrupt as reportedy by Russell King <rmk+kernel@armlinux.org.uk>.
>
> Let's fix this issue by doing a partial revert of the breaking commit.
> We still want to keep the quirk handling around as it is also used for
> OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER.
>
> The real fix for omap4 GPIO wakeup handling involves fixes for
> omap_set_gpio_trigger() and omap_gpio_unmask_irq() and will be posted
> separately. And we must keep the wakeup bit enabled during runtime
> because of module doing clock autogating with autoidle configured.
>
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Fixes: ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
> based SoCs")
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied for fixes.

Yours,
Linus Walleij
