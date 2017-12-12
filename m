From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 18:50:54 +0100
Message-ID: <20171212175054.GA10337@lenoch>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
 <20171212165542.GC14441@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212165542.GC14441@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Derald D. Woods" <woods.technical@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 08:55:42AM -0800, Tony Lindgren wrote:
> * Derald D. Woods <woods.technical@gmail.com> [171212 16:34]:
> > I am testing using an appended device-tree. This has been the most
> > reliable method for the OMAP34XX boards that I have. If you have an
> > example config, with working command line MTDPARTS, for beagleboard(Rev.
> > C4), Overo TOBI, or similiar OMAP34XX, I will gladly use it. Also note
> > that other OMAP34XX boards currently provide a default partition
> > layout. Is that bad practice for all of those as well? I am open to
> > exploring the method that actually works.
> 
> I think we came to the conclusion at some point that it's best to rely
> on u-boot passed partitions because with later u-boot versions the
> size was increased for the bootloader partition.
> 
> Ideally of course we would read the partition information from the
> MTD device somewhere..

Already done and called UBI :)
