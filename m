From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 08/22] gpio/omap: further cleanup using wakeup_status
	register
Date: Tue, 23 Aug 2011 18:32:36 +0530
Message-ID: <4E53A4EC.5060107@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1312455893-14922-9-git-send-email-tarun.kanti@ti.com>
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
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Wakeup istatus register offset initialized according to OMAP versions
/s/ istatus / status

> during device registration. Use this to avoid version checks.
> Starting with OMAP4, legacy registers should not be used in combination
> with the updated regsiters. Use wkup_status register consistently for
> all SoCs wherever applicable.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap1/gpio16xx.c         |    1 +
>   arch/arm/mach-omap2/gpio.c             |    2 +
>   arch/arm/plat-omap/include/plat/gpio.h |    1 +
>   drivers/gpio/gpio-omap.c               |  109 ++++++--------------------------
>   4 files changed, 24 insertions(+), 89 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index df4bb44..ed9f285 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -89,6 +89,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>   	.irqenable	= OMAP1610_GPIO_IRQENABLE1,
>   	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
>   	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
> +	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
The register doesn't seems to be the status register. wkup_en
is more appropriate.

Regards
Santosh
