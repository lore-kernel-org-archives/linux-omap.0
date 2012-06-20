From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH V3 2/2] arm/dts: OMAP2: Fix interrupt controller
 binding
Date: Wed, 20 Jun 2012 06:10:22 -0700
Message-ID: <20120620131022.GH12766@atomide.com>
References: <1339548046-27988-1-git-send-email-jon-hunter@ti.com>
 <1339548046-27988-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34233 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab2FTNK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 09:10:29 -0400
Content-Disposition: inline
In-Reply-To: <1339548046-27988-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120612 17:45]:
> When booting with device-tree on an OMAP2420H4, the kernel is hanging when
> initialising the interrupts and following kernel dumps is seen ...
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: at arch/arm/mach-omap2/irq.c:271 omap_intc_of_init+0x50/0xb4()
> [    0.000000] unable to get intc registers
> [    0.000000] Modules linked in:
> [    0.000000] [<c001befc>] (unwind_backtrace+0x0/0xf4) from [<c0040c34>] (warn_slowpath_common+0x4c/0x64)
> [    0.000000] [<c0040c34>] (warn_slowpath_common+0x4c/0x64) from [<c0040ce0>] (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0040ce0>] (warn_slowpath_fmt+0x30/0x40) from [<c066b8a4>] (omap_intc_of_init+0x50/0xb4)
> [    0.000000] [<c066b8a4>] (omap_intc_of_init+0x50/0xb4) from [<c0688b70>] (of_irq_init+0x144/0x288)
> [    0.000000] [<c0688b70>] (of_irq_init+0x144/0x288) from [<c0663294>] (init_IRQ+0x14/0x1c)
> [    0.000000] [<c0663294>] (init_IRQ+0x14/0x1c) from [<c06607fc>] (start_kernel+0x198/0x304)
> [    0.000000] [<c06607fc>] (start_kernel+0x198/0x304) from [<80008044>] (0x80008044)
> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.000000] of_irq_init: children remain, but no parents
> 
> The OMAP2 interrupt controller binding is missing the number of interrupts and
> interrupt controller register address. Adding these fixes the problem.

Thanks this is a good one, applying into fixes.

Tony

> 
> This is based upon latest linux-omap master (3.5-rc1) git tree.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
> index f2ab4ea..581cb08 100644
> --- a/arch/arm/boot/dts/omap2.dtsi
> +++ b/arch/arm/boot/dts/omap2.dtsi
> @@ -44,6 +44,8 @@
>  			compatible = "ti,omap2-intc";
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> +			ti,intc-size = <96>;
> +			reg = <0x480FE000 0x1000>;
>  		};
>  
>  		uart1: serial@4806a000 {
> -- 
> 1.7.9.5
> 
