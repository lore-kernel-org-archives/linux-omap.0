From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] Allow memblock steal operations to remove memory from anywhere
Date: Sun, 12 Aug 2012 18:16:57 +0530
Message-ID: <CAMQu2gz=omKAEv+obBW8EuS_ug=dZUkeXb_iP21-JLTxPNj3dw@mail.gmail.com>
References: <20120812105708.GD18957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54099 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464Ab2HLMrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Aug 2012 08:47:19 -0400
Received: by obbun3 with SMTP id un3so6986495obb.3
        for <linux-omap@vger.kernel.org>; Sun, 12 Aug 2012 05:47:18 -0700 (PDT)
In-Reply-To: <20120812105708.GD18957@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>

On Sun, Aug 12, 2012 at 4:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Found this with the cubox, which wants to obtain large blocks of
> RAM for the GPU and VPU devices at boot time.  I don't believe
> any other platforms care where the memory comes from, so I think
> this is safe.
>
Agree.

> However, OMAP and iMX folk should check this patch - thanks.
>
Works for OMAP without any issues.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> 8<===
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: ARM: Allow arm_memblock_steal() to remove memory from any RAM region
>
> Allow arm_memblock_steal() to remove memory from any RAM region,
> including highmem areas.  This allows memory to be stolen from the
> very top of declared memory, including highmem areas, rather than
> our precious lowmem.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index f54d592..04632f3 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -324,7 +324,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
>
>         BUG_ON(!arm_memblock_steal_permitted);
>
> -       phys = memblock_alloc(size, align);
> +       phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
>         memblock_free(phys, size);
>         memblock_remove(phys, size);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
