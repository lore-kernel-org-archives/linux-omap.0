From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/3] nand: Renaming, moving and fixing NAND and ELM drivers
Date: Fri, 12 Sep 2014 11:54:24 +0300
Message-ID: <5412B4C0.505@ti.com>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaILIyz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2014 04:54:55 -0400
In-Reply-To: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

Hi Ezequiel,

On 09/11/2014 04:47 PM, Ezequiel Garcia wrote:
> Following the recent discussion with Roger, here's a few patches that
> (hopefully) fix all the issues.
> 
> The first patches rename the OMAP NAND drivers, so they are now called
> omap2_nand and omap_elm.
> 
> The last patch picks an idea from Yann E. Morin and fixes the build issue
> reported by Roger. Quoting Roger:
> 
> ""
> I still get the following error if I set CONFIG_MTD_NAND_OMAP2 to y and
> CONFIG_MTD_NAND_OMAP_BCH to m.
> 
> CONFIG_MTD_NAND_OMAP_BCH is used to select the ELM driver and it must be limited to
> be built-in if CONFIG_MTD_NAND_OMAP2 is built-in.
> 
> Maybe it should be a sub option of CONFIG_MTD_NAND_OMAP2.
> IMHO the elm.c file must be moved from mtd/devices to mtd/nand and renamed to omap_elm.c
> 
> drivers/built-in.o: In function `omap_nand_probe':
> /work/linux-2.6/drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
> drivers/built-in.o: In function `omap_elm_correct_data':
> /work/linux-2.6/drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'
> make: *** [vmlinux] Error 1
> ""
> 
> [1] https://lkml.org/lkml/2013/5/4/84
> 
> Ezequiel Garcia (3):
>   mtd: nand: Move ELM driver and rename as omap_elm
>   mtd: nand: Rename OMAP NAND driver
>   mtd: nand: Force omap_elm to be built as a module if omap2_nand is a
>     module

Thanks for the patches. I see a lot of errors reported by checkpatch.pl which need fixing.

cheers,
-roger

> 
>  drivers/mtd/devices/Makefile                   | 1 -
>  drivers/mtd/nand/Kconfig                       | 8 +++++++-
>  drivers/mtd/nand/Makefile                      | 3 ++-
>  drivers/mtd/nand/{omap2.c => omap2_nand.c}     | 0
>  drivers/mtd/{devices/elm.c => nand/omap_elm.c} | 0
>  5 files changed, 9 insertions(+), 3 deletions(-)
>  rename drivers/mtd/nand/{omap2.c => omap2_nand.c} (100%)
>  rename drivers/mtd/{devices/elm.c => nand/omap_elm.c} (100%)
> 

