From: Tony Lindgren <tony@atomide.com>
Subject: Re: updated SDRC, PRCM, 3430 PRCM patch sets
Date: Fri, 25 May 2007 14:51:02 -0700
Message-ID: <20070525215102.GB21314@atomide.com>
References: <Pine.LNX.4.64.0705250227520.11652@utopia.booyaka.com>
	<20070525185452.GM19506@atomide.com> <465757EE.4060403@mvista.com>
	<20070525214511.GA21314@atomide.com> <465759A8.1030607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <465759A8.1030607@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070525 14:48]:
> Fix OMAP1 builds after SDRC/PRCM updates.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
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
>  
>  #define DSPSPACE_SIZE	0x1000000
>  
> 

Thanks, pushed.

Tony
