From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: [PATCH v6 2/3] omap3 nand: cleanup virtual address usages
Date: Mon, 20 Dec 2010 10:50:10 +1300
Message-ID: <201012201050.10726.manningc2@actrix.gen.nz>
References: <1278660308-8689-1-git-send-email-s-ghorai@ti.com> <1278660308-8689-2-git-send-email-s-ghorai@ti.com> <1278660308-8689-3-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:52987 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757218Ab0LSVuM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Dec 2010 16:50:12 -0500
In-Reply-To: <1278660308-8689-3-git-send-email-s-ghorai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, linux-omap@vger.kernel.org

On Friday 09 July 2010 19:25:07 Sukumar Ghorai wrote:

> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -21,13 +21,11 @@ struct omap_nand_platform_data {
>  	int			(*dev_ready)(struct omap_nand_platform_data *);
>  	int			dma_channel;
>  	unsigned long		phys_base;
> -	void __iomem		*gpmc_cs_baseaddr;
> -	void __iomem		*gpmc_baseaddr;
>  	int			devsize;
>  };
>
> -/* size (4 KiB) for IO mapping */
> -#define	NAND_IO_SIZE	SZ_4K
> +/* minimum size for IO mapping */
> +#define	NAND_IO_SIZE	4

Is this really only for a 4-byte region? I would have expected that this 
controls access to a multi-register NAND controller and should really be 
larger. 

-- Charles

