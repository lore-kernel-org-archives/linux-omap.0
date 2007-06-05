From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix PRCM_SYSCONFIG & PRCM_REVISION addresses for 24XX
Date: Tue, 5 Jun 2007 03:28:10 -0700
Message-ID: <20070605102809.GF859@atomide.com>
References: <20070530040223.689051525@pwsan.com>
	<20070530040243.850870657@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070530040243.850870657@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [070529 21:04]:
> Fix OMAP24XX_PRCM_REVISION and OMAP24XX_PRCM_SYSCONFIG addresses,
> which were incorrectly using 3430 PRM_{REVISION,SYSCONFIG} addresses.
> Bug found by Richard Woodruff <r-woodruff2@ti.com>.
> 
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> - Paul
> 
> ---
>  arch/arm/mach-omap2/prm.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/prm.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/prm.h
> +++ linux-omap/arch/arm/mach-omap2/prm.h
> @@ -31,8 +31,8 @@
>   *
>   */
>  
> -#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
> -#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
> +#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0000)
> +#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0010)
>  
>  #define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
>  #define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)

Pushing today.

Tony
