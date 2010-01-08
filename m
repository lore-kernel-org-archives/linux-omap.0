From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/3][NAND][OMAP]: Fixing compilation warning for
 	'nand/omap2.c'
Date: Fri, 8 Jan 2010 20:31:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E1EB4063@dbde02.ent.ti.com>
References: <ce9ab5791001060600q1bef6ff5x602519e7db9e145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab0AHPB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 10:01:29 -0500
In-Reply-To: <ce9ab5791001060600q1bef6ff5x602519e7db9e145@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>, Linux MTD <linux-mtd@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Vimal Singh
> Sent: Wednesday, January 06, 2010 7:30 PM
> To: Linux MTD
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 1/3][NAND][OMAP]: Fixing compilation warning 
> for 'nand/omap2.c'
> 
> From 3e856346f93afaf3f519dffe7987e4bbf56a136d Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 5 Jan 2010 12:49:24 +0530
> Subject: [PATCH] Fixing compilation warning for 'nand/omap2.c'
> 
> Fixing below warning in compilation:
> drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
> drivers/mtd/nand/omap2.c:508: warning: passing argument 2 of
> 'omap_nand_dma_transfer' discards qualifiers from pointer target type
> 
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..4eea97c 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -505,7 +505,7 @@ static void 
> omap_write_buf_dma_pref(struct mtd_info *mtd,
>  		omap_write_buf_pref(mtd, buf, len);
>  	else
>  		/* start transfer in DMA mode */
> -		omap_nand_dma_transfer(mtd, buf, len, 0x1);
> +		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
>  }

Vimal,

I had posted the fix in DEC. Did you miss it?
http://lists.infradead.org/pipermail/linux-mtd/2009-December/028373.html

Best regards,
Sanjeev

> 
>  /**
> -- 
> 1.5.5
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 