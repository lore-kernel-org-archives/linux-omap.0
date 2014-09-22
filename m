From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 0/5] nand: OMAP collected fixes
Date: Mon, 22 Sep 2014 11:42:28 -0700
Message-ID: <20140922184228.GR1193@ld-irv-0074>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:55067 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbaIVSmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 14:42:32 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so4942066pdj.4
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 11:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 20, 2014 at 05:53:11PM +0100, Ezequiel Garcia wrote:
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
> 
> Brian: I wonder if it's too late for v3.18?
> 
> Thanks!
> 
> Ezequiel Garcia (5):
>   nand: omap2: Remove horrible ifdefs to fix module probe
>   nand: omap2: Replace pr_err with dev_err
>   mtd: nand: Move ELM driver and rename as omap_elm

Pushed the first 3 to l2-mtd.git. Thanks!

>   mtd: nand: Rename OMAP NAND driver

One comment on this one, which I'll poast on its patch.

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

Brian
