From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/15] ARM: OMAP: Correct interrupt type for ARM TWD
Date: Fri, 18 Mar 2016 17:41:05 +0200
Message-ID: <56EC2191.2060800@ti.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/17/2016 04:19 PM, Jon Hunter wrote:
> The ARM TWD interrupt is a private peripheral interrupt (PPI) and per
> the ARM GIC documentation, whether the type for PPIs can be set is
> IMPLEMENTATION DEFINED. For OMAP4 devices the PPI type cannot be set and
> so when we attempt to set the type for the ARM TWD interrupt it fails.
> This has done unnoticed because it fails silently and because we cannot
> re-configure the type it has had no impact. Nevertheless fix the type
> for the TWD interrupt so that it matches the hardware configuration.
> 
> Reported-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> ---
> 
> Tony, Grygorii,
> Please note that I have not tested this. Can you test this series and
> see if you see any warnings on OMAP4? I am guessing that the configuration
> should be LEVEL and not EDGE. This was reported here:

Tested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Tested on PandaBoard. Without this patch I can see below warning:


[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-common.c:61 gic_configure_irq+0x84/0x90()
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.5.0-05765-gd232fe5 #6
[    0.000000] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    0.000000] Backtrace: 
[    0.000000] [<c010bc80>] (dump_backtrace) from [<c010be78>] (show_stack+0x18/0x1c)
[    0.000000]  r7:00000000 r6:c0a448a4 r5:200001d3 r4:00000000
[    0.000000] [<c010be60>] (show_stack) from [<c03f223c>] (dump_stack+0x98/0xb4)
[    0.000000] [<c03f21a4>] (dump_stack) from [<c0136b38>] (warn_slowpath_common+0x7c/0xb8)
[    0.000000]  r7:c08664e0 r6:0000003d r5:00000009 r4:00000000
[    0.000000] [<c0136abc>] (warn_slowpath_common) from [<c0136c18>] (warn_slowpath_null+0x24/0x2c)
[    0.000000]  r8:00000004 r7:c0a02d98 r6:00000000 r5:ee805cc0 r4:00000000
[    0.000000] [<c0136bf4>] (warn_slowpath_null) from [<c0420708>] (gic_configure_irq+0x84/0x90)
[    0.000000] [<c0420684>] (gic_configure_irq) from [<c042024c>] (gic_set_type+0x50/0x60)
[    0.000000] [<c04201fc>] (gic_set_type) from [<c017f968>] (__irq_set_trigger+0x64/0x158)
[    0.000000]  r5:ee805cc0 r4:ee828540
[    0.000000] [<c017f904>] (__irq_set_trigger) from [<c017ff7c>] (__setup_irq+0x520/0x614)
[    0.000000]  r9:600001d3 r8:ee805d20 r7:00000011 r6:00000011 r5:ee805cc0 r4:ee828540
[    0.000000] [<c017fa5c>] (__setup_irq) from [<c0180394>] (request_percpu_irq+0x8c/0xf0)
[    0.000000]  r9:c0110004 r8:c083237c r7:c095da80 r6:00000011 r5:ee805cc0 r4:ee828540
[    0.000000] [<c0180308>] (request_percpu_irq) from [<c09053e4>] (twd_local_timer_common_register+0x44/0x1bc)
[    0.000000]  r9:efffc000 r8:c0a7b000 r7:c0a02900 r6:ef6c75c8 r5:ef6c75c8 r4:c0a7b2cc
[    0.000000] [<c09053a0>] (twd_local_timer_common_register) from [<c09055ac>] (twd_local_timer_of_register+0x50/0x78)
[    0.000000]  r9:efffc000 r8:c0a7b000 r7:c0a02900 r6:ffffffff r5:ef6c75c8 r4:c0a7b2cc
[    0.000000] [<c090555c>] (twd_local_timer_of_register) from [<c0930ba4>] (clocksource_probe+0x50/0x90)
[    0.000000]  r5:00000001 r4:ef6c75c8
[    0.000000] [<c0930b54>] (clocksource_probe) from [<c090d5b0>] (omap4_local_timer_init+0x14/0x18)
[    0.000000]  r5:c0a7b000 r4:00000000
[    0.000000] [<c090d59c>] (omap4_local_timer_init) from [<c090494c>] (time_init+0x24/0x38)
[    0.000000] [<c0904928>] (time_init) from [<c0900b84>] (start_kernel+0x220/0x3bc)
[    0.000000] [<c0900964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:411fc092 r8:8000406a r7:c0a073e4 r6:c0940a2c r5:c0a029b0
[    0.000000]  r4:c0a7b214
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
