From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix omap3 prm shared irq
Date: Fri, 28 Jul 2017 12:35:53 +0300
Message-ID: <cdac8d51-580b-c6d8-60be-39e31337c3af@ti.com>
References: <20170627084838.30275-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170627084838.30275-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 27/06/17 11:48, Tony Lindgren wrote:
> Shared interrupts with IRQ_NOAUTOEN got a warning added with commit
> 04c848d39879 ("genirq: Warn when IRQ_NOAUTOEN is used with shared
> interrupts").
> 
> Let's just drop the IRQ_NOAUTOEN use for omap3 PRM shared interrupt as
> it does not seem to cause any other issues based on my testing. We have
> moved a lot of the code to initialize later, and whatever problems the
> legacy booting had seem to be gone now with pinctrl driver and device
> tree based booting.
> 
> Otherwise we will get:
> 
> WARNING: CPU: 0 PID: 1 at kernel/irq/manage.c:1348 __setup_irq+0x5d0/0x64c
> [<c01b0260>] (__setup_irq) from [<c01b0480>]
> (request_threaded_irq+0xdc/0x188)
> [<c01b0480>] (request_threaded_irq) from [<c051c780>]
> (pcs_probe+0x6ec/0x8a4)
> [<c051c780>] (pcs_probe) from [<c05a84b8>] (platform_drv_probe+0x50/0xb0)
> [<c05a84b8>] (platform_drv_probe) from [<c05a6288>]
> (driver_probe_device+0x33c/0x478)
> 
> Note that we also need to remove the related enable_irq() to avoid
> getting the following:
> 
> WARNING: CPU: 0 PID: 1 at kernel/irq/manage.c:529 enable_irq+0x34/0x70
> [<c01afa04>] (enable_irq) from [<c0c0f1fc>] (omap3_pm_init+0x118/0x3f8)
> [<c0c0f1fc>] (omap3_pm_init) from [<c0c0ae7c>] (am35xx_init_late+0x10/0x18)
> 
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks fine to me.

-Tero

> ---
>   arch/arm/mach-omap2/pm34xx.c  | 1 -
>   arch/arm/mach-omap2/prm3xxx.c | 7 +------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -483,7 +483,6 @@ int __init omap3_pm_init(void)
>   	ret = request_irq(omap_prcm_event_to_irq("io"),
>   		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
>   		omap3_pm_init);
> -	enable_irq(omap_prcm_event_to_irq("io"));
>   
>   	if (ret) {
>   		pr_err("pm: Failed to request pm_io irq\n");
> diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
> --- a/arch/arm/mach-omap2/prm3xxx.c
> +++ b/arch/arm/mach-omap2/prm3xxx.c
> @@ -692,7 +692,6 @@ static int omap3xxx_prm_late_init(void)
>   {
>   	struct device_node *np;
>   	int irq_num;
> -	int ret;
>   
>   	if (!(prm_features & PRM_HAS_IO_WAKEUP))
>   		return 0;
> @@ -712,12 +711,8 @@ static int omap3xxx_prm_late_init(void)
>   	}
>   
>   	omap3xxx_prm_enable_io_wakeup();
> -	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
> -	if (!ret)
> -		irq_set_status_flags(omap_prcm_event_to_irq("io"),
> -				     IRQ_NOAUTOEN);
>   
> -	return ret;
> +	return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
>   }
>   
>   static void __exit omap3xxx_prm_exit(void)
> 
