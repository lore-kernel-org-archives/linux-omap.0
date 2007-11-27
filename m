From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Date: Tue, 27 Nov 2007 08:55:43 -0400
Message-ID: <20071127125543.GA6534@1BRL00624.americas.nokia.com>
References: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
	<010001c82b47$71eae130$ec8818ac@ent.ti.com>
	<014f01c82cc4$82ad3260$ec8818ac@ent.ti.com>
	<20071123212831.GJ559@atomide.com>
	<008b01c830e7$a650a220$ec8818ac@ent.ti.com>
Reply-To: ext-felipe.lima@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <008b01c830e7$a650a220$ec8818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Sameer <x0081444@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 27, 2007 at 04:51:24PM +0530, ext Sameer wrote:

snip

> Index: linux-omap-git/include/asm-arm/arch-omap/pm.h
> ===================================================================
> --- linux-omap-git.orig/include/asm-arm/arch-omap/pm.h
> +++ linux-omap-git/include/asm-arm/arch-omap/pm.h
> @@ -107,7 +107,8 @@
>  #if     !defined(CONFIG_ARCH_OMAP730) && \
>         !defined(CONFIG_ARCH_OMAP15XX) && \
>         !defined(CONFIG_ARCH_OMAP16XX) && \
> -       !defined(CONFIG_ARCH_OMAP24XX)
> +       !defined(CONFIG_ARCH_OMAP24XX) && \
> +       !defined(CONFIG_ARCH_OMAP34XX)
>  #error "Power management for this processor not implemented yet"
>  #endif
> 
> @@ -134,8 +135,13 @@ void clk_deny_idle(struct clk *clk);
> 
>  extern void omap_pm_idle(void);
>  extern void omap_pm_suspend(void);
> +#ifdef CONFIG_PM
>  extern void omap2_block_sleep(void);
>  extern void omap2_allow_sleep(void);
> +#else
> +#define omap2_block_sleep()    /* NULL */
> +#define omap2_allow_sleep()    /* NULL */

I'd prefer:
#else
static inline void omap2_block_sleep(void) { }
static inline void omap2_allow_sleep(void) { }
#endif

but it looks ok.

> +#endif
>  extern void omap730_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1510_cpu_suspend(unsigned short, unsigned short);
>  extern void omap1611_cpu_suspend(unsigned short, unsigned short);
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

INdT - OSMRC - Manaus
Core Team
