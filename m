From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 00/16] OMAP2+ OneNAND driver update
Date: Thu, 30 Nov 2017 08:09:36 -0800
Message-ID: <20171130160936.GO28152@atomide.com>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171130111840.41c92d34@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171130111840.41c92d34@bbrezillon>
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

* Boris Brezillon <boris.brezillon@free-electrons.com> [171130 10:21]:
> On Wed, 15 Nov 2017 17:23:06 +0100
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > this patch serie updates OMAP2+ OneNAND driver to the present times, making
> > it fully DT configurable, using libgpio and dmaengine apis - those are
> > optional, driver will work without them.
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
> > - to use INT pin, int-gpios needs to be specified (for n900 and n8x0 this is
> >   done in patch 16, however patch lacks pinmux configuration.
> > 
> > Most notable changes from v3:
> > - added dmaengine patches by Peter Ujfalusi
> > - added dt bindings documentation
> > - added cleanup patches
> > - DMA enabled by default
> > 
> > Most notable changes from v4:
> > - collected tags
> > - used INT pin name properly
> > - hopefully all comments taken into account
> > 
> > Also note that driver will fail probe OneNAND chip after patch 13 and start
> > working again after patch 14.
> 
> Well, breaking bisectability is never a good thing, this being said, I
> won't complain if TI maintainers are okay with that.

There should not be any reason to break git bisect for booting at all,
what exactly is the issue here?

> > Testing and benchmarking very welcome.
> 
> Let me know when you think this series is ready to be merged.

Well we need Aaro to test this on n8x0 as my n800 is currently not
booting at all.

> > Depends on "memory: omap-gpmc: Make 'bank-width' property optional"
> > https://patchwork.kernel.org/patch/10043259/
> 
> Hm, I see this patch has been applied to the omap tree, so maybe it's
> simpler if everything goes through this tree. I don't plan to modify
> onenand related stuff in this release anyway.

Maybe Roger can provide you with an immutable commit with just that
patch?

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
