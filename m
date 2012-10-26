From: Christopher Harvey <charvey@matrox.com>
Subject: Re: [PATCH v2 1/1] mtd: omap: nand: Remove 0xFF's that prefixed
 16bit NAND commands
Date: Fri, 26 Oct 2012 10:49:15 -0400
Message-ID: <20121026144915.GA3110@harvey-pc.matrox.com>
References: <20121019172457.GA7608@harvey-pc.matrox.com>
 <20121019174252.GA7831@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout6.matrox.com ([138.11.2.96]:60627 "EHLO
	mtxmxout6.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306Ab2JZOqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 10:46:08 -0400
Received: from venus.matrox.com (venus.matrox.com [192.168.1.30])
	by mtxmxout6.matrox.com (Postfix) with ESMTP id 5C6521D74E6
	for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 10:46:06 -0400 (EDT)
Received: (from ssmsp@localhost)
	by venus.matrox.com (8.14.4/8.13.2) id q9QEk69r002272
	for linux-omap@vger.kernel.org; Fri, 26 Oct 2012 10:46:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by venus.matrox.com (Postfix) with ESMTP id BF53EF4DB8
	for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 10:46:05 -0400 (EDT)
Received: from pluton.matrox.com (pluton.matrox.com [192.168.8.7])
	by venus.matrox.com (Postfix) with ESMTP id 85B97F4DB6
	for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 10:46:05 -0400 (EDT)
Received: from harvey-pc.matrox.com (dyn-152-224.matrox.com [192.168.152.224])
	by pluton.matrox.com (Postfix) with ESMTP id 715727F45F
	for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 10:46:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20121019174252.GA7831@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, Oct 19, 2012 at 01:42:52PM -0400, Christopher Harvey wrote:
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
> 
> Signed-off-by: Christopher Harvey <charvey@matrox.com>
> ---
>  drivers/mtd/nand/omap2.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5c8978e..6e1c1e5 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -232,16 +232,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
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

Ping?
