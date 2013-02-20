From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/8] ARM; OMAP2+: hwmod and SERIAL: Remove sysc
	handling from driver
Date: Wed, 20 Feb 2013 10:14:01 +0000
Message-ID: <20130220101401.GW17852@n2100.arm.linux.org.uk>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46872 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914Ab3BTKOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 05:14:12 -0500
Content-Disposition: inline
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, Feb 20, 2013 at 03:27:44PM +0530, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.

Up until now, the nightly test builds have included a load of test code
for supporting DMA on OMAP serial - only the buggy transmit side which
we've covered the reasons earlier why this can't work properly.

We've also covered why the ripping out of the DMA code from the serial
driver, and then subsequent "cleanup" of the driver has resulted in it
being impossible to resurect receive DMA support without reverting all
those cleanups.

This patch set is yet again another nail in the coffin of any DMA support
in the serial driver; it is removing the final bits of knowledge about
how DMA support interacts with the idle support.  Arguably, the previous
cleanups already did that, but at least the hooks were still clearly
visible as separate stand-alone entities and how only they were affected
by DMA being enabled.

Therefore, tonight I am dropping and discarding what I have left over
from my work on getting DMA support working with the OMAP serial driver
again from the nightly test builds and my git tree, and I intend no
further involvement with this.
