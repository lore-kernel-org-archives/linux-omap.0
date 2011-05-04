From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 3/4] omap: move detection of NAND CS to common-board-devices
Date: Tue, 3 May 2011 23:12:30 -0400
Message-ID: <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:51662 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab1EDDMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 23:12:46 -0400
In-Reply-To: <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

  This patch breaks compile for me:

On Apr 24, 2011, at 6:09 PM, Mike Rapoport wrote:

> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -29,6 +29,7 @@

...

> +void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
> +				 int nr_parts)
> +{
...
> +}
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> index 0ec3e07..ca03abf 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -39,4 +40,13 @@ static inline void omap_ads7846_init(int bus_num,
> }
> #endif
> 
> +#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> +void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
> +#else
> +static inline void omap_nand_flash_init(int opts, struct mtd_partition *parts,
> +					int nr_parts)
> +{
> +}

arch/arm/mach-omap2/common-board-devices.c:113: error: redefinition of 'omap_nand_flash_init'
arch/arm/mach-omap2/common-board-devices.h:46: note: previous definition of 'omap_nand_flash_init' was here

I don't have CONFIG_MTD_NAND_OMAP2 defined of course as there is no NAND flash on my board.

Bye,
    Oleg

