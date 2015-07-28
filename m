From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
Date: Tue, 28 Jul 2015 13:55:52 +0100
Message-ID: <20150728125552.GH7576@n2100.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
 <55B6A161.8010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55B6A161.8010307@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 27, 2015 at 04:23:45PM -0500, Dan Murphy wrote:
> Russell
> 
> On 07/15/2015 12:47 PM, Russell King wrote:
> > +#ifdef CONFIG_OMAP_INTERCONNECT_BARRIER
> > +
> >  /* Used to implement memory barrier on DRAM path */
> >  #define OMAP4_DRAM_BARRIER_VA			0xfe600000
> >  
> > -void __iomem *dram_sync, *sram_sync;
> > +static void __iomem *dram_sync, *sram_sync;
> > +static phys_addr_t dram_sync_paddr;
> > +static u32 dram_sync_size;
> > +
> > +/*
> > + * The OMAP4 bus structure contains asynchrnous bridges which can buffer
> > + * data writes from the MPU. These asynchronous bridges can be found on
> > + * paths between the MPU to EMIF, and the MPU to L3 interconnects.
> > + *
> > + * We need to be careful about re-ordering which can happen as a result
> > + * of different accesses being performed via different paths, and
> > + * therefore different asynchronous bridges.
> > + */
> >  
> > -static phys_addr_t paddr;
> > -static u32 size;
> > +/*
> > + * OMAP4 interconnect barrier which is called for each mb() and wmb().
> > + * This is to ensure that normal paths to DRAM (normal memory, cacheable
> > + * accesses) are properly synchronised with writes to DMA coherent memory
> > + * (normal memory, uncacheable) and device writes.
> > + *
> > + * The mb() and wmb() barriers only operate only on the MPU->MA->EMIF
> > + * path, as we need to ensure that data is visible to other system
> > + * masters prior to writes to those system masters being seen.
> > + *
> > + * Note: the SRAM path is not synchronised via mb() and wmb().
> > + */
> > +static void omap4_mb(void)
> 
> Sorry for the late response but this throws a warning when CONFIG_ARCH_OMAP4
> is not configured.
> 
> arch/arm/mach-omap2/omap4-common.c:85:13: warning: 'omap4_mb' defined but not used [-Wunused-function]

Sorry, I'm going to have to disagree with you and your compiler on this.
This is how the code is structured:

#ifdef CONFIG_OMAP_INTERCONNECT_BARRIER
...
static void omap4_mb(void)
{
        if (dram_sync)
                writel_relaxed(0, dram_sync);
}
...
void __init omap_barriers_init(void)
{
...
        soc_mb = omap4_mb;
}

#endif

So, the definition of omap4_mb(), and the use of the same are both
under the same ifdef.  You can't build omap4_mb() without also building
omap_barriers_init() as well.

So, there's no way that omap4_mb() would be "defined but not used".

I think you have some changes in your kernel which, maybe, place an
ifdef around omap_barriers_init() which _would_ cause the warning you're
seeing if they aren't set.

Also, please trim context before the relevant part to which you're
replying. I almost gave up paging down to see whether there was actually
anything worth replying to.  If there's nothing in the first 50 lines of
the message, it's a waste of space.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
