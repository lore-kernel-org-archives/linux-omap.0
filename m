From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v6 13/14] mtd: onenand: omap2: Configure driver from DT
Date: Sat, 22 Dec 2018 11:19:38 +0100
Message-ID: <20181222101938.GA30696@lenoch>
References: <20180112131105.GA13810@lenoch> <20180112131725.GN13810@lenoch>
 <20181222010246.GA27785@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181222010246.GA27785@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On Sat, Dec 22, 2018 at 03:02:46AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Jan 12, 2018 at 02:17:25PM +0100, Ladislav Michl wrote:
> > Move away from platform data configuration and use pure DT approach.
> 
> Unfortunately this patch (now commit a758f50f10cf) has broken onenand
> probe on N9/N950:
> 
> [    3.129364] OneNAND Manufacturer: Unknown (0xa0)
> 
> The init order was changed so that onenand_scan() is called before the
> timings are configured:

That is intentional, as stated in cover letter:
"
Please note that unlike previous driver version, which basically ignored
DT specified timings, this one relies on it, so it is important to get
it right in your DT (dumping it from previous kernel version).

In case synchronous timings is requested, it is okay to specify timings
for the slowest chip ever used for you board as it is evetually optimized
after chip probe.
"

> >  	if ((r = onenand_scan(&c->mtd, 1)) < 0)
> >  		goto err_release_dma;
> >  
> > +	freq = omap2_onenand_get_freq(c->onenand.version_id);
> > +	if (freq > 0) {
> > +		switch (freq) {
> > +		case 104:
> > +			latency = 7;
> > +			break;
> > +		case 83:
> > +			latency = 6;
> > +			break;
> > +		case 66:
> > +			latency = 5;
> > +			break;
> > +		case 56:
> > +			latency = 4;
> > +			break;
> > +		default:	/* 40 MHz or lower */
> > +			latency = 3;
> > +			break;
> > +		}
> > +
> > +		r = gpmc_omap_onenand_set_timings(dev, c->gpmc_cs,
> > +						  freq, latency, &info);
> > +		if (r)
> > +			goto err_release_onenand;
> > +
> > +		r = omap2_onenand_set_cfg(c, info.sync_read, info.sync_write,
> > +					  latency, info.burst_len);
> > +		if (r)
> > +			goto err_release_onenand;
> > +
> > +		if (info.sync_read || info.sync_write)
> > +			dev_info(dev, "optimized timings for %d MHz\n", freq);
> > +	}
> 
> But looks like on N9/N950 we need to do the configuration for the
> onenand_scan() to succeed. I guess the order has to be this because we
> have no other way to know "version_id".
> 
> I tested by changing this other way round (and hardcoding the freq manually)
> and it seems to work.

Well, DT timings for onenand node seems to be copied over without actually
verifying correctness. I do not know which chip comes with N950, so please
verify timings in you DT according chip used. Idea is to use timings for
slowest chip used and driver will ask for faster one if possible.

Best regards,
	ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
