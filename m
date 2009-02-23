From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2
Date: Mon, 23 Feb 2009 11:44:01 -0800
Message-ID: <87fxi59bwe.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F55511F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:33898 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbZBWToI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:44:08 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2074307rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 11:44:05 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F55511F7@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 13 Feb 2009 11\:30\:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> This patch updates the voltage levels for VDD1 OPP1/2 and
> VDD2 OPP1/2 according to the latest operating condition
> addendum for 3430.
>
> The new voltage levels at various OPP's for VDD1/2 are as below
>
> VDD1 OPP1 0.975v
> VDD1 OPP2 1.050v
> VDD1 OPP3 1.200v
> VDD1 OPP4 1.270v
> VDD1 OPP5 1.350v
>
> VDD2 OPP1 0.975v
> VDD2 OPP2 1.050v
> VDD2 OPP3 1.150v
>
> The patch applies on the latest pm head and is validated on 3430SDP.
>

This didn't apply to latest PM branch due to changes in the regbits
header.  I manually fixed this up and applied to PM branch.

Thanks,

Kevin

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap3-opp.h        |   12 ++++++------
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/omap3-opp.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/omap3-opp.h	2009-02-13 09:28:45.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/omap3-opp.h	2009-02-13 09:37:35.767125634 +0530
> @@ -24,9 +24,9 @@
>  static struct omap_opp omap3_mpu_rate_table[] = {
>  	{0, 0, 0},
>  	/*OPP1*/
> -	{S125M, VDD1_OPP1, 0x18},
> +	{S125M, VDD1_OPP1, 0x1E},
>  	/*OPP2*/
> -	{S250M, VDD1_OPP2, 0x20},
> +	{S250M, VDD1_OPP2, 0x24},
>  	/*OPP3*/
>  	{S500M, VDD1_OPP3, 0x30},
>  	/*OPP4*/
> @@ -38,9 +38,9 @@ static struct omap_opp omap3_mpu_rate_ta
>  static struct omap_opp omap3_l3_rate_table[] = {
>  	{0, 0, 0},
>  	/*OPP1*/
> -	{0, VDD2_OPP1, 0x18},
> +	{0, VDD2_OPP1, 0x1E},
>  	/*OPP2*/
> -	{S83M, VDD2_OPP2, 0x20},
> +	{S83M, VDD2_OPP2, 0x24},
>  	/*OPP3*/
>  	{S166M, VDD2_OPP3, 0x2C},
>  };
> @@ -48,9 +48,9 @@ static struct omap_opp omap3_l3_rate_tab
>  static struct omap_opp omap3_dsp_rate_table[] = {
>  	{0, 0, 0},
>  	/*OPP1*/
> -	{S90M, VDD1_OPP1, 0x18},
> +	{S90M, VDD1_OPP1, 0x1E},
>  	/*OPP2*/
> -	{S180M, VDD1_OPP2, 0x20},
> +	{S180M, VDD1_OPP2, 0x24},
>  	/*OPP3*/
>  	{S360M, VDD1_OPP3, 0x30},
>  	/*OPP4*/
> Index: linux-omap-2.6/arch/arm/mach-omap2/prm-regbits-34xx.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/prm-regbits-34xx.h	2009-02-13 09:26:16.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/prm-regbits-34xx.h	2009-02-13 10:12:07.005364895 +0530
> @@ -464,14 +464,14 @@
>  
>  /* PRM_VC_CMD_VAL_0 specific bits */
>  #define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
> -#define OMAP3430_VC_CMD_VAL0_ONLP			(0x3 << 3)
> -#define OMAP3430_VC_CMD_VAL0_RET			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL0_ONLP			(0xF << 1)
> +#define OMAP3430_VC_CMD_VAL0_RET			(0xF << 1)
>  #define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 4)
>  
>  /* PRM_VC_CMD_VAL_1 specific bits */
>  #define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
> -#define OMAP3430_VC_CMD_VAL1_ONLP			(0x3 << 3)
> -#define OMAP3430_VC_CMD_VAL1_RET			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL1_ONLP			(0xF << 1)
> +#define OMAP3430_VC_CMD_VAL1_RET			(0xF << 1)
>  #define OMAP3430_VC_CMD_VAL1_OFF			(0xB << 2)
>  
>  /* PRM_VC_CH_CONF */--

