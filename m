From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: twl4030_charger: clear IRQs after handling them
Date: Wed, 16 Apr 2014 09:35:27 -0700
Message-ID: <20140416163526.GA3049@atomide.com>
References: <1397661299-31342-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1397661299-31342-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, dbaryshkov@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, dwmw2@infradead.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [140416 08:18]:
> TRM says we *must* write 1 to each bit we're handling
> in order to clear the IRQ status and bring IRQ line
> low. This patch implements that.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Russell, I don't have HW to test, but this should
> solve the problem you saw when not using battery
> with Zoom board. Let me know if it doesn't.

BTW, looks like we're enabling BCI automatically in twl4030.dtsi
while the legacy booting does not have TWL_COMMON_PDATA_BCI
enabled for LDP. Anyways, for LDP BCI should be enabled for
sure, that's the only way to power at least the earlier LDP
revisions.

>  drivers/power/twl4030_charger.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index f141088..b090842 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -301,12 +301,24 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
>  	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs1,
>  			      TWL4030_INTERRUPTS_BCIISR1A);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
> +
> +	/* clear IRQs early */
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs1,
> +			TWL4030_INTERRUPTS_BCIISR1A);
> +	if (ret < 0)
> +		return IRQ_NONE;
>  
>  	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs2,
>  			      TWL4030_INTERRUPTS_BCIISR2A);
>  	if (ret < 0)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
> +
> +	/* clear IRQs early */
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs2,
> +			      TWL4030_INTERRUPTS_BCIISR2A);
> +	if (ret < 0)
> +		return IRQ_NONE;
>  
>  	dev_dbg(bci->dev, "BCI irq %02x %02x\n", irqs2, irqs1);
>  
> -- 
> 1.9.1.286.g5172cb3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
