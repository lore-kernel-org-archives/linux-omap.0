From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was: Re: Beagleboard rev C memory timings & suspend/resume)
Date: Mon, 08 Jun 2009 07:59:36 -0700
Message-ID: <87y6s26aav.fsf@deeprootsystems.com>
References: <200904291553.49378.jpihet@mvista.com>
	<200906051735.57772.jpihet@mvista.com>
	<alpine.DEB.2.00.0906051207270.31531@utopia.booyaka.com>
	<200906081059.46134.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34716 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbZFHO7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 10:59:39 -0400
Received: by pzk1 with SMTP id 1so2278920pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2009 07:59:40 -0700 (PDT)
In-Reply-To: <200906081059.46134.jpihet@mvista.com> (Jean Pihet's message of "Mon\, 8 Jun 2009 10\:59\:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, tero.kristo@nokia.com, linux-omap <linux-omap@vger.kernel.org>

Jean Pihet <jpihet@mvista.com> writes:

> Paul,
>
> Here is the updated patch that fixes the Overo build as well.
> Can you check it?
>
> Kevin, can you push it if it is correct?

Can you run it through checkpatch, fix the errors and also merge Tero's
RX51 patch if it looks good to you.

Below are the checkpatch errors I get:  looks lik your mailer is
probably wrapping the patch and there is also one error to fix.

Kevin

ERROR: patch seems to be corrupt (line wrapped?)
#306: FILE: arch/arm/mach-omap2/clock34xx.c:477:
unsigned long rate)

ERROR: trailing whitespace
#494: FILE: arch/arm/mach-omap2/sdrc.c:128:
+ * @sdrc_cs[01]: pointers to a null-terminated list of struct $

total: 2 errors, 0 warnings, 648 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


>
> Regards,
> Jean
>
> From ebe57354b04444de059e1f042e0c488f761853f0 Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Fri, 5 Jun 2009 17:19:00 +0200
> Subject: OMAP3: add support for 2 SDRAM chip selects
>
> Some boards (Beagle Cx, Overo) have 2 SDRAM parts
> connected to the SDRC.
>
> This patch adds the following:
> - ensure that the CKE signals mux settings are correct
> - add a new argument of type omap_sdrc_params struct*
> to omap2_init_common_hw and omap2_sdrc_init for the 2nd CS params
> - adapted the OMAP boards files to the new prototype of
> omap2_init_common_hw. Only Beagle and Overo are using the 2 CS'es
> - adapt the sram sleep code to configure the SDRC for the 2nd CS
>
> Note: If the 2nd param to omap2_init_common_hw is NULL, then the
> parameters are not programmed into the SDRC CS1 registers
>
> Tested on 3430 SDP and Beagleboard rev C2 and B5, with
> suspend/resume and frequency changes (cpufreq).
>
> Thanks to Paul Walmsley and Kevin Hilman for the suggestions
> and code reviews.
>
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c      |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c      |    6 +-
>  arch/arm/mach-omap2/board-apollon.c      |    2 +-
>  arch/arm/mach-omap2/board-generic.c      |    2 +-
>  arch/arm/mach-omap2/board-h4.c           |    2 +-
>  arch/arm/mach-omap2/board-ldp.c          |    2 +-
>  arch/arm/mach-omap2/board-n800.c         |    2 +-
>  arch/arm/mach-omap2/board-omap2evm.c     |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c  |   11 ++-
>  arch/arm/mach-omap2/board-omap3evm.c     |    6 +-
>  arch/arm/mach-omap2/board-omap3pandora.c |    3 +-
>  arch/arm/mach-omap2/board-overo.c        |    9 ++-
>  arch/arm/mach-omap2/board-rx51.c         |    6 +-
>  arch/arm/mach-omap2/clock34xx.c          |   37 ++++++--
>  arch/arm/mach-omap2/io.c                 |    5 +-
>  arch/arm/mach-omap2/mux.c                |    6 ++
>  arch/arm/mach-omap2/sdrc.c               |   63 +++++++++-----
>  arch/arm/mach-omap2/sram34xx.S           |  137 
> +++++++++++++++++++++++-------
>  arch/arm/plat-omap/include/mach/io.h     |    3 +-
>  arch/arm/plat-omap/include/mach/mux.h    |    4 +
>  arch/arm/plat-omap/include/mach/sdrc.h   |    8 +-
>  arch/arm/plat-omap/include/mach/sram.h   |   23 +++--
>  arch/arm/plat-omap/sram.c                |   34 +++++---
>  23 files changed, 267 insertions(+), 108 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c 
> b/arch/arm/mach-omap2/board-2430sdp.c
> index aa5df72..4cb7bc5 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -322,7 +322,7 @@ out:
>  
>  static void __init omap_2430sdp_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	sdp2430_init_smc91x();
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c 
> b/arch/arm/mach-omap2/board-3430sdp.c
> index 195b749..24e2728 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -302,8 +302,10 @@ static inline void __init sdp3430_init_smc91x(void)
>  
>  static void __init omap_3430sdp_init_irq(void)
>  {
> -	omap2_init_common_hw(hyb18m512160af6_sdrc_params, omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL,
> +			     omap3_mpu_rate_table,
> +			     omap3_dsp_rate_table,
> +			     omap3_l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	sdp3430_init_smc91x();
> diff --git a/arch/arm/mach-omap2/board-apollon.c 
> b/arch/arm/mach-omap2/board-apollon.c
> index 2e24812..2dd1350 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -323,7 +323,7 @@ out:
>  
>  static void __init omap_apollon_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	apollon_init_smc91x();
> diff --git a/arch/arm/mach-omap2/board-generic.c 
> b/arch/arm/mach-omap2/board-generic.c
> index be763a9..763329b 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -33,7 +33,7 @@
>  
>  static void __init omap_generic_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  }
>  
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index 8f54939..17c3599 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -348,7 +348,7 @@ static void __init h4_init_flash(void)
>  
>  static void __init omap_h4_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	h4_init_flash();
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 9f41dc9..b012806 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -344,7 +344,7 @@ static inline void __init ldp_init_smc911x(void)
>  
>  static void __init omap_ldp_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	ldp_init_smc911x();
> diff --git a/arch/arm/mach-omap2/board-n800.c 
> b/arch/arm/mach-omap2/board-n800.c
> index ac7cf3f..ad53f4a 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -127,7 +127,7 @@ static struct lm8323_platform_data lm8323_pdata = {
>  
>  void __init nokia_n800_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  
> diff --git a/arch/arm/mach-omap2/board-omap2evm.c 
> b/arch/arm/mach-omap2/board-omap2evm.c
> index 4fac1be..56a26d4 100644
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -276,7 +276,7 @@ static struct twl4030_keypad_data omap2evm_kp_data = {
>  
>  static void __init omap2_evm_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	omap2evm_init_smc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7294dbf..872beb6 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -312,8 +312,11 @@ static int __init omap3_beagle_i2c_init(void)
>  
>  static void __init omap3_beagle_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +			     mt46h32m32lf6_sdrc_params,
> +			     omap3_mpu_rate_table,
> +			     omap3_dsp_rate_table,
> +			     omap3_l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> @@ -441,6 +444,10 @@ static void __init omap3_beagle_init(void)
>  	usb_musb_init();
>  	usb_ehci_init();
>  	omap3beagle_flash_init();
> +
> +	/* Ensure SDRC pins are mux'd for self-refresh */
> +	omap_cfg_reg(H16_34XX_SDRC_CKE0);
> +	omap_cfg_reg(H17_34XX_SDRC_CKE1);
>  }
>  
>  static void __init omap3_beagle_map_io(void)
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c 
> b/arch/arm/mach-omap2/board-omap3evm.c
> index f017f0d..3b9c96a 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -276,8 +276,10 @@ struct spi_board_info omap3evm_spi_board_info[] = {
>  
>  static void __init omap3_evm_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> +			     omap3_mpu_rate_table,
> +			     omap3_dsp_rate_table,
> +			     omap3_l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	omap3evm_init_smc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c 
> b/arch/arm/mach-omap2/board-omap3pandora.c
> index c67f62f..05ab99e 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -220,7 +220,8 @@ static int __init omap3pandora_i2c_init(void)
>  
>  static void __init omap3pandora_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> +			     NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-overo.c 
> b/arch/arm/mach-omap2/board-overo.c
> index 9eae608..50902d4 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -45,6 +45,7 @@
>  #include <mach/gpmc.h>
>  #include <mach/hardware.h>
>  #include <mach/nand.h>
> +#include <mach/mux.h>
>  #include <mach/usb.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
> @@ -355,7 +356,9 @@ static int __init overo_i2c_init(void)
>  
>  static void __init overo_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +			     mt46h32m32lf6_sdrc_params,
> +			     NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> @@ -391,6 +394,10 @@ static void __init overo_init(void)
>  	overo_init_smsc911x();
>  	overo_ads7846_init();
>  
> +	/* Ensure SDRC pins are mux'd for self-refresh */
> +	omap_cfg_reg(H16_34XX_SDRC_CKE0);
> +	omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +
>  	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
>  			  "OVERO_GPIO_W2W_NRESET") == 0) &&
>  	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {
> diff --git a/arch/arm/mach-omap2/board-rx51.c 
> b/arch/arm/mach-omap2/board-rx51.c
> index 09035b0..d48459f 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -64,8 +64,10 @@ static struct omap_board_config_kernel rx51_config[] = {
>  
>  static void __init rx51_init_irq(void)
>  {
> -	omap2_init_common_hw(rx51_get_sdram_timings(), omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(rx51_get_sdram_timings(), NULL,
> +			     omap3_mpu_rate_table,
> +			     omap3_dsp_rate_table,
> +			     omap3_l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 3cee6b4..f262787 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -478,7 +478,9 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, 
> unsigned long rate)
>  	u32 unlock_dll = 0;
>  	u32 c;
>  	unsigned long validrate, sdrcrate, mpurate;
> -	struct omap_sdrc_params *sp;
> +	struct omap_sdrc_params *sdrc_cs0;
> +	struct omap_sdrc_params *sdrc_cs1;
> +	int ret;
>  
>  	if (!clk || !rate)
>  		return -EINVAL;
> @@ -496,8 +498,8 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, 
> unsigned long rate)
>  	else
>  		sdrcrate >>= ((clk->rate / rate) >> 1);
>  
> -	sp = omap2_sdrc_get_params(sdrcrate);
> -	if (!sp)
> +	ret = omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
> +	if (ret)
>  		return -EINVAL;
>  
>  	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
> @@ -518,12 +520,29 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, 
> unsigned long rate)
>  
>  	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
>  		 validrate);
> -	pr_debug("clock: SDRC timing params used: %08x %08x %08x\n",
> -		 sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
> -
> -	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
> -				  sp->actim_ctrlb, new_div, unlock_dll, c,
> -				  sp->mr, rate > clk->rate);
> +	pr_debug("clock: SDRC CS0 timing params used:"
> +		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
> +		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
> +		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
> +	if (sdrc_cs1)
> +		pr_debug("clock: SDRC CS1 timing params used: "
> +		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
> +		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
> +		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
> +
> +	if (sdrc_cs1)
> +		omap3_configure_core_dpll(
> +				  new_div, unlock_dll, c, rate > clk->rate,
> +				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
> +				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
> +				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
> +				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
> +	else
> +		omap3_configure_core_dpll(
> +				  new_div, unlock_dll, c, rate > clk->rate,
> +				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
> +				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
> +				  0, 0, 0, 0);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 6fb6c29..aa000b4 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -231,7 +231,8 @@ static int __init _omap2_init_reprogram_sdrc(void)
>  	return v;
>  }
>  
> -void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
> +void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> +				 struct omap_sdrc_params *sdrc_cs1,
>  				 struct omap_opp *mpu_opps,
>  				 struct omap_opp *dsp_opps,
>  				 struct omap_opp *l3_opps)
> @@ -244,7 +245,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params 
> *sp,
>  	omapdev_init(omapdevs);
>  	omap2_clk_init();
>  	omap_pm_if_init();
> -	omap2_sdrc_init(sp);
> +	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>  
>  	_omap2_init_reprogram_sdrc();
>  
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 026c4fc..43d6b92 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -486,6 +486,12 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>  MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> +
> +/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
> +MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
> +		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
> +		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
>  };
>  
>  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index c832d83..b42f5ae 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -32,7 +32,7 @@
>  #include <mach/sdrc.h>
>  #include "sdrc.h"
>  
> -static struct omap_sdrc_params *sdrc_init_params;
> +static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
>  
>  void __iomem *omap2_sdrc_base;
>  void __iomem *omap2_sms_base;
> @@ -71,33 +71,49 @@ void omap2_sms_restore_context(void)
>  /**
>   * omap2_sdrc_get_params - return SDRC register values for a given clock rate
>   * @r: SDRC clock rate (in Hz)
> + * @sdrc_cs0: chip select 0 ram timings **
> + * @sdrc_cs1: chip select 1 ram timings **
>   *
>   * Return pre-calculated values for the SDRC_ACTIM_CTRLA,
> - * SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL, and SDRC_MR registers, for a given
> - * SDRC clock rate 'r'.  These parameters control various timing
> - * delays in the SDRAM controller that are expressed in terms of the
> - * number of SDRC clock cycles to wait; hence the clock rate
> - * dependency. Note that sdrc_init_params must be sorted rate
> - * descending.  Also assumes that both chip-selects use the same
> - * timing parameters.  Returns a struct omap_sdrc_params * upon
> - * success, or NULL upon failure.
> + *  SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL and SDRC_MR registers in sdrc_cs[01]
> + *  structs,for a given SDRC clock rate 'r'.
> + * These parameters control various timing delays in the SDRAM controller
> + *  that are expressed in terms of the number of SDRC clock cycles to
> + *  wait; hence the clock rate dependency.
> + *
> + * Supports 2 different timing parameters for both chip selects.
> + *
> + * Note 1: the sdrc_init_params_cs[01] must be sorted rate descending.
> + * Note 2: If sdrc_init_params_cs_1 is not NULL it must be of same size
> + *  as sdrc_init_params_cs_0.
> + *
> + * Fills in the struct omap_sdrc_params * for each chip select.
> + * Returns 0 upon success or -1 upon failure.
>   */
> -struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
> +int omap2_sdrc_get_params(unsigned long r,
> +			  struct omap_sdrc_params **sdrc_cs0,
> +			  struct omap_sdrc_params **sdrc_cs1)
>  {
> -	struct omap_sdrc_params *sp;
> +	struct omap_sdrc_params *sp0, *sp1;
>  
> -	if (!sdrc_init_params)
> -		return NULL;
> +	if (!sdrc_init_params_cs0)
> +		return -1;
>  
> -	sp = sdrc_init_params;
> +	sp0 = sdrc_init_params_cs0;
> +	sp1 = sdrc_init_params_cs1;
>  
> -	while (sp->rate && sp->rate != r)
> -		sp++;
> +	while (sp0->rate && sp0->rate != r) {
> +		sp0++;
> +		if (sdrc_init_params_cs1)
> +			sp1++;
> +	}
>  
> -	if (!sp->rate)
> -		return NULL;
> +	if (!sp0->rate)
> +		return -1;
>  
> -	return sp;
> +	*sdrc_cs0 = sp0;
> +	*sdrc_cs1 = sp1;
> +	return 0;
>  }
>  
>  
> @@ -109,13 +125,15 @@ void __init omap2_set_globals_sdrc(struct omap_globals 
> *omap2_globals)
>  
>  /**
>   * omap2_sdrc_init - initialize SMS, SDRC devices on boot
> - * @sp: pointer to a null-terminated list of struct omap_sdrc_params
> + * @sdrc_cs[01]: pointers to a null-terminated list of struct 
> omap_sdrc_params
> + *  Support for 2 chip selects timings
>   *
>   * Turn on smart idle modes for SDRAM scheduler and controller.
>   * Program a known-good configuration for the SDRC to deal with buggy
>   * bootloaders.
>   */
> -void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
> +void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> +			    struct omap_sdrc_params *sdrc_cs1)
>  {
>  	u32 l;
>  
> @@ -129,7 +147,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
>  	l |= (0x2 << 3);
>  	sdrc_write_reg(l, SDRC_SYSCONFIG);
>  
> -	sdrc_init_params = sp;
> +	sdrc_init_params_cs0 = sdrc_cs0;
> +	sdrc_init_params_cs1 = sdrc_cs1;
>  
>  	/* XXX Enable SRFRONIDLEREQ here also? */
>  	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index f41f8d9..3aef744 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -36,7 +36,7 @@
>  
>  	.text
>  
> -/* r4 parameters */
> +/* r1 parameters */
>  #define SDRC_NO_UNLOCK_DLL		0x0
>  #define SDRC_UNLOCK_DLL			0x1
>  
> @@ -71,40 +71,71 @@
>  
>  /*
>   * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
> - * r0 = new SDRC_RFR_CTRL register contents
> - * r1 = new SDRC_ACTIM_CTRLA register contents
> - * r2 = new SDRC_ACTIM_CTRLB register contents
> - * r3 = new M2 divider setting (only 1 and 2 supported right now)
> - * r4 = unlock SDRC DLL? (1 = yes, 0 = no).  Only unlock DLL for
> + *
> + * Params passed in registers:
> + *  r0 = new M2 divider setting (only 1 and 2 supported right now)
> + *  r1 = unlock SDRC DLL? (1 = yes, 0 = no).  Only unlock DLL for
>   *      SDRC rates < 83MHz
> - * r5 = number of MPU cycles to wait for SDRC to stabilize after
> + *  r2 = number of MPU cycles to wait for SDRC to stabilize after
>   *      reprogramming the SDRC when switching to a slower MPU speed
> - * r6 = new SDRC_MR_0 register value
> - * r7 = increasing SDRC rate? (1 = yes, 0 = no)
> + *  r3 = increasing SDRC rate? (1 = yes, 0 = no)
> + *
> + * Params passed via the stack. The needed params will be copied in SRAM
> + *  before use by the code in SRAM (SDRAM is not accessible during SDRC
> + *  reconfiguration):
> + *  new SDRC_RFR_CTRL_0 register contents
> + *  new SDRC_ACTIM_CTRL_A_0 register contents
> + *  new SDRC_ACTIM_CTRL_B_0 register contents
> + *  new SDRC_MR_0 register value
> + *  new SDRC_RFR_CTRL_1 register contents
> + *  new SDRC_ACTIM_CTRL_A_1 register contents
> + *  new SDRC_ACTIM_CTRL_B_1 register contents
> + *  new SDRC_MR_1 register value
>   *
> + * If the param SDRC_RFR_CTRL_1 is 0, the parameters
> + *  are not programmed into the SDRC CS1 registers
>   */
>  ENTRY(omap3_sram_configure_core_dpll)
>  	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
> -	ldr	r4, [sp, #52]		@ pull extra args off the stack
> -	ldr	r5, [sp, #56]		@ load extra args from the stack
> -	ldr	r6, [sp, #60]		@ load extra args from the stack
> -	ldr	r7, [sp, #64]		@ load extra args from the stack
> +
> +					@ pull the extra args off the stack
> +					@  and store them in SRAM
> +	ldr	r4, [sp, #52]
> +	str     r4, omap_sdrc_rfr_ctrl_0_val
> +	ldr	r4, [sp, #56]
> +	str     r4, omap_sdrc_actim_ctrl_a_0_val
> +	ldr	r4, [sp, #60]
> +	str     r4, omap_sdrc_actim_ctrl_b_0_val
> +	ldr	r4, [sp, #64]
> +	str     r4, omap_sdrc_mr_0_val
> +	ldr	r4, [sp, #68]
> +	str     r4, omap_sdrc_rfr_ctrl_1_val
> +	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
> +	beq	skip_cs1_params		@  do not use cs1 params
> +	ldr	r4, [sp, #72]
> +	str     r4, omap_sdrc_actim_ctrl_a_1_val
> +	ldr	r4, [sp, #76]
> +	str     r4, omap_sdrc_actim_ctrl_b_1_val
> +	ldr	r4, [sp, #80]
> +	str     r4, omap_sdrc_mr_1_val
> +skip_cs1_params:
>  	dsb				@ flush buffered writes to interconnect
> -	cmp	r7, #1			@ if increasing SDRC clk rate,
> +
> +	cmp	r3, #1			@ if increasing SDRC clk rate,
>  	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
> -	cmp	r4, #SDRC_UNLOCK_DLL	@ set the intended DLL state
> +	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
>  	bleq	unlock_dll
>  	blne	lock_dll
>  	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
>  	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
>  	bl	enable_sdrc		@ take SDRC out of idle
> -	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
> +	cmp	r1, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
>  	bleq	wait_dll_unlock
>  	blne	wait_dll_lock
> -	cmp	r7, #1			@ if increasing SDRC clk rate,
> +	cmp	r3, #1			@ if increasing SDRC clk rate,
>  	beq	return_to_sdram		@ return to SDRAM code, otherwise,
>  	bl	configure_sdrc		@ reprogram SDRC regs now
> -	mov	r12, r5
> +	mov	r12, r2
>  	bl	wait_clk_stable		@ wait for SDRC to stabilize
>  return_to_sdram:
>  	isb				@ prevent speculative exec past here
> @@ -149,7 +180,7 @@ configure_core_dpll:
>  	ldr	r12, [r11]
>  	ldr	r10, core_m2_mask_val	@ modify m2 for core dpll
>  	and	r12, r12, r10
> -	orr	r12, r12, r3, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
> +	orr	r12, r12, r0, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
>  	str	r12, [r11]
>  	ldr	r12, [r11]		@ posted-write barrier for CM
>  	bx	lr
> @@ -187,15 +218,34 @@ wait_dll_unlock:
>  	bne	wait_dll_unlock
>  	bx	lr
>  configure_sdrc:
> -	ldr	r11, omap3_sdrc_rfr_ctrl
> -	str	r0, [r11]
> -	ldr	r11, omap3_sdrc_actim_ctrla
> -	str	r1, [r11]
> -	ldr	r11, omap3_sdrc_actim_ctrlb
> -	str	r2, [r11]
> +	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
> +	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
> +	str	r12, [r11]			@ store
> +	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
> +	ldr	r11, omap3_sdrc_actim_ctrl_a_0
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_actim_ctrl_b_0_val
> +	ldr	r11, omap3_sdrc_actim_ctrl_b_0
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_mr_0_val
>  	ldr	r11, omap3_sdrc_mr_0
> -	str	r6, [r11]
> -	ldr	r6, [r11]		@ posted-write barrier for SDRC
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_rfr_ctrl_1_val
> +	cmp	r12, #0			@ if SDRC_RFR_CTRL_1 is 0,
> +	beq	skip_cs1_prog		@  do not program cs1 params
> +	ldr	r11, omap3_sdrc_rfr_ctrl_1
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
> +	ldr	r11, omap3_sdrc_actim_ctrl_a_1
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_actim_ctrl_b_1_val
> +	ldr	r11, omap3_sdrc_actim_ctrl_b_1
> +	str	r12, [r11]
> +	ldr	r12, omap_sdrc_mr_1_val
> +	ldr	r11, omap3_sdrc_mr_1
> +	str	r12, [r11]
> +skip_cs1_prog:
> +	ldr	r12, [r11]		@ posted-write barrier for SDRC
>  	bx	lr
>  
>  omap3_sdrc_power:
> @@ -206,14 +256,40 @@ omap3_cm_idlest1_core:
>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
>  omap3_cm_iclken1_core:
>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
> -omap3_sdrc_rfr_ctrl:
> +
> +omap3_sdrc_rfr_ctrl_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
> -omap3_sdrc_actim_ctrla:
> +omap3_sdrc_rfr_ctrl_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
> +omap3_sdrc_actim_ctrl_a_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
> -omap3_sdrc_actim_ctrlb:
> +omap3_sdrc_actim_ctrl_a_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
> +omap3_sdrc_actim_ctrl_b_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
> +omap3_sdrc_actim_ctrl_b_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
>  omap3_sdrc_mr_0:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
> +omap3_sdrc_mr_1:
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
> +omap_sdrc_rfr_ctrl_0_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_rfr_ctrl_1_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_actim_ctrl_a_0_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_actim_ctrl_a_1_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_actim_ctrl_b_0_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_actim_ctrl_b_1_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_mr_0_val:
> +	.word 0xDEADBEEF
> +omap_sdrc_mr_1_val:
> +	.word 0xDEADBEEF
> +
>  omap3_sdrc_dlla_status:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  omap3_sdrc_dlla_ctrl:
> @@ -223,3 +299,4 @@ core_m2_mask_val:
>  
>  ENTRY(omap3_sram_configure_core_dpll_sz)
>  	.word	. - omap3_sram_configure_core_dpll
> +
> diff --git a/arch/arm/plat-omap/include/mach/io.h 
> b/arch/arm/plat-omap/include/mach/io.h
> index 54c159b..d4c78b4 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -192,7 +192,8 @@ extern void omap1_map_common_io(void);
>  extern void omap1_init_common_hw(void);
>  
>  extern void omap2_map_common_io(void);
> -extern void omap2_init_common_hw(struct omap_sdrc_params *sp,
> +extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> +				 struct omap_sdrc_params *sdrc_cs1,
>  				 struct omap_opp *mpu_opps,
>  				 struct omap_opp *dsp_opps,
>  				 struct omap_opp *l3_opps);
> diff --git a/arch/arm/plat-omap/include/mach/mux.h 
> b/arch/arm/plat-omap/include/mach/mux.h
> index f7e298a..7368aba 100644
> --- a/arch/arm/plat-omap/include/mach/mux.h
> +++ b/arch/arm/plat-omap/include/mach/mux.h
> @@ -803,6 +803,10 @@ enum omap34xx_index {
>  	AE5_34XX_GPIO143,
>  	H19_34XX_GPIO164_OUT,
>  	J25_34XX_GPIO170,
> +
> +	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
> +	H16_34XX_SDRC_CKE0,
> +	H17_34XX_SDRC_CKE1,
>  };
>  
>  struct omap_mux_cfg {
> diff --git a/arch/arm/plat-omap/include/mach/sdrc.h 
> b/arch/arm/plat-omap/include/mach/sdrc.h
> index a678bc8..7e22143 100644
> --- a/arch/arm/plat-omap/include/mach/sdrc.h
> +++ b/arch/arm/plat-omap/include/mach/sdrc.h
> @@ -114,9 +114,11 @@ struct omap_sdrc_params {
>  
>  void omap2_sms_save_context(void);
>  void omap2_sms_restore_context(void);
> -void __init omap2_sdrc_init(struct omap_sdrc_params *);
> -struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
> -
> +void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> +			    struct omap_sdrc_params *sdrc_cs1);
> +int omap2_sdrc_get_params(unsigned long r,
> +			  struct omap_sdrc_params **sdrc_cs0,
> +			  struct omap_sdrc_params **sdrc_cs1);
>  #ifdef CONFIG_ARCH_OMAP2
>  
>  struct memory_timings {
> diff --git a/arch/arm/plat-omap/include/mach/sram.h 
> b/arch/arm/plat-omap/include/mach/sram.h
> index ad0a600..98906ea 100644
> --- a/arch/arm/plat-omap/include/mach/sram.h
> +++ b/arch/arm/plat-omap/include/mach/sram.h
> @@ -21,11 +21,13 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 
> dll_val,
>  				      u32 mem_type);
>  extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
>  
> -extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
> -				     u32 sdrc_actim_ctrla,
> -				     u32 sdrc_actim_ctrlb, u32 m2,
> -				     u32 unlock_dll, u32 f, u32 sdrc_mr,
> -				     u32 inc);
> +extern u32 omap3_configure_core_dpll(
> +			u32 m2, u32 unlock_dll, u32 f, u32 inc,
> +			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
> +			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
> +			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
> +			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> +
>  extern void omap3_sram_restore_context(void);
>  
>  /* Do not use these */
> @@ -61,11 +63,12 @@ extern void omap243x_sram_reprogram_sdrc(u32 perf_level, 
> u32 dll_val,
>  extern unsigned long omap243x_sram_reprogram_sdrc_sz;
>  
>  
> -extern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
> -					  u32 sdrc_actim_ctrla,
> -					  u32 sdrc_actim_ctrlb, u32 m2,
> -					  u32 unlock_dll, u32 f, u32 sdrc_mr,
> -					  u32 inc);
> +extern u32 omap3_sram_configure_core_dpll(
> +			u32 m2, u32 unlock_dll, u32 f, u32 inc,
> +			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
> +			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
> +			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
> +			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
>  extern unsigned long omap3_sram_configure_core_dpll_sz;
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a2e60e7..517f45b 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -368,23 +368,29 @@ static inline int omap243x_sram_init(void)
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  
> -static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
> -					      u32 sdrc_actim_ctrla,
> -					      u32 sdrc_actim_ctrlb,
> -					      u32 m2, u32 unlock_dll,
> -					      u32 f, u32 sdrc_mr, u32 inc);
> -u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
> -			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll,
> -			      u32 f, u32 sdrc_mr, u32 inc)
> - {
> +static u32 (*_omap3_sram_configure_core_dpll)(
> +				u32 m2, u32 unlock_dll, u32 f, u32 inc,
> +				u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
> +				u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
> +				u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
> +				u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> +
> +u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
> +			      u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
> +			      u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
> +			      u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
> +			      u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1)
> +{
>  	if (!_omap3_sram_configure_core_dpll)
>  		omap_sram_error();
>  
> -	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
> -					       sdrc_actim_ctrla,
> -					       sdrc_actim_ctrlb, m2,
> -					       unlock_dll, f, sdrc_mr, inc);
> - }
> +	return _omap3_sram_configure_core_dpll(
> +				m2, unlock_dll, f, inc,
> +				sdrc_rfr_ctrl_0, sdrc_actim_ctrl_a_0,
> +				sdrc_actim_ctrl_b_0, sdrc_mr_0,
> +				sdrc_rfr_ctrl_1, sdrc_actim_ctrl_a_1,
> +				sdrc_actim_ctrl_b_1, sdrc_mr_1);
> +}
>  
>  #ifdef CONFIG_PM
>  void omap3_sram_restore_context(void)
> -- 
> 1.6.2.5.168.g3823
>
>
> On Friday 05 June 2009 20:10:40 Paul Walmsley wrote:
>> Hi Jean,
>>
>> On Fri, 5 Jun 2009, Jean Pihet wrote:
>> > Here is the new patch that includes all the remarks and suggestion. The
>> > description is here below.
>> >
>> > Some notes:
>> > - all calls to omap2_init_common_hw have been adapted in the board files.
>> > it looks like 2430SDP and Pandora board files are broken since they use
>> > only one param. Can that be checked on those boards?
>> > - it is assumed that RX51 only uses 1 CS. Is that correct?
>> >
>> > Can you review it and possibly merge?
>>
>> Looks great.
>>
>> Tero, does RX51 use two SDRC chipselects!
>>
>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>
>> > Thanks & regards,
>> > Jean
>> >
