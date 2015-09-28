From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm: omap2: timer: always define omap4_local_timer_init
Date: Mon, 28 Sep 2015 16:10:40 -0500
Message-ID: <5609ACD0.1010907@ti.com>
References: <1443464744-16561-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443464744-16561-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 09/28/2015 01:25 PM, Felipe Balbi wrote:
> omap4_local_timer_init() can be used by other
> platforms as is. At least AM437x wants to use
> it. Instead of making omap4-only and providing
> a stub for builds without OMAP4, we can just
> always define that function.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index a55655127ef2..f9028582e962 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -642,20 +642,11 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
>  			       2, "sys_clkin_ck", NULL);
>  #endif
>  
> -#ifdef CONFIG_ARCH_OMAP4
> -#ifdef CONFIG_HAVE_ARM_TWD
>  void __init omap4_local_timer_init(void)
>  {
>  	omap4_sync32k_timer_init();
>  	clocksource_of_init();
>  }
> -#else
> -void __init omap4_local_timer_init(void)
> -{
> -	omap4_sync32k_timer_init();
> -}
> -#endif /* CONFIG_HAVE_ARM_TWD */
> -#endif /* CONFIG_ARCH_OMAP4 */
>  
>  #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
>  void __init omap5_realtime_timer_init(void)
> 
I am a little confused if this will build in a am437xx only build.

#define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop, \
clksrc_nr, clksrc_src, clksrc_prop) \
void __init omap##name##_sync32k_timer_init(void) \

Would you like to consider this for OMAP4 only build as well?

#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \

        defined(CONFIG_SOC_DRA7XX)
static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
                               2, "sys_clkin_ck", NULL);
#endif


-- 
Regards,
Nishanth Menon
