From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 3/3] mtd: nand: Force omap_elm to be built as a module if
 omap2_nand is a module
Date: Wed, 17 Sep 2014 20:00:49 -0700
Message-ID: <20140918030049.GB8127@brian-ubuntu>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410443224-18477-4-git-send-email-ezequiel@vanguardiasur.com.ar>
 <5412B66F.8050505@ti.com>
 <20140912165636.GA7276@arch>
 <5416A2FF.3050503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55140 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbaIRDAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 23:00:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so415949pdj.37
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 20:00:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5416A2FF.3050503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, pekon <pekon@pek-sem.com>

On Mon, Sep 15, 2014 at 11:27:43AM +0300, Roger Quadros wrote:
> On 09/12/2014 07:56 PM, Ezequiel Garcia wrote:
> > On 12 Sep 12:01 PM, Roger Quadros wrote:
> >> On 09/11/2014 04:47 PM, Ezequiel Garcia wrote:
> >>> This commit adds a hidden option to build the omap_elm as a module, if
> >>> omap2_nand is a module (and similarly in the built-in case).
> >>>
> >>> This fixes the following build error when omap2_nand is chosen built-in,
> >>> and omap_elm is chosen as a module:
> >>>
> >>> drivers/built-in.o: In function `omap_nand_probe':
> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
> >>> drivers/built-in.o: In function `omap_elm_correct_data':
> >>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'
> >>>
> >>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >>> ---
> >>>  drivers/mtd/nand/Kconfig  | 8 +++++++-
> >>>  drivers/mtd/nand/Makefile | 2 +-
> >>>  2 files changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> >>> index f1cf503..12e8ee8 100644
> >>> --- a/drivers/mtd/nand/Kconfig
> >>> +++ b/drivers/mtd/nand/Kconfig
> >>> @@ -96,7 +96,7 @@ config MTD_NAND_OMAP2
> >>>  
> >>>  config MTD_NAND_OMAP_BCH
> >>>  	depends on MTD_NAND_OMAP2
> >>> -	tristate "Support hardware based BCH error correction"
> >>> +	bool "Support hardware based BCH error correction"
> >>>  	default n
> >>>  	select BCH
> >>>  	help
> >>> @@ -106,6 +106,12 @@ config MTD_NAND_OMAP_BCH
> >>>  	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
> >>>  	  so they should not enable this config symbol.
> >>>  
> >>> +config MTD_NAND_OMAP_BCH_BUILD
> >>> +	tristate
> >>> +	depends on MTD_NAND_OMAP2
> >>> +	default m if MTD_NAND_OMAP2=m && MTD_NAND_OMAP_BCH
> >>> +	default y if MTD_NAND_OMAP2=y && MTD_NAND_OMAP_BCH

I think the last 2 lines could be combined:

	default MTD_NAND_OMAP2 if MTD_NAND_OMAP_BCH

> >>> +
> >>>  config MTD_NAND_IDS
> >>>  	tristate
> >>>  
> >>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> >>> index 4bcdeb0..3580188 100644
> >>> --- a/drivers/mtd/nand/Makefile
> >>> +++ b/drivers/mtd/nand/Makefile
> >>> @@ -27,7 +27,7 @@ obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
> >>>  obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
> >>>  obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
> >>>  obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
> >>> -obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
> >>> +obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
> >>>  obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
> >>>  obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
> >>>  obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o

Apparently I came up with a nearly identical solution, so it must be
good! ;)

> >> The overall logic seems to work but I still see the following issue.
> >>
> >> In menuconfig, the OMAP_BCH option is still visible as a boolean even though
> >> the ELM module finally gets built as a module.
> >> This can be confusing to the user and I'd avoid that behaviour.
> >>
> > 
> > Yes, I know. But it's either this solution or no solution at all, I think.
> > 
> > Let me give some further context about this patch, so we can have more
> > information to decide.
> > 
> > First of all (and IMO) the user doesn't have to know about the ELM being
> > a module or not, because modprobe will load it (since omap2_nand depends
> > on omap_elm's symbols).
> > 
> > So, the new way seems a bit more intuitive for me. The user choses if he
> > wants to have hardware BCH support, and such support gets built the right
> > way.
> > 
> > If we still consider this highly confusing, and we want to avoid it,
> > then it seems we can only make omap_elm a boolean, which means it'll always
> > be built-in. I crafted this patch in an effort to avoid making it boolean.
> > 
> > Finally, the solution is taken from media/usb/stk1160. For good or for bad,
> > we have a precedent in doing things this way.
> > 
> > Ultimately, I don't care much as I don't think anyone will build it as a module,
> > except maybe for testing the driver under probe/remove cycles.
> > 
> OK. I personally prefer boolean than the Kconfig magic as it makes my life a bit
> easier and less confusing to the user i.e. wysiwyg ;).
> 
> Let's see what the MTD maintainers prefer.
> Brian and David, any insights on this problem?

It seems like 'elm' serves more as an accessory piece of omap2.{o,ko},
not really a separate module, so it's possible it'd make your life even
easier to just link elm.o into omap2.o. There's no requirement that two
source files create two separate kernel modules. I think this would
present the simplest possible interface to the user.

Thoughts?

Brian
