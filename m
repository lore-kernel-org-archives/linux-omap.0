From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 2/7] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Thu, 03 Jun 2010 10:40:15 -0700
Message-ID: <87eigovwu8.fsf@deeprootsystems.com>
References: <1274186051-23871-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51121 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab0FCRkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 13:40:20 -0400
Received: by pvg16 with SMTP id 16so174286pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 10:40:19 -0700 (PDT)
In-Reply-To: <1274186051-23871-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Tue\, 18 May 2010 18\:04\:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> This patch will have the changes to use separate clk/volt setup_time
> for RET and OFF state.
>
> Create separate copies of VC parameters for each Si in voltage.c.
> Updates the VC setuptime struct during init based on the OMAP Si.
> Removes the VC setuptime struct from board files.
>
> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

OK, so you addressed one of my comments from the previous review[1],
but didn't address the others, so they have re-appeared in this
series, only in different patches this time. :(

[...]


> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index c6445c5..cc2b355 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -14,6 +14,31 @@
>  #define VDD1	0
>  #define VDD2	1
>  
> +struct setuptime_vc{
> +	u16 clksetup;
> +	u16 voltsetup1_vdd1;
> +	u16 voltsetup1_vdd2;
> +	u16 voltsetup2;
> +	u16 voltoffset;
> +};
> +
> +struct prm_setup_vc {
> +/* CLK & VOLT SETUPTIME for RET */
> +	struct setuptime_vc ret;
> +/* CLK & VOLT SETUPTIME for OFF */
> +	struct setuptime_vc off;
> +/* PRM_VC_CMD_VAL_0 specific bits */
> +	u16 vdd0_on;
> +	u16 vdd0_onlp;
> +	u16 vdd0_ret;
> +	u16 vdd0_off;
> +/* PRM_VC_CMD_VAL_1 specific bits */
> +	u16 vdd1_on;
> +	u16 vdd1_onlp;
> +	u16 vdd1_ret;
> +	u16 vdd1_off;
> +};
> +

Copy-paste from previous review[1]:

Minor nit (and not your fault since you inherited it):

Please indent the comments to the same level as the code.

Kevin


[1] http://marc.info/?l=linux-omap&m=127249508726287&w=2
