From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 0/5] nand: OMAP collected fixes
Date: Mon, 22 Sep 2014 11:22:07 +0300
Message-ID: <541FDC2F.4020103@ti.com>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49763 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbaIVIWf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2014 04:22:35 -0400
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Ezequiel,

On 09/20/2014 07:53 PM, Ezequiel Garcia wrote:
> I've collected all the changes recently discussed in a whole patchset.
> If you are just reading this for the first time please take a look at:
> 
> [1] http://www.spinics.net/lists/linux-omap/msg110965.html
> [2] http://www.spinics.net/lists/linux-omap/msg110958.html 
> 
> As requested by Roger, the omap_elm is a 'bool' driver now. The plan
> is to merge it inside omap2_nand, but my queue is really filled, so
> if anyone feels like doing, please be my guest.
> 
> Although I'm hoping this to be the last round, feedback and testing
> is welcome.

Patches 3 and 4 still have checkpatch issues.

cheers,
-roger

> 
> Brian: I wonder if it's too late for v3.18?
> 
> Thanks!
> 
> Ezequiel Garcia (5):
>   nand: omap2: Remove horrible ifdefs to fix module probe
>   nand: omap2: Replace pr_err with dev_err
>   mtd: nand: Move ELM driver and rename as omap_elm
>   mtd: nand: Rename OMAP NAND driver
>   mtd: nand: Constrain omap_elm to built-in
> 
>  drivers/mtd/devices/Makefile                   |   1 -
>  drivers/mtd/nand/Kconfig                       |   2 +-
>  drivers/mtd/nand/Makefile                      |   3 +-
>  drivers/mtd/nand/{omap2.c => omap2_nand.c}     | 160 ++++++++++++++-----------
>  drivers/mtd/{devices/elm.c => nand/omap_elm.c} |   0
>  include/linux/platform_data/elm.h              |  16 +++
>  6 files changed, 107 insertions(+), 75 deletions(-)
>  rename drivers/mtd/nand/{omap2.c => omap2_nand.c} (95%)
>  rename drivers/mtd/{devices/elm.c => nand/omap_elm.c} (100%)
> 

