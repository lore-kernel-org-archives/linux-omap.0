From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Fri, 10 Nov 2017 07:24:23 -0800
Message-ID: <20171110152423.GM28152@atomide.com>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091529.x3pqqvbiywj5aulo@lenoch>
 <3d33265a-2520-2298-6068-f76a7257bfd0@ti.com>
 <20171110100443.zqk7uzxoaq4eyntk@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171110100443.zqk7uzxoaq4eyntk@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171110 10:06]:
> On Fri, Nov 10, 2017 at 10:25:24AM +0200, Peter Ujfalusi wrote:
> > Hi,
> > 
> > On 2017-11-09 11:15, Ladislav Michl wrote:
> > > Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 / OMAP3
> > > OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only into
> > > OMAP3 specific DMA functions which turned out not to be so OMAP3 specific.
> > > Therefore replace open coded timeout waiting for completion in OMAP3
> > > functions with API call and merge those two implementations.
> > > 
> > > Note that currently the is no single DMA user, so this change is basically
> > > no-op. Those interested will have to find DMA configuration in the
> > > linux-omap.git history.
> > 
> > fwiw I have two patches for some time to convert the omap2 onenand
> > driver to DMAengine:
> > https://github.com/omap-audio/linux-audio/commits/peter/linux-next-wip/drivers/mtd/onenand/omap2.c
> 
> That is incredible! I was thinking about it as a next step and you already
> did all the work.
> 
> > I can wait for your series and rebase mine or if you have time can test
> > them and see if they can be included in your update series.

Yeah that's great, one step closer to removing the legacy dma support!

> I run out of time few days ago already, but this looks so good that it is
> worth to delay other work. I'll include it in next version of patch serie.
> 
> Also it will allow us to dump 'dma-channel' and use DMA if gpio pin
> is configured which was intended logic of original driver. 'dma-channel'
> was introduced during mechanical conversion to DT and fortunately it is
> not used yet, so we can safely remove it again.

FYI, the gpio pin for onenand should not be in gpio mode. It should
be used as external dma request line to automatically trigger new
transfers like we do for tusb6010 dma. But of course it's possible
that onenand has other issues too preventing the dma usage.

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
