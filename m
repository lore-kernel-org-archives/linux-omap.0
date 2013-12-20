From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
Date: Fri, 20 Dec 2013 10:37:05 -0800
Message-ID: <20131220183703.GA26054@atomide.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58346 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3LTSh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 13:37:56 -0500
Content-Disposition: inline
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131220 08:36]:
> Hi,
> 
> Hopefully final post of this series. At least this is going to be the last
> post this year as I will be going to x-mas vacation and won't be back before
> Jan 2nd. This time I just sent the patches that have changes in them,
> the missing ones are exactly the same as in v11.
> 
> Changes done:
>  - most of the patches:
>    * Some cosmetic documentation fixes
>  - patch 06:
>    * Changed register pointer types from 'u32 __iomem *' to 'void __iomem *'
>  - patch 07,08,09:
>    * Added check for clk->ll_ops being NULL (happens with statically built
>      clock data), fixes the boot time crash issue noticed by Tony
>  - patch 11:
>    * Moved __clk_of_table extern declaration to clk-provider.h header file...
>      Got flamed about this enough times now. :)
>    * Type for the declaration changed also from array to single entry,
>      and address for this used in code. This prevents compile time error:
>      "array type has incomplete element type". Can't use pointer here either
>      as this messes the address of the table.
>    * ti_clk_retry_init() now has int return type, and checks for kzalloc
>      failure
>  - patch 12, 14, 23:
>    * Added cleanup in case ti_clk_retry_init() fails
>  - patch 17:
>    * Fixed potential memory leak in failed init detected by sparse
>  - patch 18:
>    * Modified commit message to add some details about clockdomains
>  - patch 43:
>    * Changed register pointer types from 'u32 *' to 'void __iomem *'
> 
> Testing done:
> - omap3-beagle: boot, suspend/resume (ret), suspend/resume (off)
> - omap4-panda-es: boot, suspend/resume (ret)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot
> 
> Branches available at https://github.com/t-kristo/linux-pm.git:
> - branch: 3.13-rc4-dt-clks-v12 : contains everything, shall me merged last
> - branch: 3.13-rc4-dt-clks-v12-for-mike : drivers/clk changes
> - branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only (from v11, no changes)

Boots now for me on omap2/3/4, and off-idle works on omap3. So as far as
I'm concerned, please feel free to add my ack to the new and updated patches
still missing it:

Acked-by: Tony Lindgren <tony@atomide.com>
