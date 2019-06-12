From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv3] gpio: gpio-omap: Fix lost edge wake-up interrupts
Date: Wed, 12 Jun 2019 14:32:43 +0200
Message-ID: <CACRpkdam8pMztF9=yL2rWGFqjUnURf5x=v40x7UKVEwXwZ5anA@mail.gmail.com>
References: <20190612063352.5760-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190612063352.5760-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Russell King <rmk+kernel@armlinux.org.uk>, Ladislav Michl <ladis@linux-mips.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 12, 2019 at 8:34 AM Tony Lindgren <tony@atomide.com> wrote:

> If an edge interrupt triggers while entering idle just before we save
> GPIO datain register to saved_datain, the triggered GPIO will not be
> noticed on wake-up. This is because the saved_datain and GPIO datain
> are the same on wake-up in omap_gpio_unidle(). Let's fix this by
> ignoring any pending edge interrupts for saved_datain.
>
> This issue affects only idle states where the GPIO module internal
> wake-up path is operational. For deeper idle states where the GPIO
> module gets powered off, Linux generic wakeirqs must be used for
> the padconf wake-up events with pinctrl-single driver. For examples,
> please see "interrupts-extended" dts usage in many drivers.
>
> This issue can be somewhat easily reproduced by pinging an idle system
> with smsc911x Ethernet interface configured IRQ_TYPE_EDGE_FALLING. At
> some point the smsc911x interrupts will just stop triggering. Also if
> WLCORE WLAN is used with EDGE interrupt like it's documentation specifies,
> we can see lost interrupts without this patch.
>
> Note that in the long run we may be able to cancel entering idle by
> returning an error in gpio_omap_cpu_notifier() on pending interrupts.
> But let's fix the bug first.
>
> Also note that because of the recent clean-up efforts this patch does
> not apply directly to older kernels. This does fix a long term issue
> though, and can be backported as needed.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

Let's see if this nails it.

Yours,
Linus Walleij
