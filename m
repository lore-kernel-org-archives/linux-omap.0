From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix Apollon and OSK ethernet IRQ flags
Date: Fri, 17 Nov 2006 23:46:19 +0200
Message-ID: <20061117214618.GG6072@atomide.com>
References: <455C93A5.8010203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <455C93A5.8010203@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061116 18:46]:
> 
> Fix IRQ flags for Apollon and OSK (OMAP5912) board. Apollon 
> fix from
> Kyungmin Park (kyungmin.park_at_samsung.com):
> 
> Apollon (omap2420) use IRQF_TRIGGER_RISING which means
> IRQF_TRIGGER_HIGH.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/drivers/net/smc91x.h
> ===================================================================
> --- linux-osk.orig/drivers/net/smc91x.h
> +++ linux-osk/drivers/net/smc91x.h
> @@ -193,10 +193,12 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
>  #include <asm/arch/cpu.h>
>  
>  #ifdef CONFIG_ARCH_OMAP1
> -#define	SMC_IRQ_FLAGS	(machine_is_omap_innovator() ? IRQF_TRIGGER_RISING : \
> -				IRQF_TRIGGER_FALLING)
> +#define	SMC_IRQ_FLAGS	((machine_is_omap_innovator() ||  \
> +                          machine_is_omap_osk())          \
> +                          ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING)
>  #else
> -#define SMC_IRQ_FLAGS		IRQF_TRIGGER_LOW
> +#define SMC_IRQ_FLAGS	 (machine_is_omap_apollon()       \
> +                          ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW)
>  #endif
>  
>  #elif	defined(CONFIG_SH_SH4202_MICRODEV)

Heh, thanks pushing today. Did I manage to break any other boards? :)

Tony
