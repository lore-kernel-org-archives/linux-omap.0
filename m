From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/7] OMAP2+: use control module mfd driver
 in omap_type
Date: Wed, 27 Jun 2012 23:32:36 -0700
Message-ID: <20120628063235.GA19842@atomide.com>
References: <4FEB4B4A.1040204@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FEB4B4A.1040204@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120627 11:09]:
> OMAP system control module can be probed early, then
> omap_type is safe to use its APIs.
> 
> TODO: add support for other omap versions
> 
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> ---
>  arch/arm/mach-omap2/id.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 00486a8..1b0cec8 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/mfd/omap_control.h>
>  
>  #include <asm/cputype.h>
>  
> @@ -43,13 +44,13 @@ int omap_type(void)
>  	u32 val = 0;
>  
>  	if (cpu_is_omap24xx()) {
> -		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> +		val = omap_control_status_read(OMAP24XX_CONTROL_STATUS);
>  	} else if (cpu_is_am33xx()) {
> -		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
> +		val = omap_control_status_read(AM33XX_CONTROL_STATUS);
>  	} else if (cpu_is_omap34xx()) {
> -		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
> +		val = omap_control_status_read(OMAP343X_CONTROL_STATUS);
>  	} else if (cpu_is_omap44xx()) {
> -		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +		val = omap_control_status_read(OMAP4_CTRL_MODULE_CORE_STATUS);
>  	} else {
>  		pr_err("Cannot detect omap type!\n");
>  		goto out;

I think you should keep the CONTROL_STATUS defines private to the
SCM core driver, there should be no need to pass it here. Just
make it int omap_control_status_read(void).

Of course that means that the SCM core is initialized to some extent
to know where to find the CONTROL_STATUS register. That should
probably be done as part of the set_globals calls done in init_early
in mach-omap2/io.c file.

Regards,

Tony
