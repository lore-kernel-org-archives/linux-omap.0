From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FW: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on OMAP3430
Date: Wed, 21 Oct 2009 06:51:13 -0700
Message-ID: <87y6n4onxq.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA23E5A7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37276 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZJUNvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 09:51:16 -0400
Received: by ewy3 with SMTP id 3so6062035ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2009 06:51:19 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA23E5A7@dbde02.ent.ti.com> (Shweta Gulati's message of "Wed\, 21 Oct 2009 10\:28\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gulati, Shweta" <shweta.gulati@ti.com> writes:

> Any comments would be taken in.

Sorry, I did not see this v2 on the list nor do I find it in the archives.

> -----Original Message-----
> From: Gulati, Shweta 
> Sent: Tuesday, October 13, 2009 3:56 PM
> To: linux-omap@vger.kernel.org
> Cc: Gulati, Shweta; Gopinath, Thara
> Subject: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on OMAP3430
>
> From: Shweta Gulati <shweta.gulati@ti.com>
>
> (Resending the patch with the subject line and some minor fixes)
>
> According to Silicon Bug on context restore it is  found that the pad
> configuration register for GPIO_28/GPIO_29(ETKD14/15) is corrupted after
> returning from Core OFF mode. This happens if the MPU reads the
> PADCONF_SAVEDONE bit very close to the end of context save sequence
> for the pad conf registers, resulting in last context not being saved to the
> scratchpad  memory. This is a h/w bug. The workaround is to delay the
> MPU access of SAVEDONE bit until the last context has been saved.
>
> This patch adds a configuration option to allow 300 us delay in
> save path as recommended by TI. The other option is to let the
> bug occur but store the value of pad configuration register explicitly
> and write it back in resume path. But this option should be chosen
> only if the ETKD14/15 pads are not in use as this workaround can
> lead to glitch in the pin.
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>

Is this patch still needed with this fix recently postd by Nokia:

   http://marc.info/?l=linux-omap&m=125569123004013&w=2

Also, this description is still missing the Errata reference.  After
reading the errata, I don't think a Kconfig option is the right
answer.  Rather, the delay should be inserted iff the pin is enabled,
set as output, and set to high.

Also, the errata makes no mention of the 300usec delay.  Please describe
how that number was decided on.

Re: Subject, would be better as

OMAP3: PM: PADCONF restore fix for Errata x.xxx

> --- arch/arm/mach-omap2/pm34xx.c | 25 +++++++++++++++++++++++++
> arch/arm/plat-omap/Kconfig | 17 +++++++++++++++++ 2 files changed,
> 42 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index cea3bca..4f9671a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -26,6 +26,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  
>  #include <mach/sram.h>
>  #include <mach/prcm.h>
> @@ -54,10 +55,19 @@
>  
>  static int regset_save_on_suspend;
>  
> +/* A extra variable to store value of pad_config register if
> + * delay is not to be inserted and value is explicitly restored
> + * in resume path.
> + */
> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
> +static u32 store_pad_config;
> +#endif
> +
>  /* Scratchpad offsets */
>  #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
>  #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
> +#define CONTROL_PADCONF_ETK_D14			0x480025F8
>  
>  u32 enable_off_mode;
>  u32 sleep_while_idle;
> @@ -202,6 +212,17 @@ static void omap3_core_save_context(void)
>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>  	control_padconf_off |= START_PADCONF_SAVE;
>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
> +	store_pad_config = omap_readl(CONTROL_PADCONF_ETK_D14);

omap_read* deprecated.  Use omap_ctrl_readl(<offset>) as is done in
the rest of the code.

> +#else
> +	/* Due to Silicon Bug on context restore it is found
> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
> +	 * for 300us for scm to finish saving task
> +	 */
> +	udelay(300);
> +#endif
> +
>  	/* wait for the save to complete */
>  	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>  			& PADCONF_SAVE_DONE)
> @@ -217,6 +238,10 @@ static void omap3_core_save_context(void)
>  
>  static void omap3_core_restore_context(void)
>  {
> +	/* Restore the last padconf value if needed */
> +#ifndef CONFIG_DELAY_IN_PADCONF_SAVE
> +	omap_writel(store_pad_config, CONTROL_PADCONF_ETK_D14);
> +#endif
>  	/* Restore the control module context, padconf restored by h/w */
>  	omap3_control_restore_context();
>  	/* Restore the GPMC context */
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 2143db5..737d0aa 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -242,6 +242,23 @@ config OMAP_PM_SRF
>  
>  endchoice
>  
> +config DELAY_IN_PADCONF_SAVE
> +	bool "Insert 300 us delay after the start of padconf saving"
> +	depends on ARCH_OMAP3 && PM
> +	help
> +	 If this option is selected  a  300 us delay is inserted in the
> +	 suspend path after writing into START_PADCONF_SAVE bit to ensure
> +	 that pad configuration register is stored properly.If mpu tries to
> +	 access SAVE_DOME bit before the entire save is over, there is a
> +	 possibility that the last padconf register is not saved properly.
> +	 The delay ensures that mpu does not acess SAVE_DONE bit before the
> +	 save is complete.
> +
> +	 If this option is not selected the bug is let
> +	 to happen and last pad configuration register
> +	 is explicitly saved in SDRAM and written back
> +	 in resume path.
> +
>  endmenu
>  
>  endif

Kevin
