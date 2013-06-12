From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/3] arm: gpmc: Low power transition support
Date: Wed, 12 Jun 2013 10:38:54 -0700
Message-ID: <20130612173854.GP8164@atomide.com>
References: <1371034858-19984-1-git-send-email-pekon@ti.com>
 <1371034858-19984-3-git-send-email-pekon@ti.com>
 <20130612170126.GI8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51233 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751991Ab3FLRi7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 13:38:59 -0400
Content-Disposition: inline
In-Reply-To: <20130612170126.GI8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, avinash philip <avinashphilip@ti.com>

* Tony Lindgren <tony@atomide.com> [130612 10:08]:
> * Pekon Gupta <pekon@ti.com> [130612 04:07]:
> > From: avinash philip <avinashphilip@ti.com>
> > 
> > With GPMC converted to platform driver recently, adds low power
> > transition support in driver itself.
> 
> Applying the first two patches of this series into omap-for-v3.11/gpmc.
> Not taking the MTD patch, if it has dependencies to the first two
> patches please let me know and also get an ack from Artem if you
> want me to take it.

Oops, dropping the second patch in this series as it causes the
following if only omap4 is selected for example:

arch/arm/mach-omap2/built-in.o: In function `gpmc_resume':
dss-common.c:(.text+0x9a8): undefined reference to `omap3_gpmc_restore_context'
arch/arm/mach-omap2/built-in.o: In function `gpmc_suspend':
dss-common.c:(.text+0x9c8): undefined reference to `omap3_gpmc_save_context'

Can you please take a lok and fix that?

Regards,

Tony
