From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Remaining kautobuild errors with mainline
Date: Tue, 9 Sep 2008 08:59:29 +0100
Message-ID: <20080909075929.GC9104@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbYIIH7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 03:59:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

As of last nights merge of the ARM tree, the only remaining build error
is:

arch/arm/mach-omap1/built-in.o: In function `sx1_mmc_init':
board-sx1-mmc.c:(.init.text+0xd64): undefined reference to `omap_set_mmc_info'
arch/arm/mach-omap1/built-in.o: In function `h2_mmc_init':
arch/arm/mach-omap1/board-h2-mmc.c:98: undefined reference to `omap_set_mmc_info'

This seems to be because of arch/arm/plat-omap/devices.c not being up to
date; it seems to pass a struct omap_mmc_conf to the OMAP MMC driver,
but the MMC driver expects a struct omap_mmc_platform_data instead.

Can I lift just the MMC changes for arch/arm/plat-omap/devices.c from
the OMAP tree to fix this, or is there something more required for this?
