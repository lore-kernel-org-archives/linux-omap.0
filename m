From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Fri, 10 Nov 2017 07:26:10 -0800
Message-ID: <20171110152610.GN28152@atomide.com>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091529.x3pqqvbiywj5aulo@lenoch>
 <4a58dfac-8cc9-101f-b079-da8925d7ab4c@ti.com>
 <20171110095154.kf34cd7h2eyfvwf3@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171110095154.kf34cd7h2eyfvwf3@lenoch>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171110 09:53]:
> On Fri, Nov 10, 2017 at 10:21:51AM +0200, Roger Quadros wrote:
> > On 09/11/17 11:15, Ladislav Michl wrote:
> > > Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 / OMAP3
> > > OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only into
> > > OMAP3 specific DMA functions which turned out not to be so OMAP3 specific.
> > > Therefore replace open coded timeout waiting for completion in OMAP3
> > > functions with API call and merge those two implementations.
> > > 
> > > Note that currently the is no single DMA user, so this change is basically
> > > no-op. Those interested will have to find DMA configuration in the
> > > linux-omap.git history.
> > > 
> > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > 
> > I'll be happy if there are no OMAP2 vs OMAP3 differences in code but we need to
> > be absolutely sure that we don't break DMA functionality if it ever worked.
> 
> It probably worked at least for OMAP3 as it was enabled in legacy kernels.
> 
> > Can we somehow test OneNAND DMA on OMAP2 and OMAP3?
> > Tony?
> 
> I'll prepare next version patch serie for easier testing. Of course I would
> prefer to be able to test changes myself, but I do not have any Nokias :-)

I tested Peter's dma changes yesterday and they worked. Yeah if you want
me to test something a complete series or a git branch makes it easier
for me to follow what all is needed.

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
