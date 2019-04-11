From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: gpio-omap: configure edge detection for level IRQs
 for idle wakeup
Date: Thu, 11 Apr 2019 15:13:59 +0200
Message-ID: <CACRpkdbLysgQOsKRyUQqJCWZUvynTxFD=ejhdY1ot3BBBYyQQw@mail.gmail.com>
References: <20190408194653.26012-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190408194653.26012-1-tony@atomide.com>
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

On Mon, Apr 8, 2019 at 9:46 PM Tony Lindgren <tony@atomide.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The GPIO block can enter idle independently of the CPU power management
> calls via smart-idle.  When the GPIO block enters idle, level detection
> stops working due to clocks being shut off, and an alternative form of
> edge detection is used.  However, this needs the edge detection
> registers set to mark the appropriate edges.
>
> Arrange to configure the edge detection enables along with the level
> detection to ensure that any transition to active interrupt state that
> occurs while the block is idle is detected as a wake-up event.
>
> Since we enable the edge detection when configuring the IRQ, both
> omap2_gpio_enable_level_quirk() nor omap2_gpio_disable_level_quirk()
> become redundant, which also means OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER
> can be removed. This can be now done without regressions as patch
> "gpio: gpio-omap: fix level interrupt idling" allows level interrupts
> to idle on omap4 without a workaround.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [tony@atomide.com: update description for the fix dependency]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

Yours,
Linus Walleij
