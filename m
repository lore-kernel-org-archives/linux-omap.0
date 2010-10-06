From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: PM: check UART status before trying to idle
Date: Wed, 6 Oct 2010 10:48:49 -0700
Message-ID: <20101006174849.GC2913@atomide.com>
References: <1286380338-4072-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56359 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070Ab0JFRs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 13:48:57 -0400
Content-Disposition: inline
In-Reply-To: <1286380338-4072-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101006 08:43]:
> As is done on OMAP3, check omap_uart_can_sleep() as one of the
> pre-conditions for entering the idle loop.  Without this check,
> entering idle introduces large latencies on active UARTs, and is
> especially noticable on serial console.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Tony, this fixes the UART lag when using the serial console on n8x0.
> With this, the UARTs will not idle until their sleep timeouts are
> activated, and they're disabled by default.
> 
> There's an additional bug I'm still looking into as to why UART3
> does not trigger wakeup from idle on 2420, but that is only triggered
> after enabling UART timeouts.
> 
>  arch/arm/mach-omap2/pm24xx.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index c1bceec..a40457d 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -245,6 +245,8 @@ static int omap2_can_sleep(void)
>  {
>  	if (omap2_fclks_active())
>  		return 0;
> +	if (!omap_uart_can_sleep())
> +		return 0;
>  	if (osc_ck->usecount > 1)
>  		return 0;
>  	if (omap_dma_running())

Thanks, I'll add that to omap-for-linus. Also the following change
is needed for the n8x0 boards that use the kernel cmdline only.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Oct 2010 10:09:03 -0700
Subject: [PATCH] omap: Update omap2plus_defconfig to use ttyO instead ttyS

With the omap-serial the device has changed from ttyS to ttyO as
the system may have both omap-serial and 8250 ports.

Note that systems using omap-serial need to be updated to use ttyO[012]
instead of ttyS[012] in the bootloader, CONFIG_CMDLINE, /etc/inittab,
and the root file system with mknod. Also you may need to add ttyO[012]
to /etc/securetty.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7deec89..ccedde1 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -63,7 +63,7 @@ CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyS2,115200"
+CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
