From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 3/4] omap: iovmm - replace __iounmap with omap_iounmap
Date: Thu, 2 Dec 2010 12:32:02 +0000
Message-ID: <20101202123202.GA10461@n2100.arm.linux.org.uk>
References: <1288033806-1496-1-git-send-email-x0095840@ti.com> <1288033806-1496-2-git-send-email-x0095840@ti.com> <1288033806-1496-3-git-send-email-x0095840@ti.com> <1288033806-1496-4-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1288033806-1496-4-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-kernel@vger.kernel.org, felipe.contreras@nokia.com, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 25, 2010 at 02:10:05PM -0500, Fernando Guzman Lugo wrote:
> Omap platform is omap_iounmap function.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/plat-omap/iovmm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 93a34d9..5489ca9 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
>  	struct sg_table *sgt;
>  	typedef void (*func_t)(const void *);
>  
> -	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,
> +	sgt = unmap_vm_area(obj, da, (func_t)omap_iounmap,
>  			    IOVMF_LINEAR | IOVMF_MMIO);
>  	if (!sgt)
>  		dev_dbg(obj->dev, "%s: No sgt\n", __func__);

Err, this is wrong.  Why are you breaking the layer separation and going
for the implementation detail of iounmap()?

plat/io.h:
#define __arch_ioremap(p,s,t)   omap_ioremap(p,s,t)
#define __arch_iounmap(v)       omap_iounmap(v)

void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned int type);
void omap_iounmap(volatile void __iomem *addr);

asm/io.h:
#define ioremap(cookie,size)            __arch_ioremap((cookie), (size), MT_DEVICE)
#define iounmap(cookie)                 __arch_iounmap(cookie)
