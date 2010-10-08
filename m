From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Fri, 8 Oct 2010 06:32:29 -0500
Message-ID: <4CAF014D.7000909@ti.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab0JHLcf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 07:32:35 -0400
In-Reply-To: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
> Fix the sparse warnings generated due to conflicts in variables used in readl/writel.
> 
> 
> drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows an earlier one
> drivers/net/smc91x.c:312:8: originally declared here
> 
> With this change, about 200 sparse warnings are fixed.
The commit message could be a little more detailed.
see http://marc.info/?l=linux-omap&m=128648102511076&w=2

also should $subject say ARM: io: fix namespace conflict
to better reflect the fix? sparse warnings are just an indication IMHO

> 
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/include/asm/io.h |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 1261b1f..2daecb6 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -131,11 +131,11 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
>  #define outl(v,p)		__raw_writel((__force __u32) \
>  					cpu_to_le32(v),__io(p))
>  
> -#define inb(p)	({ __u8 __v = __raw_readb(__io(p)); __v; })
> -#define inw(p)	({ __u16 __v = le16_to_cpu((__force __le16) \
> -			__raw_readw(__io(p))); __v; })
> -#define inl(p)	({ __u32 __v = le32_to_cpu((__force __le32) \
> -			__raw_readl(__io(p))); __v; })
> +#define inb(p)	({ __u8 __inbv = __raw_readb(__io(p)); __inbv; })
> +#define inw(p)	({ __u16 __inwv = le16_to_cpu((__force __le16) \
> +			__raw_readw(__io(p))); __inwv; })
> +#define inl(p)	({ __u32 __inlv = le32_to_cpu((__force __le32) \
> +			__raw_readl(__io(p))); __inlv; })
>  
>  #define outsb(p,d,l)		__raw_writesb(__io(p),d,l)
>  #define outsw(p,d,l)		__raw_writesw(__io(p),d,l)
> @@ -200,9 +200,9 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  #define __iowmb()		do { } while (0)
>  #endif
>  
> -#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
> -#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
> -#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> +#define readb(c)		({ u8  __readbv = readb_relaxed(c); __iormb(); __readbv; })
> +#define readw(c)		({ u16 __readwv = readw_relaxed(c); __iormb(); __readwv; })
> +#define readl(c)		({ u32 __readlv = readl_relaxed(c); __iormb(); __readlv; })
>  
>  #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
>  #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
> @@ -258,9 +258,9 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>   * io{read,write}{8,16,32} macros
>   */
>  #ifndef ioread8
> -#define ioread8(p)	({ unsigned int __v = __raw_readb(p); __iormb(); __v; })
> -#define ioread16(p)	({ unsigned int __v = le16_to_cpu((__force __le16)__raw_readw(p)); __iormb(); __v; })
> -#define ioread32(p)	({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __iormb(); __v; })
> +#define ioread8(p)	({ unsigned int __ioread8v = __raw_readb(p); __iormb(); __ioread8v; })
> +#define ioread16(p)	({ unsigned int __ioread16v = le16_to_cpu((__force __le16)__raw_readw(p)); __iormb(); __ioread16v; })
> +#define ioread32(p)	({ unsigned int __ioread32v = le32_to_cpu((__force __le32)__raw_readl(p)); __iormb(); __ioread32v; })
>  
>  #define iowrite8(v,p)	({ __iowmb(); (void)__raw_writeb(v, p); })
>  #define iowrite16(v,p)	({ __iowmb(); (void)__raw_writew((__force __u16)cpu_to_le16(v), p); })


-- 
Regards,
Nishanth Menon
