From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3evm : enable nand support
Date: Mon, 9 Nov 2009 16:52:25 -0800
Message-ID: <20091110005224.GP23952@atomide.com>
References: <1256821328-28765-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61739 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZKJAwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 19:52:21 -0500
Content-Disposition: inline
In-Reply-To: <1256821328-28765-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Sriramakrishnan <srk@ti.com> [091029 06:02]:
> Enable Nand suport on the OMAP3EVM.
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> ---
> This patch has been generated against the tip of for-next branch.
> 
>  arch/arm/configs/omap3_evm_defconfig |    2 +
>  arch/arm/mach-omap2/board-omap3evm.c |  102 ++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 0 deletions(-)
> 

<snip>

> +void __init omap3evm_flash_init(void)
> +{
> +	u8 cs = 0;
> +	u8 nandcs = GPMC_CS_NUM + 1;
> +	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
> +
> +	while (cs < GPMC_CS_NUM) {
> +		u32 ret = 0;
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		if ((ret & 0xC00) == 0x800) {
> +			/* Found it!! */
> +			if (nandcs > GPMC_CS_NUM)
> +				nandcs = cs;
> +		}
> +		cs++;
> +	}
> +	if (nandcs > GPMC_CS_NUM) {
> +		printk(KERN_INFO "NAND: Unable to find configuration "
> +			" in GPMC\n ");
> +		return;
> +	}
> +
> +	if (nandcs < GPMC_CS_NUM) {
> +		omap3evm_nand_data.cs   = nandcs;
> +		omap3evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
> +					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
> +		omap3evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
> +
> +		if (platform_device_register(&omap3evm_nand_device) < 0) {
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +			}
> +	}
> +}
> +

To me it looks like this should work with the sdp-flash.c once the
flash detection code is done in a clean way.

Not adding yet more cut and paste hacks, please coordinate within
TI on adding the flash detection in a sane way.

Regards,

Tony
