From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Mon, 27 Aug 2012 14:35:57 -0700
Message-ID: <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:60460 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754219Ab2H0VgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 17:36:18 -0400
Received: by ialo24 with SMTP id o24so9190836ial.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 14:36:17 -0700 (PDT)
In-Reply-To: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 27, 2012 at 2:03 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> When booting kernel on RM-680/N950, the console is flooded with:
>
> [    6.894348] In-band Error seen by MPU  at address 0
> [    6.894348] ------------[ cut here ]------------
> [    6.894378] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
> omap3_l3_app_irq+0xd4/0x12c()
> [    6.894378] Modules linked in:
> [    6.894409] Backtrace:
> [    6.894409] [<c0012440>] (dump_backtrace+0x0/0x10c) from [<c02fb698>]
> (dump_stack+0x18/0x1c)
> [    6.894439]  r6:c002de58 r5:00000009 r4:00000000 r3:c0880180
> [    6.894470] [<c02fb680>] (dump_stack+0x0/0x1c) from [<c0039854>]
> (warn_slowpath_common+0x54/0x6c)
> [    6.894500] [<c0039800>] (warn_slowpath_common+0x0/0x6c) from
> [<c0039890>] (warn_slowpath_null+0x24/0x2c)
> [    6.894500]  r8:0000000a r7:00000000 r6:f8001400 r5:00000000
> r4:84001b00
> [    6.894500] r3:00000009
> [    6.894561] [<c003986c>] (warn_slowpath_null+0x0/0x2c) from
> [<c002de58>] (omap3_l3_app_irq+0xd4/0x12c)
> [    6.894561] [<c002dd84>] (omap3_l3_app_irq+0x0/0x12c) from [<c008561c>]
> (handle_irq_event_percpu+0x54/0x19c)
> [    6.894592]  r7:00000000 r6:00000000 r5:c082c710 r4:ef072340
> [    6.894622] [<c00855c8>] (handle_irq_event_percpu+0x0/0x19c) from
> [<c00857c4>] (handle_irq_event+0x60/0x80)
> [    6.894653] [<c0085764>] (handle_irq_event+0x0/0x80) from [<c0088300>]
> (handle_level_irq+0xb4/0x134)
> [    6.894653]  r5:c082c710 r4:c082c6c0
> [    6.894683] [<c008824c>] (handle_level_irq+0x0/0x134) from [<c0084e18>]
> (generic_handle_irq+0x2c/0x44)
> [    6.894683]  r6:ef02c000 r5:c0829014 r4:c0841e18 r3:c008824c
> [    6.894744] [<c0084dec>] (generic_handle_irq+0x0/0x44) from
> [<c000f228>] (handle_IRQ+0x54/0xb8)
> [    6.894744] [<c000f1d4>] (handle_IRQ+0x0/0xb8) from [<c000873c>]
> (omap3_intc_handle_irq+0x68/0x7c)
> [    6.894775]  r8:c08415cc r7:0000000a r6:c0898c38 r5:ef02de88
> r4:fa200000
> [    6.894775] r3:00000000
> [    6.894805] [<c00086d4>] (omap3_intc_handle_irq+0x0/0x7c) from
> [<c0302e80>] (__irq_svc+0x40/0x54)
> [    6.894836] Exception stack(0xef02de88 to 0xef02ded0)
> [    6.894836] de80:                   f0048000 00000000 00007000 00000000
> 0000 3035 f004bfca
> [    6.894866] dea0: 00000000 00000000 c08415cc c0898140 ef02c000 ef02def4
> ef02 def8 ef02ded0
> [    6.894866] dec0: c042b1dc c0016efc 20000013 ffffffff
> [    6.894897]  r7:ef02debc r6:ffffffff r5:20000013 r4:c0016efc
> [    6.894927] [<c0016ed0>] (_memset_io+0x0/0x50) from [<c042b1dc>]
> (omap_sram_init+0x228/0x56c)
> [    6.894927]  r8:c0445cf4 r7:c0417208 r6:c0898140 r5:c0899840
> r4:c0899a3c
> [    6.894927] r3:f004f000
> [    6.894989] [<c042afb4>] (omap_sram_init+0x0/0x56c) from [<c041f01c>]
> (omap_sdrc_init+0x18/0xb8)
> [    6.894989]  r6:c0898140 r5:c0899840 r4:c0899840 r3:0005e601
> [    6.895019] [<c041f004>] (omap_sdrc_init+0x0/0xb8) from [<c0427e38>]
> (rm680_init+0x34/0xc0)
> [    6.895050]  r5:c04518e0 r4:c0875da0
> [    6.895080] [<c0427e04>] (rm680_init+0x0/0xc0) from [<c0419934>]
> (customize_machine+0x24/0x30)
> [    6.895080]  r5:00000003 r4:00000000
> [    6.895111] [<c0419910>] (customize_machine+0x0/0x30) from [<c00088e0>]
> (do_one_initcall+0x11c/0x184)
> [    6.895141] [<c00087c4>] (do_one_initcall+0x0/0x184) from [<c041799c>]
> (kernel_init+0x100/0x1c4)
> [    6.895141] [<c041789c>] (kernel_init+0x0/0x1c4) from [<c003ef18>]
> (do_exit+0x0/0x794)
> [    6.895172] ---[ end trace 1b75b31a271a0d00 ]---
>
> This is repeated maybe a thousand times. While the root cause remains
> unknown (they seem to occur during SDRC and DMA init), the errors should
> be at least ratelimited so that user will also have chance to see other
> boot messages.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap2/omap_l3_smx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c
> b/arch/arm/mach-omap2/omap_l3_smx.c
> index acc2164..e3b4948 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -155,11 +155,11 @@ static irqreturn_t omap3_l3_block_irq(struct
> omap3_l3 *l3,
>         u8 multi = error & L3_ERROR_LOG_MULTI;
>         u32 address = omap3_l3_decode_addr(error_addr);
>
> -       pr_err("%s seen by %s %s at address %x\n",
> +       pr_err_ratelimited("%s seen by %s %s at address %x\n",
>                         omap3_l3_code_string(code),
>                         omap3_l3_initiator_string(initid),
>                         multi ? "Multiple Errors" : "", address);
> -       WARN_ON(1);
> +       WARN_ON_ONCE(1);
>
The issue needs to be fixed instead of WARN_ON_ONCE() and then
just moving ahead. Interconnect in bad states is really bad state and you
won't have reliable operations post that on SOC.

Regards
Santosh
