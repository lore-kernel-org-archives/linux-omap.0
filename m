From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] gpio: gpio-omap: Remove conditional pm_runtime
 handling for GPIO interrupts
Date: Thu, 11 Apr 2019 15:17:12 +0200
Message-ID: <CACRpkdbpOep1XibqX9hPnpEVFeR3MYL8ecLPjArAQzZOvGDzLQ@mail.gmail.com>
References: <20190410195113.65377-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190410195113.65377-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Russell King <rmk+kernel@armlinux.org.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 10, 2019 at 9:51 PM Tony Lindgren <tony@atomide.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm
> instead") moved interrupt using GPIO banks to idle with cpu_pm in order
> to drop the use of pm_runtime_irq_safe() in a later patch. The GPIO
> banks with no interrupts claimed are still being idled based on PM
> runtime calls. However this caused a regression for am437x suspend for
> rtc+ddr idle mode where the device cannot enter idle state as reported
> by Keerthy <j-keerthy@ti.com>.
>
> To fix the issue, we must not fail the pm_runtime callbacks. For GPIO
> interrupts, we already have irq_chip_pm_get increment the PM runtime
> use count as pointed out by Grygorii Strashko <grygorii.strashko@ti.com>.
>
> So all we need to do is remove the conditional handling in the
> runtime_suspend and resume functions and let the CPU PM notifier idle
> the GPIO banks.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Fixes: b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")
> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [tony@atomide.com: updated patch description, dropped runtime count changes]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Changes since v1:
> - Dropped PM runtime changes to increment count in omap_gpio_irq_startup
>   as that's not needed based on comments from Grygorii
>
> - Updated subject and description accordingly

Applied this v2 version.

Yours,
Linus Walleij
