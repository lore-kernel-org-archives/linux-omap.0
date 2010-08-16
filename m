From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 16 Aug 2010 16:05:28 +0300
Message-ID: <1281963928.1888.27.camel@chotu>
References: <1281962906.1888.25.camel@chotu>
	 <1281963552.2793.3.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50881 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0HPNNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 09:13:23 -0400
In-Reply-To: <1281963552.2793.3.camel@hornet.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Pawel Moll <mail@pawelmoll.com>
Cc: "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2010-08-16 at 14:59 +0200, ext Pawel Moll wrote:
> Hi Ameya,
> 
> > [    0.805419] omapfb omapfb: failed to allocate framebuffer
> > [    0.810882] omapfb omapfb: failed to allocate fbmem
> > [    0.815856] omapfb omapfb: failed to setup omapfb
> > [    0.820648] omapfb: probe of omapfb failed with error -12
> 
> Could you quickly try this hack?
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index ab50627..0875b2d 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -204,8 +204,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>         /*
>          * Don't allow RAM to be mapped - this causes problems with ARMv6+
>          */
> -       if (WARN_ON(pfn_valid(pfn)))
> -               return NULL;
> +//     if (WARN_ON(pfn_valid(pfn)))
> +//             return NULL;
>  
>         type = get_mem_type(mtype);
>         if (!type)
> 
> 
> If it helps you have just encountered side effects of this:

Doesn't help :( But I also feel that it might be broken because of:

commit 98864ff58dd2b8ef9e72b0d2c70f34e7ff24a2ee
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat May 22 23:59:11 2010 +0100

    ARM: OMAP: Convert OMAPFB and VRAM SDRAM reservation to LMB
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

commit 8d717a52d1b0959128be5134dd12608e8e4f2115
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat May 22 19:47:18 2010 +0100

    ARM: Convert platform reservations to use LMB rather than bootmem
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Cheers,
Ameya.

