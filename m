From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2] arm: omap2: timer: always define omap4_local_timer_init
Date: Mon, 28 Sep 2015 16:37:31 -0500
Message-ID: <5609B31B.9030108@ti.com>
References: <1443475405-15977-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443475405-15977-1-git-send-email-balbi@ti.com>
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


bit of nitpick on capitalization of $subject.. aside..

On 09/28/2015 04:23 PM, Felipe Balbi wrote:
> omap4_local_timer_init() can be used by other
> platforms as is. At least AM437x wants to use
> it. Instead of making omap4-only and providing
> a stub for builds without OMAP4, we can just
> always define that function.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> changes since v1:
>  - make sure result builds on AM43xx-only builds
> 
>  arch/arm/mach-omap2/timer.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index e4d8701f99f9..3cdd22251a0d 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -634,32 +634,22 @@ OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
>  			2, "timer_sys_ck", NULL);
>  #endif /* CONFIG_ARCH_OMAP3 */
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || \
> -	defined(CONFIG_SOC_AM43XX)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
>  OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
>  		       1, "timer_sys_ck", "ti,timer-alwon");
>  #endif
>  
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
> -	defined(CONFIG_SOC_DRA7XX)
> +	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>  static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
>  			       2, "sys_clkin_ck", NULL);
>  #endif
>  
> -#ifdef CONFIG_ARCH_OMAP4
> -#ifdef CONFIG_HAVE_ARM_TWD

OK -> so we removed both of these..

>  void __init omap4_local_timer_init(void)
>  {
>  	omap4_sync32k_timer_init();

but this only gets defined *if*
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
> -	defined(CONFIG_SOC_DRA7XX)
> +	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)

we should fail build on omap3 only, correct??

or am i missing something else?

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



-- 
Regards,
Nishanth Menon
