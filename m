From: Kevin Hilman <khilman@mvista.com>
Subject: Re: updated SDRC, PRCM, 3430 PRCM patch sets
Date: Fri, 25 May 2007 14:41:02 -0700
Message-ID: <465757EE.4060403@mvista.com>
References: <Pine.LNX.4.64.0705250227520.11652@utopia.booyaka.com>
	<20070525185452.GM19506@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070525185452.GM19506@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [070525 01:40]:
>> Hi,
>>
>> following this message are the updated versions of the SDRC cleanup, PRCM 
>> cleanup, and 3430 PRCM patchsets.  These are intended to be applied on top 
>> of the omap24xx.h cleanup patchset that I posted a few days ago.
> 
> Pushing all of them today, please everybody verify that things work
> the same way as before for your omap2 boards.
> 

OMAP2430 builds/boots ok for me, but as Khem just pointed out, OMAP1 builds are broken.

This patch gets OMAP1 buildlng again:

--- a/arch/arm/plat-omap/dsp/dsp_common.h
+++ b/arch/arm/plat-omap/dsp/dsp_common.h
@@ -28,10 +28,12 @@
 #include <asm/arch/mmu.h>
 #include "hardware_dsp.h"
 
+#ifdef CONFIG_ARCH_OMAP2
 #include "../../mach-omap2/prm.h"
 #include "../../mach-omap2/prm_regbits_24xx.h"
 #include "../../mach-omap2/cm.h"
 #include "../../mach-omap2/cm_regbits_24xx.h"
+#endif
 
 #define DSPSPACE_SIZE	0x1000000
 
