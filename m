From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND 1/1] omap4: control: Add the
 CONTROL_SMART2IO_PADCONF_2 register definition
Date: Mon, 8 Apr 2013 13:56:33 -0700
Message-ID: <20130408205633.GV10155@atomide.com>
References: <1363219908-32007-1-git-send-email-ruslan.bilovol@ti.com>
 <1363219908-32007-2-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25852 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964892Ab3DHU4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 16:56:40 -0400
Content-Disposition: inline
In-Reply-To: <1363219908-32007-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130313 17:16]:
> This patch adds missing CONTROL_SMART2IO_PADCONF_2 register
> definition

Sorry for the delay on this one. After looking at these registers,
there's no need to define them here.

These all relate to pinconf, and these all can now be handled by
generic pinconf using pinctrl-single.c. There's generic pinconf
support added to pinctrl-single.c in linux next by Haojian Zhuang.

This means that you can just define these in the .dts file for
the board, and you can select the board specific values for things
like output buffer.

In Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
you should see what all is already supported, and if it's not,
we can patch it in. That's in current linux next queued for
v3.10.

Regards,

Tony
 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h |   45 +++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
> index c88420d..d512ade 100644
> --- a/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
> +++ b/arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
> @@ -46,6 +46,7 @@
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART3IO_PADCONF_2	0x05c0
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_USBB_HSIC		0x05c4
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SLIMBUS		0x05c8
> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART2IO_PADCONF_2	0x05cc
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE		0x0600
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_0		0x0604
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX		0x0608
> @@ -764,6 +765,50 @@
>  #define OMAP4_HSI_DR0_LB_SHIFT					10
>  #define OMAP4_HSI_DR0_LB_MASK					(1 << 10)
>  
> +/* CONTROL_SMART2IO_PADCONF_2 */
> +#define OMAP4_DPM_DR1_DS_SHIFT					31
> +#define OMAP4_DPM_DR1_DS_MASK					(1 << 31)
> +#define OMAP4_DPM_DR2_DS_SHIFT					30
> +#define OMAP4_DPM_DR2_DS_MASK					(1 << 30)
> +#define OMAP4_DPM_DR3_DS_SHIFT					29
> +#define OMAP4_DPM_DR3_DS_MASK					(1 << 29)
> +#define OMAP4_GPIO_DR10_DS_SHIFT				28
> +#define OMAP4_GPIO_DR10_DS_MASK					(1 << 28)
> +#define OMAP4_HSI2_DR0_DS_SHIFT					27
> +#define OMAP4_HSI2_DR0_DS_MASK					(1 << 27)
> +#define OMAP4_HSI2_DR1_DS_SHIFT					26
> +#define OMAP4_HSI2_DR1_DS_MASK					(1 << 26)
> +#define OMAP4_HSI2_DR2_DS_SHIFT					25
> +#define OMAP4_HSI2_DR2_DS_MASK					(1 << 25)
> +#define OMAP4_SDMMC3_DR0_DS_SHIFT				24
> +#define OMAP4_SDMMC3_DR0_DS_MASK				(1 << 24)
> +#define OMAP4_SDMMC4_DR0_DS_SHIFT				23
> +#define OMAP4_SDMMC4_DR0_DS_MASK				(1 << 23)
> +#define OMAP4_SDMMC4_DR1_DS_SHIFT				22
> +#define OMAP4_SDMMC4_DR1_DS_MASK				(1 << 22)
> +#define OMAP4_SPI3_DR0_DS_SHIFT					21
> +#define OMAP4_SPI3_DR0_DS_MASK					(1 << 21)
> +#define OMAP4_SPI3_DR1_DS_SHIFT					20
> +#define OMAP4_SPI3_DR1_DS_MASK					(1 << 20)
> +#define OMAP4_UART3_DR2_DS_SHIFT				19
> +#define OMAP4_UART3_DR2_DS_MASK					(1 << 19)
> +#define OMAP4_UART3_DR3_DS_SHIFT				18
> +#define OMAP4_UART3_DR3_DS_MASK					(1 << 18)
> +#define OMAP4_UART3_DR4_DS_SHIFT				17
> +#define OMAP4_UART3_DR4_DS_MASK					(1 << 17)
> +#define OMAP4_UART3_DR5_DS_SHIFT				16
> +#define OMAP4_UART3_DR5_DS_MASK					(1 << 16)
> +#define OMAP4_USBA0_DR0_DS_SHIFT				15
> +#define OMAP4_USBA0_DR0_DS_MASK					(1 << 15)
> +#define OMAP4_USBA0_DR1_DS_SHIFT				14
> +#define OMAP4_USBA0_DR1_DS_MASK					(1 << 14)
> +#define OMAP4_USBA_DR2_DS_SHIFT					13
> +#define OMAP4_USBA_DR2_DS_MASK					(1 << 13)
> +#define OMAP4_USBB2_DR0_DS_SHIFT				12
> +#define OMAP4_USBB2_DR0_DS_MASK					(1 << 12)
> +#define OMAP4_USBB1_DR0_DS_SHIFT				11
> +#define OMAP4_USBB1_DR0_DS_MASK					(1 << 11)
> +
>  /* CONTROL_USBB_HSIC */
>  #define OMAP4_USBB2_DR1_SR_SHIFT				30
>  #define OMAP4_USBB2_DR1_SR_MASK					(0x3 << 30)
> -- 
> 1.7.9.5
> 
