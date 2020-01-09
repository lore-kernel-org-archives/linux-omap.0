From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] mtd: onenand: omap2: Pass correct flags for
 prep_dma_memcpy
Date: Thu,  9 Jan 2020 20:14:44 +0100
Message-ID: <20200109191444.10713-1-miquel.raynal@bootlin.com>
References: <20200107084544.18547-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200107084544.18547-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, kyungmin.park@samsung.com, miquel.raynal@bootlin.com, aaro.koskinen@iki.fi, vigneshr@ti.com, hns@goldelico.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2020-01-07 at 08:45:44 UTC, Peter Ujfalusi wrote:
> The commit converting the driver to DMAengine was missing the flags for
> the memcpy prepare call.
> It went unnoticed since the omap-dma driver was ignoring them.
> 
> Fixes: 3ed6a4d1de2c5 (" mtd: onenand: omap2: Convert to use dmaengine for memcp")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
