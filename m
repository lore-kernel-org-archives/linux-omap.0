From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v2] mtd: omap: nand: Remove 0xFF's that prefixed 16bit
 NAND commands
Date: Mon, 29 Oct 2012 14:49:03 +0100
Message-ID: <20121029134903.GA30857@parrot.com>
References: <20121026193410.GA21474@harvey-pc.matrox.com>
 <20121026193643.GA21510@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [149.6.83.202] ([149.6.83.202]:43131 "EHLO co202.xi-lite.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759015Ab2J2Nt0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 09:49:26 -0400
Content-Disposition: inline
In-Reply-To: <20121026193643.GA21510@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Harvey <charvey@matrox.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Fri, Oct 26, 2012 at 08:36:43PM +0100, Christopher Harvey wrote:
> In 16bit NAND mode the GPMC would send the command 0xNN as 0xFFNN
> instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
> bits that were left unset in the GPMC command output register. The
> reason they weren't initialized in 16bit mode is that if the same code
> that writes to this register was used in 8bit mode then 2 commands
> would be output in 8bit mode. One for the low byte, and an extra 0x0
> command for the high byte. This commit uses writew if we're using
> 16bit NAND.
> 
> Most chips seem fine with the extra 0xFFs, but the ONFI spec says
> otherwise.

Hi Christopher,

Nitpick: I think you should replace 'command' with 'address' in your commit message.
The ONFI spec says Host should send _address_ byte NN as 0x00NN. It is OK to send
command NN as 0xFFNN, as explicitly mentioned in ONFI 3.1 spec (section 2.16):

  2.16.          Bus Width Requirements
All NAND Targets per device shall use the same data bus width. All targets shall either have an
8-bit bus width or a 16-bit bus width. Note that devices that support the NV-DDR or NV-DDR2
data interface shall have an 8-bit bus width.
When the host supports a 16-bit bus width, only data is transferred at the 16-bit width. All
address and command line transfers shall use only the lower 8-bits of the data bus. During
command transfers, the host may place any value on the upper 8-bits of the data bus. During
address transfers, the host shall set the upper 8-bits of the data bus to 00h.

Your patch deals with both command and address bytes, which does not hurt.
BR,
--
Ivan

> 
> Signed-off-by: Christopher Harvey <charvey@matrox.com>
> ---
>  drivers/mtd/nand/omap2.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5b31386..ae6738f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -225,16 +225,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>  {
>  	struct omap_nand_info *info = container_of(mtd,
>  					struct omap_nand_info, mtd);
> +	void __iomem *reg;
>  
>  	if (cmd != NAND_CMD_NONE) {
>  		if (ctrl & NAND_CLE)
> -			writeb(cmd, info->reg.gpmc_nand_command);
> -
> +			reg = info->reg.gpmc_nand_command;
>  		else if (ctrl & NAND_ALE)
> -			writeb(cmd, info->reg.gpmc_nand_address);
> -
> +			reg = info->reg.gpmc_nand_address;
>  		else /* NAND_NCE */
> -			writeb(cmd, info->reg.gpmc_nand_data);
> +			reg = info->reg.gpmc_nand_data;
> +
> +		if (info->nand.options & NAND_BUSWIDTH_16)
> +			writew(cmd, reg);
> +		else
> +			writeb(cmd, reg);
>  	}
>  }
>  
> -- 
> 1.7.8.6
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
