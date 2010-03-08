From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] OMAP3: PM: Adding OMAP3630 support in smartreflex
 driver
Date: Mon, 8 Mar 2010 20:18:47 +0200
Message-ID: <20100308181846.GC6630@gandalf>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
 <1268068851-30022-3-git-send-email-thara@ti.com>
 <1268068851-30022-4-git-send-email-thara@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51276 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab0CHSSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:18:33 -0500
Content-Disposition: inline
In-Reply-To: <1268068851-30022-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

hi,

On Mon, Mar 08, 2010 at 10:50:51PM +0530, Thara Gopinath wrote:
> @@ -289,32 +311,66 @@ static void __init vp_reg_configure(int vp_id)
>  
>  		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
>  		if (vp_id == VP1) {
> -			/*
> -			 * OMAP3430 has error gain varying btw higher and
> -			 * lower opp's
> -			 */
> -			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
> -					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
> -					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
> +			u8 vlimitto_vddmin, vlimitto_vddmax;
> +
> +			if (cpu_is_omap3630()) {
> +				vlimitto_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
> +				vlimitto_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
> +				/*
> +				 * OMAP3630 has error gain varying btw
> +				 * all opp's
> +				 */
> +				vp_reg[vp_id].vp_errorgain =
> +					(omap_errorgain[get_vdd1_opp() - 1] <<
> +					OMAP3430_ERRORGAIN_SHIFT);

this error gain hunk repeats itself over and over again. How about
adding an inline function for handling that ? Also, why not using
SR version you added instead of cpu_is_xxx() check ?

-- 
balbi
