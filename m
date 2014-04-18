From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] add parallel NAND support for TI's new OMAPx and
 AMxx platforms
Date: Fri, 18 Apr 2014 09:33:16 -0700
Message-ID: <20140418163316.GD5354@atomide.com>
References: <1394617547-25240-1-git-send-email-pekon@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5FA6@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11203 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDRQdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 12:33:20 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAB5FA6@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>

* Gupta, Pekon <pekon@ti.com> [140327 00:22]:
> HI Tony,
> 
> >From: Gupta, Pekon
> [...]
> >I see following patches in your tree/branch  "omap-for-v3.15/dt"
> >But probably they were omitted in the pull request. Is there something, I need to do for these ?
> >
> >	f68e355  2014-03-02  ARM: dts: am43xx: add support for parallel NAND flash
> >	c06c527  2014-03-02  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
> >	91994fa  2014-03-02  ARM: dts: am335x-evm: NAND: update MTD partition table
> >	0611c41  2014-03-02  ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms and ECC schemes
> >
> >
> >Also, I had sent a [v2] for one of the patches, dropped by you. Please see if that can be picked
> >	[Patch v2 1/2] ARM: dts: dra7: add support for parallel NAND flash
> >	[Patch v2 1/2] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
> >
> >
> Please let me know, if I need to rebase any of the patches in follow series
> against your for_3.15/dt  or any other branch.

Yes please rebase against v3.15-rc1 and repost, otherwise I'll have hard
time keeping track of what's still missing.

BTW, I think we have few more GPMC issue to debug before we can drop omap3
legacy booting support:

1. At least the gpmc_probe_generic_child fails if the device is initialized
   by the bootloader, and then initialized by the kernel based on the .dts
   entries. This works just fine when booted in legacy mode.

2. Also gpmc_cs_remap hangs the system if the bootloader address for the
   device was different from the address in the .dts file.

3. The gpmc_cs_remap should use the ranges property instead of the child
   reg property. The child reg property should be the offset from the
   GPMC ranges property as at least smc91x wants 0x300 as the offset to
   avoid extra warnings from the driver when it checks the address space.

Regards,

Tony

 
> (1) [Partly Merged] "add parallel NAND support for TI's new OMAPx and AMxx platforms"
> http://www.spinics.net/lists/linux-omap/msg104305.html
> 
> (2) [New Patches] "add parallel NAND support for TI's new OMAPx and AMxx platforms (part-2)"
> http://www.spinics.net/lists/linux-omap/msg104668.html

