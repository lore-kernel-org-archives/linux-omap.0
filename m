From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 2/4] ARM: OMAP3/4: omap_hwmod: Add rstst_off field to
 struct omap_hwmod_omap4_prcm
Date: Tue, 29 May 2012 06:31:46 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA39298@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <1333123435-27186-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab2E2Gb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 May 2012 02:31:58 -0400
In-Reply-To: <1333123435-27186-3-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 30, 2012 at 21:33:53, Hiremath, Vaibhav wrote:
> In case of AM33XX device, XXX_RSTST register offset is not
> consistent across PRM modules/instances,
> 
> PRM_XXX            RSTST
> =========================
> PRM_PER_MOD:       0x04
> PRM_WKUP_MOD:      0x0C
> PRM_MPU_MOD:       NA
> PRM_DEVICE_MOD:    0x08
> 
> This means, we need to pass on XXX_RSTST register offset
> information through omap_hwmod data, similar to XXX_RSTCTRL.
> 
> Currently, this field is only applicable and used for AM33XX
> devices.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 9ae87eb..50f42ec 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -374,11 +374,13 @@ struct omap_hwmod_omap2_prcm {
>   * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
>   * @clkctrl_reg: PRCM address of the clock control register
>   * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
> + * @rstst_reg: (AM33XX Only) address of the XXX_RSTST register located in the PRM
>   * @submodule_wkdep_bit: bit shift of the WKDEP range
>   */
>  struct omap_hwmod_omap4_prcm {
>  	u16		clkctrl_offs;
>  	u16		rstctrl_offs;
> +	u16		rstst_offs;
>  	u16		context_offs;
>  	u8		submodule_wkdep_bit;
>  	u8		modulemode;

Paul,

We have missed this patch from the series, can you merge this one as well?

Thanks,
Vaibhav
