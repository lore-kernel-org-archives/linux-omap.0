From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Fri, 10 Nov 2017 19:26:21 +0100
Message-ID: <20171110182621.ntiptm3h2u437nv7@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091529.x3pqqvbiywj5aulo@lenoch>
 <3d33265a-2520-2298-6068-f76a7257bfd0@ti.com>
 <20171110100443.zqk7uzxoaq4eyntk@lenoch>
 <20171110152423.GM28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171110152423.GM28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 10, 2017 at 07:24:23AM -0800, Tony Lindgren wrote:
> FYI, the gpio pin for onenand should not be in gpio mode. It should
> be used as external dma request line to automatically trigger new
> transfers like we do for tusb6010 dma. But of course it's possible
> that onenand has other issues too preventing the dma usage.

Hmm, that's probably what comment in omap3-n900.dts is saying:
"sys_ndmareq1 could be used by the driver, not as gpio65 though"
However board-rx51 (is that n900?) is using it as gpio pin.
Also omap2420-n8x0-common.dtsi comment says: "gpio-irq for dma: 26"
and it matches board-n8x0.c platform data configuration.
But I still missing pinmux configuration as we need to add it into
DT as well. I guess this was originally done in bootloader. Any hint
where can I get this info from?

Thanks,
	ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
