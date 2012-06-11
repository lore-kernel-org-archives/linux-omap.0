From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Mon, 11 Jun 2012 13:49:35 -0500
Message-ID: <4FD63DBF.9000200@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2FKStm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 14:49:42 -0400
In-Reply-To: <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 06/11/2012 09:02 AM, Afzal Mohammed wrote:
> Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
> clkactivationtime in gpmc_cs_set_timings(). This is done so
> that boards can configure these parameters of gpmc in Kernel
> instead of relying on bootloader.

What boards have been tested with this change?

Tony is going to want to know what we have tested with such changes to
avoid any regressions.

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |    6 ++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |    6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 578fd4c..517953f 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -313,6 +313,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  
>  	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
>  
> +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
> +
> +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> +
>  	if (cpu_is_omap34xx()) {
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> index 2e6e259..802fb22 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -128,6 +128,12 @@ struct gpmc_timings {
>  	u16 rd_cycle;		/* Total read cycle time */
>  	u16 wr_cycle;		/* Total write cycle time */
>  
> +	u16 bus_turnaround;
> +	u16 cycle2cycle_delay;
> +
> +	u16 wait_monitoring;
> +	u16 clk_activation;
> +
>  	/* The following are only on OMAP3430 */
>  	u16 wr_access;		/* WRACCESSTIME */
>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */

In general, I agree with this, but if we apply this today, it seems that
we *may* be clearing these fields if they have been configured by the
bootloader and hence this could introduce a regression (potentially).

So we ever need to test boards that this change impacts or at least
verify that this change would not impact these boards because these
fields have not been configured.

Cheers
Jon
