From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Thu, 9 Nov 2017 19:34:08 +0100
Message-ID: <20171109183408.xbc4bacawv7li54l@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091253.lvrzi5kbaykkxlcb@lenoch>
 <20171109175626.GD28152@atomide.com>
 <20171109181004.g55vx4iveo5sulpt@lenoch>
 <20171109182645.GE28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109182645.GE28152@atomide.com>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 10:26:45AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171109 18:11]:
> > On Thu, Nov 09, 2017 at 09:56:26AM -0800, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Ladislav Michl <ladis@linux-mips.org> [171109 09:14]:
> > > > Use generic probe function to deal with OneNAND node and remove now useless
> > > > gpmc_probe_onenand_child function.
> > > > Import sync mode timing calculation function from mach-omap2/gpmc-onenand.c
> > > > and prepare for MTD driver DTfication.
> > > 
> > > I tried giving this series a try on n900, but looks like onenand is no longer
> > > seen on n900 after this first patch.
> > 
> > This first patch makes original driver stop working as it removes special
> > OneNAND handling. If it doesn't work even after applying whole serie, then:
> > - verify onenand node has compatible 'ti,omap2-onenand' property
> > - verify timings
> > 
> > On IGEPv2 bootlog shows:
> > [    1.544464] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> > [    1.550415] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> > [    1.560485] omap2-onenand 30000000.onenand: initializing on CS0, phys base 0x30000000, virtual base e0080000
> > [    1.571014] Muxed OneNAND(DDP) 512MB 1.8V 16-bit (0x58)
> > [    1.576507] OneNAND version = 0x0031
> > [    1.583435] Scanning device for bad blocks
> > [    1.620971] OneNAND eraseblock 597 is an initial bad block
> > [    1.657470] OneNAND eraseblock 1159 is an initial bad block
> > [    1.754577] OneNAND eraseblock 2812 is an initial bad block
> > [    1.832214] omap2-onenand 30000000.onenand: optimized timings for 83 MHz
> > [    1.842620] 2 ofpart partitions found on MTD device 30000000.onenand
> > [    1.849426] Creating 2 MTD partitions on "30000000.onenand":
> > [    1.855651] 0x000000000000-0x000000080000 : "SPL"
> > [    1.863464] 0x000000080000-0x000020000000 : "UBI"
> > 
> > For a start:
> > 
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> > index 4acd32a1c4ef..aa5b1a439564 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -838,6 +838,7 @@
> >  	onenand@0,0 {
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> > +		compatible = "ti,omap2-onenand";
> >  		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> >  
> >  		gpmc,sync-read;
> 
> Well we should have the dependencies merged first to avoid breaking

Yes, that's what cover letter says :-)
Also, I still count on your suggestion to merge it via mtd tree.

> git bisect. After applying this and the first patch I see:
> 
> omap-gpmc 6e000000.gpmc: /ocp@68000000/gpmc@6e000000/onenand@0,0 has no 'bank-width' property
> omap-gpmc 6e000000.gpmc: failed to probe DT child 'onenand': -22
> 
> So seems like more dts changes are needed to test this.

Argh... You are right, I should add this into serie:
https://patchwork.kernel.org/patch/10043259/

> Regards,
> 
> Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
