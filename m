From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 08:55:42 -0800
Message-ID: <20171212165542.GC14441@atomide.com>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Derald D. Woods <woods.technical@gmail.com> [171212 16:34]:
> On Tue, Dec 12, 2017 at 07:39:30AM +0100, Ladislav Michl wrote:
> > On Mon, Dec 11, 2017 at 10:12:13PM -0600, Derald D. Woods wrote:
> > > The partition information was omitted during the conversion to OMAP3430
> > > specific data.
> > 
> > That could be intentional...
> 
> I am fixing an addition that I created.
> 
> > 
> > > The data added by this commit is consistent with current U-Boot default
> > > definitions.
> > 
> > What about passing U-Boot partitions information to kernel instead?
> > 
> 
> I am testing using an appended device-tree. This has been the most
> reliable method for the OMAP34XX boards that I have. If you have an
> example config, with working command line MTDPARTS, for beagleboard(Rev.
> C4), Overo TOBI, or similiar OMAP34XX, I will gladly use it. Also note
> that other OMAP34XX boards currently provide a default partition
> layout. Is that bad practice for all of those as well? I am open to
> exploring the method that actually works.

I think we came to the conclusion at some point that it's best to rely
on u-boot passed partitions because with later u-boot versions the
size was increased for the bootloader partition.

Ideally of course we would read the partition information from the
MTD device somewhere..

Regards,

Tony
