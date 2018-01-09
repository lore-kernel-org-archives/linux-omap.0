From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v5 00/16] OMAP2+ OneNAND driver update
Date: Tue, 9 Jan 2018 14:08:12 +0100
Message-ID: <20180109130812.GA338@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171130111840.41c92d34@bbrezillon>
 <20171130160936.GO28152@atomide.com>
 <434bd733-0ba2-6e75-9de5-017eef905fd2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <434bd733-0ba2-6e75-9de5-017eef905fd2@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Just a very gentle ping, more bellow...

On Fri, Dec 01, 2017 at 03:43:55PM +0200, Roger Quadros wrote:
> On 30/11/17 18:09, Tony Lindgren wrote:
> > * Boris Brezillon <boris.brezillon@free-electrons.com> [171130 10:21]:
> >> On Wed, 15 Nov 2017 17:23:06 +0100
> >> Ladislav Michl <ladis@linux-mips.org> wrote:
> >>
> >>> this patch serie updates OMAP2+ OneNAND driver to the present times, making
> >>> it fully DT configurable, using libgpio and dmaengine apis - those are
> >>> optional, driver will work without them.
> >>>
> >>> Please note that unlike previous driver version, which basically ignored
> >>> DT specified timings, this one relies on it, so it is important to get
> >>> it right in your DT (dumping it from previous kernel version).
> >>>
> >>> In case synchronous timings is requested, it is okay to specify timings
> >>> for the slowest chip ever used for you board as it is evetually optimized
> >>> after chip probe.
> >>>
> >>> Original driver used DMA only if user specified INT gpio in platform
> >>> data, now DMA is used unconditionally and PIO mode is used as fallback.
> >>>
> >>> In case anyone wants to give it a try, few DT related changes are needed:
> >>> - onenand node needs 'ti,omap2-onenand' compatible (for mailine boards this is
> >>>   done in patch 2)
> >>> - to use INT pin, int-gpios needs to be specified (for n900 and n8x0 this is
> >>>   done in patch 16, however patch lacks pinmux configuration.
> >>>
> >>> Most notable changes from v3:
> >>> - added dmaengine patches by Peter Ujfalusi
> >>> - added dt bindings documentation
> >>> - added cleanup patches
> >>> - DMA enabled by default
> >>>
> >>> Most notable changes from v4:
> >>> - collected tags
> >>> - used INT pin name properly
> >>> - hopefully all comments taken into account
> >>>
> >>> Also note that driver will fail probe OneNAND chip after patch 13 and start
> >>> working again after patch 14.
> >>
> >> Well, breaking bisectability is never a good thing, this being said, I
> >> won't complain if TI maintainers are okay with that.
> > 
> > There should not be any reason to break git bisect for booting at all,
> > what exactly is the issue here?
> > 
> >>> Testing and benchmarking very welcome.
> >>
> >> Let me know when you think this series is ready to be merged.
> > 
> > Well we need Aaro to test this on n8x0 as my n800 is currently not
> > booting at all.
> > 
> >>> Depends on "memory: omap-gpmc: Make 'bank-width' property optional"
> >>> https://patchwork.kernel.org/patch/10043259/
> >>
> >> Hm, I see this patch has been applied to the omap tree, so maybe it's
> >> simpler if everything goes through this tree. I don't plan to modify
> >> onenand related stuff in this release anyway.
> > 
> > Maybe Roger can provide you with an immutable commit with just that
> > patch?
> 
> Here you go

Thank you :)

Merge window is really close now and patches seems still to be untested on
n8x0. So unless someone is going to test it soon, I'll pick used N800 on
ebay :-/

I would also appreciate final statement which tree will used to merge this
patchset. So far everyone seems to agree this patchset will enter via single
tree, right? If that is the case I'm proposing to squash patches 13 and 14
into single patch, so we do not break bisecting.

> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git for-v4.16/gpmc-omap-immutable
> 
> for you to fetch changes up to c18a7ac3398d0cef29749f9568666db8321aa4c9:
> 
>   memory: omap-gpmc: Make 'bank-width' property optional (2017-12-01 15:37:49 +0200)
> 
> ----------------------------------------------------------------
> Ladislav Michl (1):
>       memory: omap-gpmc: Make 'bank-width' property optional
> 
>  drivers/memory/omap-gpmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> -- 
> cheers,
> -roger
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
