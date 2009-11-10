From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] am3517evm : add nand support
Date: Mon, 9 Nov 2009 16:53:19 -0800
Message-ID: <20091110005318.GQ23952@atomide.com>
References: <1256832298-14266-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63728 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZKJAxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 19:53:16 -0500
Content-Disposition: inline
In-Reply-To: <1256832298-14266-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org

* Sriramakrishnan <srk@ti.com> [091029 09:04]:
> Enable Nand support on am3517evm
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> ---
> This patch builds on the am3517evm board support patch submitted earlier.
> http://marc.info/?l=linux-omap&m=125673923227266&w=2
> 
>  arch/arm/configs/am3517_evm_defconfig |  103 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/board-am3517evm.c |  104 ++++++++++++++++++++++++++++++++-
>  2 files changed, 204 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/board-am3517evm.c
> 

<snip>

> +void __init am3517evm_flash_init(void)
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
> +		am3517evm_nand_data.cs   = nandcs;
> +		am3517evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
> +					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
> +		am3517evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
> +
> +		if (platform_device_register(&am3517evm_nand_device) < 0)
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +
> +	}
> +}

Yet more cut and paste hacks for the exact same code. Not merging.

Tony
