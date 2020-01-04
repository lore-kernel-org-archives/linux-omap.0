From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] mtd: onenand: omap2: Pass correct flags for
 prep_dma_memcpy
Date: Sat, 4 Jan 2020 22:29:01 +0200
Message-ID: <20200104202901.GI15023@darkstar.musicnaut.iki.fi>
References: <20200104073453.16077-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200104073453.16077-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kyungmin.park@samsung.com, miquel.raynal@bootlin.com, vigneshr@ti.com, hns@goldelico.com, tony@atomide.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Jan 04, 2020 at 09:34:53AM +0200, Peter Ujfalusi wrote:
> The commit converting the driver to DMAengine was missing the flags for
> the memcpy prepare call.
> It went unnoticed since the omap-dma drive was ignoring them.
> 
> Fixes: 3ed6a4d1de2c5 (" mtd: onenand: omap2: Convert to use dmaengine for memcp")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Aaro reported [1] a failure on omap2-onenand pointing to
> 4689d35c765c696bdf0535486a990038b242a26b. It looks like the root cause is the
> conversion of omap2-onenand to DMAengine which missed the flags.
> 
> Basically the client is waiting for a callback without asking for it. This
> certainly causes timeout.
> 
> I have not tested the patch, but it should fix the issue.

This fixes the issue on Nokia boards.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
