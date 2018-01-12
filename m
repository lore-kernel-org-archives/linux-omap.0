From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 00/14] OMAP2+ OneNAND driver update
Date: Fri, 12 Jan 2018 06:20:50 -0800
Message-ID: <20180112142050.GC4821@atomide.com>
References: <20180112131105.GA13810@lenoch>
 <20180112150315.54214fab@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180112150315.54214fab@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Boris Brezillon <boris.brezillon@free-electrons.com> [180112 14:03]:
> On Fri, 12 Jan 2018 14:11:05 +0100
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > this patch serie updates OMAP2+ OneNAND driver to the present times, making
> > it fully DT configurable, using libgpio and dmaengine apis.
> > 
> > Please note that unlike previous driver version, which basically ignored
> > DT specified timings, this one relies on it, so it is important to get
> > it right in your DT (dumping it from previous kernel version).
> > 
> > In case synchronous timings is requested, it is okay to specify timings
> > for the slowest chip ever used for you board as it is evetually optimized
> > after chip probe.
> > 
> > Original driver used DMA only if user specified INT gpio in platform
> > data, now DMA is used unconditionally and PIO mode is used as fallback.
> > 
> > In case anyone wants to give it a try, few DT related changes are needed:
> > - onenand node needs 'ti,omap2-onenand' compatible (for mailine boards this is
> >   done in patch 2)
> > - to use INT pin, int-gpios needs to be specified.
> 
> Roger, Tony, are you happy with this version? If this is the case, I'll
> queue all patches to my nand/next branch (after merging Roger's
> immutable branch in).

Yes thanks Aaro for testing, sounds good to me.

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
