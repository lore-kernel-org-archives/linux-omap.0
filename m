From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v4 13/16] memory: omap-gpmc: Refactor OneNAND support
Date: Wed, 15 Nov 2017 11:37:03 +0100
Message-ID: <20171115103703.mct5pltlln6qwgeh@lenoch>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212612.ynj6ckbu4u2n5i7d@lenoch>
 <76daab23-b20f-1613-4cb3-34cdd02acf84@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <76daab23-b20f-1613-4cb3-34cdd02acf84@ti.com>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 12:13:56PM +0200, Roger Quadros wrote:
> On 11/11/17 23:26, Ladislav Michl wrote:
[snip]
> > +/**
> > + * gpmc_omap_onenand_set_timings - set optimized sync timings.
> > + * @cs:      Chip Select Region
> > + * @freq:    Chip frequency
> > + * @latency: Burst latency cycle count
> > + * @info:    Structure describing parameters used
> 
> How about adding some description? e.g.
> 
> sets optimized timings for the provided @cs region based on
> provided @freq and @latency. Updates the @info structure based on
> the GPMC settings.

Added to v5, thank you.

Side question: u-boot has patman to deal with patch changelog. Is there
something similar or even better for linux? For the time being I setup
patman...

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
