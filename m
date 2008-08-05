From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3 v2] OMAP3 Beagle: Enable nand support
Date: Tue, 5 Aug 2008 12:09:22 +0300
Message-ID: <20080805090921.GH7193@atomide.com>
References: <48972701.2080006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54704 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736AbYHEJJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:09:26 -0400
Content-Disposition: inline
In-Reply-To: <48972701.2080006@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>

* Dirk Behme <dirk.behme@googlemail.com> [080804 19:01]:
> This series of patches adds NAND support to the BeagleBoard.
>
> The first patch in the series builds on work by Teerth Reddy  
> <teerth@ti.com> and Steve Sakoman <sakoman@gmail.com> to extend the  
> omap2 nand driver to work with both omap2 and omap3 architectures (as  
> well as adding/clarifying comments).
>
> The second patch adds the beagle nand support, and the final patch  
> enables the nand driver and jffs2 support in the beagle defconfig.
>
> The patch set was reviewed by Khasim Syed Mohammed <khasim@ti.com> prior 
> to this submission.  It was tested on Rev A and B BeagleBoards.
>
> This v2 replaces http://marc.info/?l=linux-omap&m=121230229625544&w=2
>
> Changes in v2:
>
> - Apply cleanly to recent git (defconfig, drivers/mtd/nand/omap2.c)
> - Beagle has only NAND. This results in small config. Move configuration 
> to board-omap3beagle.c and don't create a new file  
> board-omap3beagle-flash.c for it.

Pushing this series today.

Tony

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
