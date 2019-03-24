From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date: Sun, 24 Mar 2019 17:48:22 +0100
Message-ID: <2631901.52Nzq63B5o@z50>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190320011630.GB7872@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190320011630.GB7872@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Boris Brezillon <bbrezillon@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

Thanks for your review.

On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> > After recent modifications, only a hardcoded partition info makes
> > the driver device specific.  Other than that, the driver uses GPIO
> > exclusively and can be used on any hardware.
> > 
> > Drop the partition info and use MTD partition parser with default
> > list of partition types instead.
> > 
> > Amstrad Delta users should append the followig partition info to their
>                                         ^^^^^^^^
> Should be "following".
> 
> > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> > convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> > Kconfig automatically if this NAND driver is also selected.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Could we move the fixed partition setup to the board file
> instead? Otherwise this kind of change is not really nice for the users,
> as it will likely break existing setups. The default partition layout
> should remain the same.

I'm wondering if it would be acceptable to pass partition info from a .dts 
file.  I think that would be a better, more modern approach than adding a new 
header under include/linux/platform_data.

The problem with a device tree based implementation is, I know of no u-boot 
version supporting both Amstrad Delta and FDT.  However, I've already tested 
two solutions that work for me.

One uses CONFIG_ARM_APPENDED_DTB and requires a user to manually append the 
blob to zImage and (re)generate uImage.  I'm not sure how much more user-
friendly it looks for you, compared to the command line version I proposed 
initially.

If the above is not acceptable. I can propose still another approach. The blob 
is automagically built and embedded into the kernel with some assembler glue, 
then unflattened from the board init_machine(), somehow similar to the way 
drivers/of/unittest.c does it.

Please advise which approach sounds best to you (platform_data, 
CONFIG_ARM_APPENDED_DTB or unittest like).

Thanks,
Janusz


> 
> A.
> 
