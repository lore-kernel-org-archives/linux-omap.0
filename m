From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH] OMAP System Control fix for OMAP2420
Date: Mon, 10 Dec 2007 15:44:46 -0400
Message-ID: <475D972E.4070402@indt.org.br>
References: <1196897904-23457-1-git-send-email-david.cohen@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1196897904-23457-1-git-send-email-david.cohen@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Cohen <david.cohen@indt.org.br>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext David Cohen wrote:
> OMAP2420 has a different offset for CONTROL_STATUS register.
>
> Signed-off-by: David Cohen <david.cohen@indt.org.br>
> ---
>  arch/arm/mach-omap2/board-h4.c      |    2 +-
>  arch/arm/mach-omap2/id.c            |    5 ++++-
>  arch/arm/plat-omap/sram.c           |    2 +-
>  include/asm-arm/arch-omap/control.h |    3 +++
>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index 70c948c..4d5db60 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -272,7 +272,7 @@ static struct platform_device *h4_devices[] __initdata = {
>  /* 2420 Sysboot setup (2430 is different) */
>  static u32 get_sysboot_value(void)
>  {
> -	return (ctrl_read_reg(CONTROL_STATUS) & 0xFFF);
> +	return (ctrl_read_reg(OMAP242X_CONTROL_STATUS) & 0xFFF);
>  }
>  
>  /* FIXME: This function should be moved to some other file, gpmc.c? */
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 393b593..d84bf0e 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -162,7 +162,10 @@ void __init omap2_check_revision(void)
>  	/* Embedding the ES revision info in type field */
>  	system_rev = omap_ids[j].type;
>  
> -	ctrl_status = ctrl_read_reg(CONTROL_STATUS);
> +	if (cpu_is_omap242x())
> +		ctrl_status = ctrl_read_reg(OMAP242X_CONTROL_STATUS);
> +	else;
> +		ctrl_status = ctrl_read_reg(CONTROL_STATUS);
>  	system_rev |= (ctrl_status & 0x3f);
>  	system_rev |= (ctrl_status & 0x700);
>  
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index dd8dc04..851d4ee 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -94,7 +94,7 @@ static int is_sram_locked(void)
>  
>  #if defined(CONFIG_ARCH_OMAP242X)
>  	if (cpu_is_omap242x())
> -		type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
> +		type = ctrl_read_reg(OMAP242X_CONTROL_STATUS) & TYPE_MASK;
>  #endif
>  
>  	if (type == GP_DEVICE) {
> diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
> index 5f42725..6609bb3 100644
> --- a/include/asm-arm/arch-omap/control.h
> +++ b/include/asm-arm/arch-omap/control.h
> @@ -38,6 +38,9 @@
>  #define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
>  #define CONTROL_DEVCONF1		(CONTROL_GENERAL + 0x68) /* > 242x */
>  #define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
> +#define OMAP242X_CONTROL_STATUS		(CONTROL_STATUS + 0x08)
> +#define OMAP243X_CONTROL_STATUS		(CONTROL_STATUS)
> +#define OMAP34XX_CONTROL_STATUS		(CONTROL_STATUS)
>  
>  
>  /*
>   
Hi David,

Patch tested and working fine on H4 boards, it boots with no problems.

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
