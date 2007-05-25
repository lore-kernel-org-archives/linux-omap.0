From: Khem Raj <kraj@mvista.com>
Subject: Re: [PATCH 16/18] omap2: convert DSP code to use new PRCM functions
	& defines
Date: Fri, 25 May 2007 14:32:43 -0700
Message-ID: <200705251432.44056.kraj@mvista.com>
References: <20070517001132.652728079@pwsan.com>
	<20070517005444.675356053@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070517005444.675356053@pwsan.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 May 2007 17:11:48 Paul Walmsley wrote:
> Convert the OMAP2-specific code in plat-omap/dsp to use the new PRCM
> read/write functions and symbolic constants for registers and register
> bits.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/dsp/dsp_common.h |   39
> ++++++++++++++++++++++++++--------- arch/arm/plat-omap/dsp/omap2_dsp.h  |  
>  1 -
>  2 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dsp/dsp_common.h
> b/arch/arm/plat-omap/dsp/dsp_common.h index 898c9ea..2369dad 100644
> --- a/arch/arm/plat-omap/dsp/dsp_common.h
> +++ b/arch/arm/plat-omap/dsp/dsp_common.h
> @@ -28,6 +28,11 @@
>  #include <asm/arch/mmu.h>
>  #include "hardware_dsp.h"
>
> +#include "../../mach-omap2/prm.h"
> +#include "../../mach-omap2/prm_regbits_24xx.h"
> +#include "../../mach-omap2/cm.h"
> +#include "../../mach-omap2/cm_regbits_24xx.h"
> +

I think the above includes will break OMAP1. Shouldn't they be included 
conditionally in
#ifdef CONFIG_ARCH_OMAP2
#endif
