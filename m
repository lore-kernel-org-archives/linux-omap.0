From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Wed, 13 Jul 2011 02:14:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107130207130.30229@utopia.booyaka.com>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com> <20110712060755.GA18622@localhost.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59540 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961Ab1GMIO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 04:14:58 -0400
In-Reply-To: <20110712060755.GA18622@localhost.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: jean.pihet@newoldbits.com, khilman@ti.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Tue, 12 Jul 2011, Pavel Machek wrote:

> On Wed 2011-06-29 18:40:23, jean.pihet@newoldbits.com wrote:
> > From: Jean Pihet <j-pihet@ti.com>
> > 
> > Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
> > is copied to internal SRAM at boot and after wake-up from CORE OFF mode.
> > However only a small part of the code really needs to run from internal SRAM.
> > 
> > This fix lets most of the ASM idle code run from the DDR
> > in order to minimize the SRAM usage and the overhead in the code copy.
> 
> So... what do you plan to use sram for? Because I don't think the
> speedup is worth the complexity...

The SDRAM may not be accessible yet when the chip isn't waking up from 
off-mode, so SRAM is the only option.  The comments & code in the patch 
surrounding the "wait_sdrc_ok" label refer to this issue - albeit, perhaps 
telegraphically.


- Paul
