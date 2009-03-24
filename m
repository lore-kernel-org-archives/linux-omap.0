From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Beagle can't mount rootfs from MMC after regulator updates
Date: Tue, 24 Mar 2009 17:16:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903241715280.9924@utopia.booyaka.com>
References: <alpine.DEB.2.00.0903241651080.9924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47709 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbZCXXQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 19:16:04 -0400
In-Reply-To: <alpine.DEB.2.00.0903241651080.9924@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net

Hi,

On Tue, 24 Mar 2009, Paul Walmsley wrote:

> The BeagleBoard rev B4 here can't mount its root filesystem from MMC after 
> 3fe326511c66ab842ef0a09a1f4c564b1a8beecf, "mmc-twl4030 uses regulator 
> framework".  This is with omap3_beagle_defconfig and rootwait in the 
> kernel command line.  Kernel hangs after:
> 
> Waiting for root device /dev/mmcblk0p2...

Turns out this is due to missing CONFIG_REGULATOR, 
CONFIG_REGULATOR_TWL4030 in the defconfigs; patch coming shortly.

- Paul
