From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fixing cpu_class_is_omap2() parentheses warning
Date: Fri, 29 Jun 2007 00:21:01 -0700
Message-ID: <20070629072100.GB23421@atomide.com>
References: <20070625182249.19564.42233.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070625182249.19564.42233.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ragner Magalhaes <ragner.magalhaes@indt.org.br> [070625 11:35]:
> From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
> 
> Fixing the follow warning 
> arch/arm/plat-omap/usb.c: In function 'omap_usb0_init':
> arch/arm/plat-omap/usb.c:136: warning: suggest parentheses around && within ||
> 
> Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
> ---
> 
>  include/asm-arm/arch-omap/cpu.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
> index 4eea68b..b9399a8 100644
> --- a/include/asm-arm/arch-omap/cpu.h
> +++ b/include/asm-arm/arch-omap/cpu.h
> @@ -273,6 +273,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>  /* Macros to detect if we have OMAP1 or OMAP2 */
>  #define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || \
>  				cpu_is_omap16xx())
> -#define cpu_class_is_omap2()	cpu_is_omap24xx() || cpu_is_omap34xx()
> +#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
>  
>  #endif

Thanks, pushing today.

Tony
