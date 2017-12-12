From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 19:40:52 +0100
Message-ID: <20171212184052.GA11423@lenoch>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
 <20171212165542.GC14441@atomide.com>
 <20171212175054.GA10337@lenoch>
 <20171212180827.GA7404@DeraldWoods-PC.wicab.com>
 <20171212181503.GE14441@atomide.com>
 <20171212182401.GB7404@DeraldWoods-PC.wicab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212182401.GB7404@DeraldWoods-PC.wicab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 12:24:02PM -0600, Derald D. Woods wrote:
> On Tue, Dec 12, 2017 at 10:15:03AM -0800, Tony Lindgren wrote:
> > Well that's good to hear :) My only concern with your patch is what
> > happens if somebody boots with older u-boot with different partition
> > sizes?
> 
> I agree. The 'bootargs' mechanisms have seen some recent changes that
> may be a factor in what I am seeing. I had to include the command line
> in my config to test some NAND partitioning schemes and UBI. I am
> learning and Hopefully fixing some things as I go.

u-boot/board/isee/igep00x0/igep00x0.c is using only two MTD partitions,
runtime generated. As OMAP's BootROM tries to read from atmost first
four sectors before it gives up, size of SPL partiton is runtime
generated according to NAND sector size. The rest of NAND is UBI managed.
This of course breaks backward compatibility, but is unlikely to break
in future. Someone needs to decide :)

	ladis
