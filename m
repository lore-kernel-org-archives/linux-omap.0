From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] omap: Use separate init_irq functions to
 avoidcpu_is_omap tests early
Date: Tue, 29 Mar 2011 08:30:52 -0700
Message-ID: <20110329153052.GA4016@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <20110328222128.4046.70846.stgit@baageli.muru.com>
 <c2a9cfa46d997009ffc2c00d608ed7f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23379 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1C2Pa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 11:30:56 -0400
Content-Disposition: inline
In-Reply-To: <c2a9cfa46d997009ffc2c00d608ed7f5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 23:09]:
> 
> Above mapping is incorrect. The address space is of just
> 512 bytes. Infact you don't need to ioremap it again.
> Below should be enough.
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c
> b/arch/arm/mach-omap2/omap4-common.c
> index 9ef8c29..9bddc9e 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -41,6 +41,8 @@ void __init gic_init_irq(void)
>  	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>  	BUG_ON(!gic_cpu_base);
> 
> +	omap_irq_base = gic_cpu_base;
> +
>  	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
>  }

Thanks for cathing this.

Tony
