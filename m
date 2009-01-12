From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: mmci-omap regressions
Date: Mon, 12 Jan 2009 12:35:07 +0100
Message-ID: <20090112113507.GA21366@michl.2n.cz>
References: <20090112091721.GA11921@michl.2n.cz> <20090112104242.GA9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ex.2n.cz ([213.29.92.11]:30148 "EHLO ex.2n.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbZALLgg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 06:36:36 -0500
Content-Disposition: inline
In-Reply-To: <20090112104242.GA9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jan 12, 2009 at 12:42:43PM +0200, Tony Lindgren wrote:
> Looks like the current git head does goto exit after MMC_POWER_UP before
> you even get to that code.

...and 2.6.22-omap1 version does return at the same place. So patch can be
also shown as
--- a/drivers/mmc/host/omap.c	2009-01-12 09:32:23.000000000 +0100
+++ b/drivers/mmc/host/omap.c	2009-01-12 12:31:52.000000000 +0100
@@ -974,14 +974,6 @@
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
-	if (ios->power_mode == MMC_POWER_ON) {
-		/* Send clock cycles, poll completion */
-		OMAP_MMC_WRITE(host, IE, 0);
-		OMAP_MMC_WRITE(host, STAT, 0xffff);
-		OMAP_MMC_WRITE(host, CMD, 1 << 7);
-		while ((OMAP_MMC_READ(host, STAT) & 1) == 0);
-		OMAP_MMC_WRITE(host, STAT, 1);
-	}
 	clk_disable(host->fclk);
 }

Sorry for not thinking a bit harder first time. I'll try to figure out how
to make git version working.

	ladis
