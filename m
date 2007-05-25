From: Khem Raj <kraj@mvista.com>
Subject: Re: updated SDRC, PRCM, 3430 PRCM patch sets
Date: Fri, 25 May 2007 14:46:32 -0700
Message-ID: <200705251446.32561.kraj@mvista.com>
References: <Pine.LNX.4.64.0705250227520.11652@utopia.booyaka.com>
	<20070525185452.GM19506@atomide.com> <465757EE.4060403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <465757EE.4060403@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Friday 25 May 2007 14:41:02 Kevin Hilman wrote:

> OMAP2430 builds/boots ok for me, but as Khem just pointed out, OMAP1 builds
> are broken.
>
> This patch gets OMAP1 buildlng again:
>
> --- a/arch/arm/plat-omap/dsp/dsp_common.h
> +++ b/arch/arm/plat-omap/dsp/dsp_common.h
> @@ -28,10 +28,12 @@
>  #include <asm/arch/mmu.h>
>  #include "hardware_dsp.h"
>
> +#ifdef CONFIG_ARCH_OMAP2
>  #include "../../mach-omap2/prm.h"
>  #include "../../mach-omap2/prm_regbits_24xx.h"
>  #include "../../mach-omap2/cm.h"
>  #include "../../mach-omap2/cm_regbits_24xx.h"
> +#endif

Thanks Kevin

with this patch I am able to boot my 5912 OSK
