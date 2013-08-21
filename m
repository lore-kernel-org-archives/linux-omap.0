From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v5 0/4] mtd:nand:omap2: clean-up of supported ECC
 schemes
Date: Tue, 20 Aug 2013 18:32:55 -0700
Message-ID: <20130821013255.GD28382@ld-irv-0074.broadcom.com>
References: <1373748891-7779-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42190 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab3HUBc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 21:32:59 -0400
Content-Disposition: inline
In-Reply-To: <1373748891-7779-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: dedekind1@gmail.com, dwmw2@infradead.org, arnd@arndb.de, olof@lixom.net, mugunthanvnm@ti.com, tony@atomide.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi Pekon,

I don't think I will take this series (at least not yet), because of the
device-tree ABI breakage.

On Sun, Jul 14, 2013 at 02:24:47AM +0530, Pekon Gupta wrote:
> 
> Changes v4 -> v5
> - Rebased to linux-next 
> IMPORTANT: Need to revert commit fb1585b, [PATCH 2/4] part of previous version
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html
> 
> - Swapped PATCH-1 & PATCH-2 to maintain bisectibility & compilation dependency
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047461.html
> 
> - PATCH-2: re-ordered call to is_elm_present() for later updates ELM driver
> 	- dropped changes in include/linux/platform_data/elm.h (not needed)
> - PATCH-3: re-ordered call to is_elm_present() for later updates ELM driver
> - Re-formated patch description (replaced tabs with white-spaces)
> 
> 
> Changes v3 -> v4
> (Resent with CC: devicetree-discuss@lists.ozlabs.org)

Make sure to use devicetree@vger.kernel.org for future series.

> - [Patch 1/3] removed MTD_NAND_OMAP_BCH8 & MTD_NAND_OMAP_BCH4 from nand/Kconfig
> 	ECC scheme selectable via nand DT (nand-ecc-opt).
> - [*] rebased for l2-mtd.git
> 
> 
> Changes v2 -> v3
> (Resent with Author Name fixed)
> - PATCH-1: re-arranged code to remove redundancy, added NAND_BUSWIDTH_AUTO
> - PATCH-2: updated nand-ecc-opt DT mapping and Documentation
> - PATCH-3: code-cleaning + changes to match PATCH-1
> - PATCH-4 <DROPPED> update DT attribute for ti,nand-ecc-opt 
> 	- received feedback to keep DT mapping independent of linuxism
> - PATCH-4:<NEW> : ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
> 	- independent patch for AM335x-evm.dts update based on PATCH-2
> 
> 
> Changes v1 -> v2
> 	added 	[PATCH 3/4] and [PATCH 4/4]

[...]

You might also consider a future patch for utilizing devm_* functions
for the probe/remove routines in drivers/mtd/nand/omap2.c. That could
improve some of the stuff I looked at in this series.

Brian
