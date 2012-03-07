From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 08/13] gpio/omap: remove redundant decoding of gpio
 offset
Date: Wed, 07 Mar 2012 13:00:13 +0100
Message-ID: <4F574DCD.4000507@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1331118963-26364-9-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 07 March 2012 12:15 PM, Tarun Kanti DebBarma wrote:
> In gpio_get(), _get_gpio_datain() and _get_gpio_dataout() get rid of
> un-necessary operation to compute gpio mask. The gpio offset passed
> to gpio_get() is sufficient to do that.
> 
> Here is Russell's original comment:
> Can someone explain to me this:
> #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
> #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
> 
> static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
> {
>        void __iomem *reg = bank->base + bank->regs->datain;
> 
>        return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
> }
> 
> static int gpio_get(struct gpio_chip *chip, unsigned offset)
> {
>        struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>        void __iomem *reg = bank->base;
>        int gpio = chip->base + offset;
>        u32 mask = GPIO_BIT(bank, gpio);
> 
>        if (gpio_is_input(bank, mask))
>                return _get_gpio_datain(bank, gpio);
>        else
>                return _get_gpio_dataout(bank, gpio);
> }
> 
> Given that bank->width on OMAP is either 32 or 16, and GPIO numbers for
> any GPIO chip are always aligned to 32 or 16, why does this code bother
> adding the chips base gpio number and then modulo the width?
> 
> Surely this means if - for argument sake - you registered a GPIO chip
> with 8 lines followed by one with 16 lines, GPIO0..7 would be chip 0
> bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
> chip 1 bit 0..7.
> 
> However, if you registered a GPIO chip with 16 lines first, it would
> mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
> chip 1 bit 0..15.
> 
> Surely this kind of behaviour is not intended?
> 
> Is there a reason why the bitmask can't just be (1 << offset) where
> offset is passed into these functions as GPIO number - chip->base ?
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
