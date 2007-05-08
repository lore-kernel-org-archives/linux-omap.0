From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] update mach-omap2/pm.c for struct subsystem removal
Date: Tue, 8 May 2007 14:48:03 -0700
Message-ID: <20070508214802.GN32547@atomide.com>
References: <20070508213856.893570384@pwsan.com>
	<20070508213943.119220524@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070508213943.119220524@pwsan.com>
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

* Paul Walmsley <paul@pwsan.com> [070508 14:41]:
> 'struct subsystem' is no more, replaced with 'struct kset': commit
> 823bccfc4002296ba88c3ad0f049e1abd8108d30.  Fixes the following
> warnings:
> 
>   CC      arch/arm/mach-omap2/pm.o
> arch/arm/mach-omap2/pm.c:410: warning: 'struct subsystem' declared inside parameter list
> arch/arm/mach-omap2/pm.c:410: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mach-omap2/pm.c:417: warning: 'struct subsystem' declared inside parameter list
> arch/arm/mach-omap2/pm.c:434: warning: initialization from incompatible pointer type
> arch/arm/mach-omap2/pm.c:435: warning: initialization from incompatible pointer type
> 
> Compile-tested only.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/pm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.c
> @@ -407,12 +407,12 @@ static inline void serial_console_fclk_m
>  
>  static unsigned short enable_dyn_sleep = 0; /* disabled till drivers are fixed */
>  
> -static ssize_t omap_pm_sleep_while_idle_show(struct subsystem * subsys, char *buf)
> +static ssize_t omap_pm_sleep_while_idle_show(struct kset * subsys, char *buf)
>  {
>  	return sprintf(buf, "%hu\n", enable_dyn_sleep);
>  }
>  
> -static ssize_t omap_pm_sleep_while_idle_store(struct subsystem * subsys,
> +static ssize_t omap_pm_sleep_while_idle_store(struct kset * subsys,
>  					      const char * buf,
>  					      size_t n)
>  {
> 

Thanks, pushing today.

Tony
