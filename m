From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Sat, 2 Oct 2010 10:12:50 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B8@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285936577-14881-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56023 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab0JBEnE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 00:43:04 -0400
In-Reply-To: <1285936577-14881-2-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>


Peter,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Friday, October 01, 2010 6:06 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> Subject: [PATCH v3 1/2] omap: dma: Fix buffering disable bit 
> setting for omap24xx
> 
> From: Jarkko Nikula <jhnikula@gmail.com>
> 
> An errata workaround for omap24xx is not setting the 
> buffering disable bit
> 25 what is the purpose but channel enable bit 7 instead.
> 
> Background for this fix is the DMA stalling issue with ASoC 
> omap-mcbsp driver. Peter Ujfalusi <peter.ujfalusi@nokia.com> 
> has found an issue in recording that the DMA stall could 
> happen if there were a buffer overrun detected by ALSA and 
> the DMA was stopped and restarted due that. This problem is 
> known to occur on both OMAP2420 and OMAP3. It can recover on
> OMAP3 after dma free, dma request and reconfiguration cycle. 
> However, on OMAP2420 it seems that only way to recover is a reset.
> 
> Problem was not visible before the commit c12abc0. That 
> commit changed that the McBSP transmitter/receiver is 
> released from reset only when needed. That is, only enabled 
> McBSP transmitter without transmission was able to prevent 
> this DMA stall problem in receiving side and underlying 
> problem did not show up until now. McBSP transmitter itself 
> seems to no be reason since DMA stall does not recover by 
> enabling the transmission after stall.
> 
> Debugging showed that there were a DMA write active during 
> DMA stop time and it never completed even when restarting the 
> DMA. Experimenting showed that the DMA buffering disable bit 
> could be used to avoid stalling when using source 
> synchronized transfers. However that could have performance hit and
> OMAP3 TRM states that buffering disable is not allowed for 
> destination synchronized transfers so subsequent patch will 
> implement a method to complete DMA writes when stopping.
> 
> This patch is based on assumtion that complete lock-up on 
> OMAP2420 is different but related problem. I don't have 
> access to OMAP2420 errata but I believe this old workaround 
> here is put for a reason but unfortunately a wrong bit was 
> typed and problem showed up only now.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c              |    2 +-
>  arch/arm/plat-omap/include/plat/dma.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c 
> b/arch/arm/plat-omap/dma.c index ec7eddf..7115884 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1000,7 +1000,7 @@ void omap_start_dma(int lch)
>  	 * This will always fail on ES1.0
>  	 */
>  	if (cpu_is_omap24xx())
> -		l |= OMAP_DMA_CCR_EN;
> +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;

This issue is applicable only for 2430ES1.0(not sure about 2420)
and it got fixed with later ES versions. 
cpu check should be replaced with:

if (cpu_is_omap2420() || (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))

-Manjunath
