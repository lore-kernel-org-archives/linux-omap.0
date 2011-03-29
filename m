From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/10] omap: Use separate init_irq functions to
 avoidcpu_is_omap tests early
Date: Tue, 29 Mar 2011 11:41:50 +0530
Message-ID: <c2a9cfa46d997009ffc2c00d608ed7f5@mail.gmail.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com> <20110328222128.4046.70846.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45034 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272Ab1C2GMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 02:12:09 -0400
Received: by yxi11 with SMTP id 11so1715174yxi.29
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 23:12:07 -0700 (PDT)
In-Reply-To: <20110328222128.4046.70846.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, March 29, 2011 3:51 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 01/10] omap: Use separate init_irq functions to
> avoidcpu_is_omap tests early
>
> This allows us to remove cpu_is_omap calls from init_irq functions
> and the irq handler. There should not be any need for cpu_is_omap
> as at this point we only care about SoC generation, and not about
> subcategories.
>
> The main reason for the patch is that we want to initialize only
> minimal omap specific code from the init_early call, and this and
> the following patches get us closer to that goal.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
[....]

> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-
> omap2/omap4-common.c
> index 9ef8c29..1c3bcf1 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -19,6 +19,8 @@
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
>
> +#include <plat/irqs.h>
> +
>  #include <mach/hardware.h>
>  #include <mach/omap4-common.h>
>
> @@ -34,6 +36,10 @@ void __init gic_init_irq(void)
>  	void __iomem *gic_cpu_base;
>
>  	/* Static mapping, never released */
> +	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_4K);
> +	BUG_ON(!omap_irq_base);
> +
Above mapping is incorrect. The address space is of just
512 bytes. Infact you don't need to ioremap it again.
Below should be enough.

diff --git a/arch/arm/mach-omap2/omap4-common.c
b/arch/arm/mach-omap2/omap4-common.c
index 9ef8c29..9bddc9e 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -41,6 +41,8 @@ void __init gic_init_irq(void)
 	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!gic_cpu_base);

+	omap_irq_base = gic_cpu_base;
+
 	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
 }

Regards,
Santosh
