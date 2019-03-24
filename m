From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition
 info
Date: Sun, 24 Mar 2019 21:30:28 +0100
Message-ID: <3239616.xjhv0hSXo4@z50>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com>
 <2631901.52Nzq63B5o@z50> <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sunday, March 24, 2019 7:59:32 PM CET Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
> > Hi Aaro,
> > 
> > Thanks for your review.
> > 
> > On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> > > On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> > > > After recent modifications, only a hardcoded partition info makes
> > > > the driver device specific.  Other than that, the driver uses GPIO
> > > > exclusively and can be used on any hardware.
> > > > 
> > > > Drop the partition info and use MTD partition parser with default
> > > > list of partition types instead.
> > > > 
> > > > Amstrad Delta users should append the followig partition info to their
> > >                                         ^^^^^^^^
> > > Should be "following".
> > > 
> > > > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > > > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-
boot_params),\
> > > > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> > > > convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> > > > Kconfig automatically if this NAND driver is also selected.
> > > > 
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > 
> > > Could we move the fixed partition setup to the board file
> > > instead? Otherwise this kind of change is not really nice for the users,
> > > as it will likely break existing setups. The default partition layout
> > > should remain the same.
> > 
> > I'm wondering if it would be acceptable to pass partition info from a .dts 
> > file.  I think that would be a better, more modern approach than adding a 
new 
> > header under include/linux/platform_data.
> 
> Hmm, I thought there was some generic way to define partitions without
> adding any new headers. But if that is not possible, then I guess your
> CMDLINE proposal is the preferred one..

I could for example reuse (or abuse) struct gpio_nand_platdata defined in 
include/linux/mtd/nand-gpio.h for use with drivers/mtd/nand/raw/gpio.c, but 
I'm not sure if hi-jacking a header that belongs to another driver would be an 
elegant solution.

Thanks,
Janusz


> 
> A.
> 
