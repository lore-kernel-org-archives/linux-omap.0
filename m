From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Use force-idle for UARTs because of
 DMA errata
Date: Tue, 16 Sep 2014 17:00:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409161605200.23518@utopia.booyaka.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com> <1410837126-31553-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53802 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbaIPRAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 13:00:53 -0400
In-Reply-To: <1410837126-31553-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi

A few comments

On Mon, 15 Sep 2014, Tony Lindgren wrote:

> In sprz318f.pdf "Usage Note 2.7" says that UARTs cannot acknowledge
> idle requests in smartidle mode when configured for DMA operations.

I don't have Rev. F here.  But reading between the typos in Rev. E, all it 
says that the UART should be placed into force-idle mode when there are no 
DMA transfers scheduled, otherwise CORE won't go idle.  However, this 
patch does a lot more than that...

> This prevents L4 from going idle. So let's use force-idle mode
> instead and also force reconfiguring of the IO chain wake-up events.
> 
> Otherwise systems using Sebastian's 8250 patches with DMA will
> never enter deeper idle states because of the errata above.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 61cd49d..55f088c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -490,7 +490,9 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
>  	.mpu_irqs	= omap2_uart1_mpu_irqs,
>  	.sdma_reqs	= omap2_uart1_sdma_reqs,
>  	.main_clk	= "uart1_fck",
> -	.flags		= DEBUG_TI81XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> +	.flags		= DEBUG_TI81XXUART1_FLAGS |
> +				HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
> +				HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,

... this patch makes four significant changes to the hwmod flags:

1. It changes HWMOD_SWSUP_SIDLE_ACT to HWMOD_SWSUP_SIDLE

2. It adds HWMOD_NO_OCP_AUTOIDLE

3. It adds HWMOD_FORCE_MSTANDBY

4. It adds HWMOD_RECONFIG_IO_CHAIN 

As far as I can tell, the only change that actually matches the erratum 
usage note is #1.  And even that should only be activated when the UART is 
in DMA mode.. PIO mode shouldn't need it.  (We used to have a DMA-specific 
workaround in the driver code for this years ago, which was only enabled 
when DMA was used, but it got ripped out in the rush to get rid of the 
platform_data function pointers.)

So that leaves the other three flag changes.  Of those three, adding 
HWMOD_FORCE_MSTANDBY is definitely not correct according to the 34xx 
public TRM Rev. ZV, since the UART IP blocks:

a) have no master port, 

b) do not contain DMA controllers (they rely on the SDMA), and 

c) according to the SYSC_REG register documentation in Table 17-112 of the 
above TRM, have no MIDLEMODE bit field.

So adding HWMOD_FORCE_MSTANDBY should have zero effect and it most likely 
should be dropped.

Regarding the rest: 

I'd be pretty surprised if HWMOD_RECONFIG_IO_CHAIN is needed.  If that was 
needed, I'd think we would have seen wakeup failures in this path a long 
time ago, since the console serial port is the primary debug tool we used
for waking the chip up from deep idle states on demand.

As far as HWMOD_NO_OCP_AUTOIDLE goes: does adding this flag have an effect 
when HWMOD_SWSUP_SIDLE is used?  If so then this should probably go in as 
a separate patch, because it's probably a separate bug than the one 
described in the commit message.

...

So I'd suggest restricting this patch to simply change 
HWMOD_SWSUP_SIDLE_ACT to HWMOD_SWSUP_SIDLE.  Then if the other flags are 
needed, would suggest adding them in separate patches, describing what 
problems are fixed by adding them.


- Paul
