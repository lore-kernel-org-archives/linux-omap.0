From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/4] OMAP: Voltage: add ABB structures and data
Date: Tue, 01 Mar 2011 14:05:56 -0800
Message-ID: <87mxleh4xn.fsf@ti.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
	<1298020853-13761-3-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43784 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753055Ab1CAWGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:06:00 -0500
Received: by iwr19 with SMTP id 19so5773205iwr.2
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 14:05:59 -0800 (PST)
In-Reply-To: <1298020853-13761-3-git-send-email-mturquette@ti.com> (Mike
	Turquette's message of "Fri, 18 Feb 2011 03:20:52 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Mike,

Mike Turquette <mturquette@ti.com> writes:

> OMAP3630 and OMAP4 support an Adaptive Body-Bias LDO on some voltage domains
> which effects voltage supplied to PMOS back-gates.  These LDOs have
> different operating modes which correspond to the voltage of each VDD.
>
> This patch introduces the data structures needed to represent the ABB LDOs
> in the voltage layer, and populates the appropriate data for 3630 and OMAP4.
> Note that OMAP34XX does not have this LDO, so any data for that chip has
> been initialized as zero.
>
> Signed-off-by: Mike Turquette <mturquette@ti.com>

This patch (and this series) should be updated based on Paul's split-up
of the voltage code & data series:

   http://marc.info/?l=linux-arm-kernel&m=129825439819340&w=2

> ---
>  arch/arm/mach-omap2/voltage.c             |  137 ++++++++++++++++++++++-------
>  arch/arm/plat-omap/include/plat/voltage.h |   28 ++++++
>  2 files changed, 133 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 0cbc58a..6ede092 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -39,6 +39,10 @@
>  #define VP_TRANXDONE_TIMEOUT	300
>  #define VOLTAGE_DIR_SIZE	16
>  
> +#define ABB_TRANXDONE_TIMEOUT	30
> +#define FAST_OPP		0x1
> +#define NOMINAL_OPP		0x0
> +
>  static struct omap_vdd_info *vdd_info;
>  /*
>   * Number of scalable voltage domains.
> @@ -59,6 +63,17 @@ static struct omap_vdd_info omap3_vdd_info[] = {
>  		.voltdm = {
>  			.name = "mpu",
>  		},
> +		.abb = {
> +			.setup_offs	= OMAP3_PRM_LDO_ABB_SETUP_OFFSET,
> +			.ctrl_offs	= OMAP3_PRM_LDO_ABB_CTRL_OFFSET,
> +			.irqstatus_mpu_offs
> +					= OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
> +			.done_st_shift	= OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
> +			.done_st_mask	= OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
> +			.configure	= NULL,
> +			.nb_handler	= NULL,
> +			.set_opp	= NULL,

NULL assignments are redundant.

[...]

Kevin
