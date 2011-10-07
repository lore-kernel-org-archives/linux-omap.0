From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 7/7] ARM: OMAP: Warn if omap_ioremap is called before SoC
	detection
Date: Fri, 07 Oct 2011 16:36:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110071635370.6390@xanadu.home>
References: <20111007194242.18205.64009.stgit@kaulin.local>
	<20111007194557.18205.37252.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20111007194557.18205.37252.stgit@kaulin.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 7 Oct 2011, Tony Lindgren wrote:

> We don't have cpu_is_omapxxxx SoC detection initialized until
> SoC detection is initialized from init_early.
> 
> Note that with the common map_io we should no longer need
> cpu_is_omapxxxx for ioremap.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/mach-omap1/io.c             |    1 +
>  arch/arm/mach-omap2/io.c             |    1 +
>  arch/arm/plat-omap/include/plat/io.h |    2 ++
>  arch/arm/plat-omap/io.c              |   10 ++++++++++
>  4 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
> index 8140a4e..fd9eb09 100644
> --- a/arch/arm/mach-omap1/io.c
> +++ b/arch/arm/mach-omap1/io.c
> @@ -121,6 +121,7 @@ void __init omap16xx_map_io(void)
>  void omap1_init_early(void)
>  {
>  	omap_check_revision();
> +	omap_ioremap_init();
>  
>  	/* REVISIT: Refer to OMAP5910 Errata, Advisory SYS_1: "Timeout Abort
>  	 * on a Posted Write in the TIPB Bridge".
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index d5caac3..aa96538 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -323,6 +323,7 @@ void __iomem *omap_irq_base;
>  static void __init omap_common_init_early(void)
>  {
>  	omap2_check_revision();
> +	omap_ioremap_init();
>  }
>  
>  static void __init omap_hwmod_init_postsetup(void)
> diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
> index c0c7850..5ffbea6 100644
> --- a/arch/arm/plat-omap/include/plat/io.h
> +++ b/arch/arm/plat-omap/include/plat/io.h
> @@ -247,6 +247,8 @@
>   * NOTE: Please use ioremap + __raw_read/write where possible instead of these
>   */
>  
> +void omap_ioremap_init(void);
> +
>  extern u8 omap_readb(u32 pa);
>  extern u16 omap_readw(u32 pa);
>  extern u32 omap_readl(u32 pa);
> diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
> index f1ecfa9..1bbcbde 100644
> --- a/arch/arm/plat-omap/io.c
> +++ b/arch/arm/plat-omap/io.c
> @@ -23,11 +23,16 @@
>  #define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
>  #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
>  
> +static int initialized;
> +
>  /*
>   * Intercept ioremap() requests for addresses in our fixed mapping regions.
>   */
>  void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
>  {
> +
> +	WARN(!initialized, "Do not use ioremap before init_early\n");
> +
>  #ifdef CONFIG_ARCH_OMAP1
>  	if (cpu_class_is_omap1()) {
>  		if (BETWEEN(p, OMAP1_IO_PHYS, OMAP1_IO_SIZE))
> @@ -139,3 +144,8 @@ void omap_iounmap(volatile void __iomem *addr)
>  		__iounmap(addr);
>  }
>  EXPORT_SYMBOL(omap_iounmap);
> +
> +void __init omap_ioremap_init(void)
> +{
> +	initialized++;
> +}
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
