From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 12:24:02 -0600
Message-ID: <20171212182401.GB7404@DeraldWoods-PC.wicab.com>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
 <20171212165542.GC14441@atomide.com>
 <20171212175054.GA10337@lenoch>
 <20171212180827.GA7404@DeraldWoods-PC.wicab.com>
 <20171212181503.GE14441@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212181503.GE14441@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 10:15:03AM -0800, Tony Lindgren wrote:
> * Derald D. Woods <woods.technical@gmail.com> [171212 18:11]:
> > On Tue, Dec 12, 2017 at 06:50:54PM +0100, Ladislav Michl wrote:
> > > On Tue, Dec 12, 2017 at 08:55:42AM -0800, Tony Lindgren wrote:
> > > > * Derald D. Woods <woods.technical@gmail.com> [171212 16:34]:
> > > > > I am testing using an appended device-tree. This has been the most
> > > > > reliable method for the OMAP34XX boards that I have. If you have an
> > > > > example config, with working command line MTDPARTS, for beagleboard(Rev.
> > > > > C4), Overo TOBI, or similiar OMAP34XX, I will gladly use it. Also note
> > > > > that other OMAP34XX boards currently provide a default partition
> > > > > layout. Is that bad practice for all of those as well? I am open to
> > > > > exploring the method that actually works.
> > > > 
> > > > I think we came to the conclusion at some point that it's best to rely
> > > > on u-boot passed partitions because with later u-boot versions the
> > > > size was increased for the bootloader partition.
> > > > 
> > > > Ideally of course we would read the partition information from the
> > > > MTD device somewhere..
> > > 
> > > Already done and called UBI :)
> > 
> > I am aware of all of these things. From an architectural standpoint I
> > agree with everything that has been said. But has anyone checked booting
> > lately? I helped fix an issue in U-Boot, a few months ago, where
> > OMAP34XX boards could not boot for one and half releases. Structural
> > changes were introduced, but booting was not verified on older OMAP3
> > boards. I will build with clean configs, for both U-Boot and Linux, and
> > report my findings on this thread. I recently took over maintaining the
> > OMAP3-EVM in U-Boot. This is why I am pursuing this effort. I am just
> > looking for the consistent and bootable method going forward. It will be
> > later tonight before I can verify builds.
> 
> Well that's good to hear :) My only concern with your patch is what
> happens if somebody boots with older u-boot with different partition
> sizes?

I agree. The 'bootargs' mechanisms have seen some recent changes that
may be a factor in what I am seeing. I had to include the command line
in my config to test some NAND partitioning schemes and UBI. I am
learning and Hopefully fixing some things as I go.

- Derald
