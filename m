From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH V2 2/8] irqdomain: Don't set type when mapping an IRQ
Date: Tue, 22 Dec 2015 13:18:41 +0200
Message-ID: <56793191.30502@ti.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450349309-8107-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/17/2015 12:48 PM, Jon Hunter wrote:
> Some IRQ chips, such as GPIO controllers or secondary level interrupt
> controllers, may require require additional runtime power management
> control to ensure they are accessible. For such IRQ chips, it makes sense
> to enable the IRQ chip when interrupts are requested and disabled them
> again once all interrupts have been freed.
> 
> When mapping an IRQ, the IRQ type settings are read and then programmed.
> The mapping of the IRQ happens before the IRQ is requested and so the
> programming of the type settings occurs before the IRQ is requested. This
> is a problem for IRQ chips that require additional power management
> control because they may not be accessible yet. Therefore, when mapping
> the IRQ, don't program the type settings, just save them and then program
> these saved settings when the IRQ is requested (so long as if they are not
> overridden via the call to request the IRQ).
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>   kernel/irq/irqdomain.c | 18 ++++++++++++++----
>   kernel/irq/manage.c    |  7 +++++++
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index eae31e978ab2..4322d6fd0b8f 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -570,6 +570,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>   {
>   	struct device_node *of_node;
>   	struct irq_domain *domain;
> +	struct irq_data *irq_data;
>   	irq_hw_number_t hwirq;
>   	unsigned int cur_type = IRQ_TYPE_NONE;
>   	unsigned int type = IRQ_TYPE_NONE;
> @@ -634,10 +635,19 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>   		return 0;
>   	}
>   
> -	/* Set type if specified and different than the current one */
> -	if (type != IRQ_TYPE_NONE &&
> -	    type != irq_get_trigger_type(virq))
> -		irq_set_irq_type(virq, type);

^^^ note: Return code hes never ever been checked here ;)

This patch has side effect - some boards which have
ARM TWD timer will produce below backtrace on boot:

 genirq: Setting trigger mode 4 for irq 17 failed (gic_set_type+0x0/0x58)
 twd: can't register interrupt 17 (-22)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at arch/arm/kernel/smp_twd.c:405 twd_local_timer_of_register+0x68/0x7c()
twd_local_timer_of_register failed (-22)
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.13-01909-g59e42df #53
Hardware name: Generic AM43 (Flattened Device Tree)
Backtrace: 
[<c00130dc>] (dump_backtrace) from [<c00132fc>] (show_stack+0x18/0x1c)
 r7:c0797cec r6:00000000 r5:c08fa7bc r4:00000000
[<c00132e4>] (show_stack) from [<c0639334>] (dump_stack+0x98/0xe0)
[<c063929c>] (dump_stack) from [<c0044928>] (warn_slowpath_common+0x7c/0xb8)
 r7:c0797cec r6:00000195 r5:00000009 r4:c08b3f30
[<c00448ac>] (warn_slowpath_common) from [<c004499c>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0932000 r7:c08b48c0 r6:ffffffff r5:ee5c9fb4 r4:c0797cc0
[<c0044968>] (warn_slowpath_fmt) from [<c085c440>] (twd_local_timer_of_register+0x68/0x7c)
 r3:ffffffea r2:c0797cc0
 r4:c09322c4
[<c085c3d8>] (twd_local_timer_of_register) from [<c0889d74>] (clocksource_of_init+0x50/0x90)
 r5:00000001 r4:ee5c9fb4
[<c0889d24>] (clocksource_of_init) from [<c0864224>] (omap4_local_timer_init+0x34/0x68)
 r5:c0932000 r4:00000000
[<c08641f0>] (omap4_local_timer_init) from [<c085b7f4>] (time_init+0x24/0x38)
[<c085b7d0>] (time_init) from [<c0857b84>] (start_kernel+0x248/0x3e4)
[<c085793c>] (start_kernel) from [<8000807c>] (0x8000807c)
 r10:00000000 r9:412fc09a r8:80004059 r7:c08b8884 r6:c089934c r5:c08b4970
 r4:c0932214
---[ end trace cb88537fdc8fa200 ]---

This happens, most probably, because TWD IRQs definitions in DT
do not corresponds HW and gic_configure_irq() will return -EINVAL
example (am4372.dtsi):
	local_timer: timer@48240600 {
		compatible = "arm,cortex-a9-twd-timer";
		reg = <0x48240600 0x100>;
		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-parent = <&gic>;
		clocks = <&mpu_periphclk>;
		status = "disabled";
	};


So, some additional fixes might be required. Potentially problematic files are:
arch/arm/boot/dts/bcm5301x.dtsi
arch/arm/boot/dts/bcm63138.dtsi
arch/arm/boot/dts/berlin2cd.dtsi
arch/arm/boot/dts/berlin2.dtsi
arch/arm/boot/dts/berlin2q.dtsi
arch/arm/boot/dts/hip01.dtsi
arch/arm/boot/dts/omap4.dtsi
arch/arm/boot/dts/r8a7779.dts
arch/arm/boot/dts/rk3xxx.dtsi
arch/arm/boot/dts/sh73a0.dtsi
arch/arm/boot/dts/socfpga_arria10.dtsi
arch/arm/boot/dts/socfpga.dtsi
arch/arm/boot/dts/spear13xx.dtsi
arch/arm/boot/dts/ste-dbx5x0.dtsi
arch/arm/boot/dts/tegra20.dtsi
arch/arm/boot/dts/tegra30.dtsi
arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
arch/arm/boot/dts/uniphier-ph1-XXXX.dtsi
arch/arm/boot/dts/uniphier-proxstream2.dtsi
arch/arm/boot/dts/vexpress-v2p-ca5s.dts
arch/arm/boot/dts/vexpress-v2p-ca9.dts


Any way, It seems working for me, but I've back-ported and tested
it on kernel 4.1 and will try to do more tests this week.

Thanks a lot.
-- 
regards,
-grygorii
