From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 13/14] mtd: onenand: omap2: Configure driver from DT
Date: Sun, 23 Dec 2018 07:56:49 -0800
Message-ID: <20181223155649.GJ6707@atomide.com>
References: <20180112131105.GA13810@lenoch> <20180112131725.GN13810@lenoch>
 <20181222010246.GA27785@darkstar.musicnaut.iki.fi>
 <20181222101938.GA30696@lenoch>
 <20181223125149.GE27785@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181223125149.GE27785@darkstar.musicnaut.iki.fi>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Ladislav Michl <ladis@linux-mips.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181223 12:52]:
> Hi,
> 
> On Sat, Dec 22, 2018 at 11:19:38AM +0100, Ladislav Michl wrote:
> > Well, DT timings for onenand node seems to be copied over without actually
> > verifying correctness. I do not know which chip comes with N950, so please
> > verify timings in you DT according chip used. Idea is to use timings for
> > slowest chip used and driver will ask for faster one if possible.
> 
> Hmm, right. I thought we had some dumped values in the DT, but apparently
> wrong ones. What is the method for dumping the "right" values? If I just
> enable GPMC debug with old kernel, it's dumping the DT entries twice,
> but neither set works with the new kernel.
> 
> Then I tried the "before" values from the new kernel, and they seem to
> work (patch below)...

You can enable CONFIG_OMAP_GPMC_DEBUG=y and the gpmc driver should print
out the bootloader timings for you on boot to make sure they're what you
posted. Then if the values are different between devices, then it makes
sense to add them to the device specific dts files.

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
