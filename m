From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Mon, 29 Nov 2010 11:29:27 -0800
Message-ID: <20101129192927.GG17222@atomide.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23887 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0K2T3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 14:29:36 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Pedanekar, Hemant <hemantp@ti.com> [101129 09:07]:
> Tony Lindgren wrote on Saturday, November 06, 2010 2:30 AM:
> 
> Though based on Cortex A8, TI816X series has differences in PRCM, PLL, clock
> structure compared to OMAP3.
> 
> Many of the OMAP3 specific checks are not applicable for TI816X. For example, 
> consider following:
> File - arch/arm/mach-omap2/omap_hwmod.c 
> Function - _wait_target_ready()
> 
> 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> 		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
> 				oh->prcm.omap2.idlest_reg_id,
> 				oh->prcm.omap2.idlest_idle_bit);
> 
> The above code inside cpu_is_omap34xx() check is not applicable for TI816X as
> there are no CM_IDELST registers.

OK, so places like these will need different handling, and should
then be based on some idlest flag that gets set during the init
based on cpu_is_omap24xx() || cpu_is_omap3430() || cpu_is_omap3630().

Have you looked at defining cpu_is_ti816x() based on features?

Something like:

#define cpu_is_ti816x()		(cpu_is_omap34xx() && \
					(omap3_has_xyz()) 

Where xyz is based on some runtime detected flag, just like
we do for sgx and iva.

Regards,

Tony
