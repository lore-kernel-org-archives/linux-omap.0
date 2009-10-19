From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: Bug on "omap: ioremap fixes for omap4"
Date: Mon, 19 Oct 2009 10:54:04 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CEFF1AE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475AbZJSPyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 11:54:04 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony, Santosh,

I think there's a missing fix in this commit:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=041b80d9a00ab741ce50db92c84b6bed554fc3b6

Here:

> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 50a62f2..4b644a9 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -60,9 +60,9 @@ static void __init gic_init_irq(void)
>  	gic_dist_init(0, base, 29);
>  
>  	/* Static mapping, never released */
> -	base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_256);
> +	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>  	BUG_ON(!base);

Shouldn't it be:

	BUG_ON(!gic_cpu_base_addr);

Instead?

> -	gic_cpu_init(0, OMAP44XX_GIC_CPU_BASE);
> +	gic_cpu_init(0, gic_cpu_base_addr);
>  }
>  
>  static void __init omap_4430sdp_init_irq(void)

Regards,
Sergio