From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Date: Fri, 3 Jan 2020 10:17:26 +0200
Message-ID: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

When booting v5.4 (or v5.5-rc4) on N900, the console gets flooded with:

[    8.335754] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.365753] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.395751] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.425750] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.455749] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.485748] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.515777] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.545776] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.575775] omap2-onenand 1000000.onenand: timeout waiting for DMA

making the system unusable.

Bisected to:

4689d35c765c696bdf0535486a990038b242a26b is the first bad commit
commit 4689d35c765c696bdf0535486a990038b242a26b
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue Jul 16 11:24:59 2019 +0300

    dmaengine: ti: omap-dma: Improved memcpy polling support

The commit does not revert cleanly anymore. Any ideas how to fix this?

A.
