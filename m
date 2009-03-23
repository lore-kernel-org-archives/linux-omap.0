From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/07] OMAP3: SR: Fix init voltage on OPP change
Date: Mon, 23 Mar 2009 15:56:43 -0700
Message-ID: <87prg7u9uc.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EEF0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:62533 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCWW4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 18:56:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1975561rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 15:56:47 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EEF0@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 20 Mar 2009 18\:01\:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> This patch fixes a bug wherein the inital voltage was not set
> correctly on a OPP change
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   39 ++++++++++++++++++++++++++++++++++----
>  1 files changed, 35 insertions(+), 4 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-20 10:45:58.559625948 +0530
> +++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-20 10:46:08.898307561 +0530
> @@ -30,6 +30,7 @@
>  #include <mach/omap34xx.h>
>  #include <mach/control.h>
>  #include <mach/clock.h>
> +#include <mach/omap-pm.h>
>  
>  #include "prm.h"
>  #include "smartreflex.h"
> @@ -183,7 +184,6 @@ static void sr_set_efuse_nvalues(struct 
>  		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
>  					OMAP343X_SR1_SENNENABLE_MASK) >>
>  					OMAP343X_SR1_SENNENABLE_SHIFT;
> -
>  		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
>  					OMAP343X_SR1_SENPENABLE_MASK) >>
>  					OMAP343X_SR1_SENPENABLE_SHIFT;
> @@ -364,7 +364,9 @@ static void sr_configure(struct omap_sr 
>  
>  static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
>  {
> -	u32 nvalue_reciprocal;
> +	u32 nvalue_reciprocal, v;
> +
> +	BUG_ON(!(mpu_opps && l3_opps));
>  

This shouldn't be a BUG_ON() as we don't want the whole kernel to
halt here.  Rather, it should probably fail more gracefully.

As I looked into what this should return, I realized that we should
also get rid of the all the SR_PASS|FAIL and SR_TRUE|FALSE and just
use the standard kernel errno values for pass|fail and the kernel
already defines true and false.

Sorry to keep throwing more cleanup at you, but while you're in there
this one should be relatively easy to cleanup.

Kevin

>  	sr->req_opp_no = target_opp_no;
>  
> @@ -418,14 +420,43 @@ static int sr_enable(struct omap_sr *sr,
>  	sr_modify_reg(sr, ERRCONFIG,
>  			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
>  			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
> +
>  	if (sr->srid == SR1) {
> +		/* set/latch init voltage */
> +		v = prm_read_mod_reg(OMAP3430_GR_MOD,
> +				     OMAP3_PRM_VP1_CONFIG_OFFSET);
> +		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
> +		v |= mpu_opps[target_opp_no].vsel <<
> +			OMAP3430_INITVOLTAGE_SHIFT;
> +		prm_write_mod_reg(v, OMAP3430_GR_MOD,
> +				  OMAP3_PRM_VP1_CONFIG_OFFSET);
> +		/* write1 to latch */
> +		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +				     OMAP3_PRM_VP1_CONFIG_OFFSET);
> +		/* write2 clear */
> +		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +				       OMAP3_PRM_VP1_CONFIG_OFFSET);
>  		/* Enable VP1 */
>  		prm_set_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
> -				OMAP3_PRM_VP1_CONFIG_OFFSET);
> +				     OMAP3_PRM_VP1_CONFIG_OFFSET);
>  	} else if (sr->srid == SR2) {
> +		/* set/latch init voltage */
> +		v = prm_read_mod_reg(OMAP3430_GR_MOD,
> +				     OMAP3_PRM_VP2_CONFIG_OFFSET);
> +		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
> +		v |= l3_opps[target_opp_no].vsel <<
> +			OMAP3430_INITVOLTAGE_SHIFT;
> +		prm_write_mod_reg(v, OMAP3430_GR_MOD,
> +				  OMAP3_PRM_VP2_CONFIG_OFFSET);
> +		/* write1 to latch */
> +		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +				     OMAP3_PRM_VP2_CONFIG_OFFSET);
> +		/* write2 clear */
> +		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +				       OMAP3_PRM_VP2_CONFIG_OFFSET);
>  		/* Enable VP2 */
>  		prm_set_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
> -				OMAP3_PRM_VP2_CONFIG_OFFSET);
> +				     OMAP3_PRM_VP2_CONFIG_OFFSET);
>  	}
>  
>  	/* SRCONFIG - enable SR */--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
