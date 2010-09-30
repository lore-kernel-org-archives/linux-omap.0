From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 29 Sep 2010 19:29:37 -0700
Message-ID: <20100930022937.GF3117@atomide.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com>
 <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50773 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0I3C3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 22:29:41 -0400
Content-Disposition: inline
In-Reply-To: <20100930021819.GD3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha Varadarajan <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj R." <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

* Tony Lindgren <tony@atomide.com> [100929 19:10]:
> 
> Then trying to build for omap1 OSK fails with:
> 
> In file included from arch/arm/plat-omap/common.c:35:
> arch/arm/plat-omap/include/plat/control.h:20:40: error: mach/ctrl_module_core_44xx.h: No such file or directory
> arch/arm/plat-omap/include/plat/control.h:21:40: error: mach/ctrl_module_wkup_44xx.h: No such file or directory
> arch/arm/plat-omap/include/plat/control.h:22:44: error: mach/ctrl_module_pad_core_44xx.h: No such file or directory
> arch/arm/plat-omap/include/plat/control.h:23:44: error: mach/ctrl_module_pad_wkup_44xx.h: No such file or directory

This seems to be related to Santosh' commit 802edcb7.

Santosh, can you do a patch to fix this against the current
omap-for-linus branch?

Regards,

Tony
