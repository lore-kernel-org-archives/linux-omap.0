From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v10 00/10] mtd:nand:omap2: clean-up of supported ECC
 schemes
Date: Tue, 22 Oct 2013 13:30:09 -0700
Message-ID: <20131022203009.GM23337@ld-irv-0074.broadcom.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34973 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3JVUaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 16:30:14 -0400
Content-Disposition: inline
In-Reply-To: <1382172254-12448-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com

On Sat, Oct 19, 2013 at 02:14:04PM +0530, Pekon Gupta wrote:
> 
> *changes v9 -> v10*
> [PATCH 1/10], [PATCH 2/10]
>   swapped [PATCH v9 1/9] and [PATCH v9 2/9] so that DT parsing updates
>   (with backward compatibility) happen before the deprecation of DT values.
>   This way DTB does not break functionally between the patches.
> [PATCH 3/10] <no update>
> [PATCH 4/10] 
>   dropped [PATCH v9 4/9] introducing NAND_BUSWIDTH_AUTO, instead
>   using DT 'nand-bus-width' for device bus-width

As mentioned in reply to the patch, I don't think this patch belongs in
this series now, and it is still not adequate (the original code there
is wrong in some ways, but your changes are not clearly better).

> [PATCH 5/10] <no update>
> [PATCH 6/10] <no update>
> [PATCH 7/10] 
>   separated out drivers/mtd/nand/Kconfig updates into separate [PATCH v10 10/10]
>   cleanup: s/info->nand\./nand_chip->
> [PATCH 8/10] <no update>
> [PATCH 9/10] cleanup: s/out_release_mem_region/return_error
> [PATCH 10/10] <new> spawned from [PATCH v9 8/9] for Kconfig updates

Otherwise, the series looks good.

Thanks,
Brian
