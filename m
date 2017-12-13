From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Wed, 13 Dec 2017 16:05:06 +0100
Message-ID: <20171213150506.GA31096@lenoch>
References: <20171212063930.GA2791@lenoch>
 <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
 <20171212165542.GC14441@atomide.com>
 <20171212175054.GA10337@lenoch>
 <20171212180827.GA7404@DeraldWoods-PC.wicab.com>
 <20171212181503.GE14441@atomide.com>
 <20171212182401.GB7404@DeraldWoods-PC.wicab.com>
 <20171212184052.GA11423@lenoch>
 <CAHCN7xKn2-6NVhy6MegJgEZrF3=DFigvHW6xf0Gb2BFRTJMDNw@mail.gmail.com>
 <20171213134425.GA15909@ethiopia.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213134425.GA15909@ethiopia.hsd1.il.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Derald D. Woods" <woods.technical@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 13, 2017 at 07:44:25AM -0600, Derald D. Woods wrote:
> On Tue, Dec 12, 2017 at 06:13:51PM -0600, Adam Ford wrote:
> > On Dec 12, 2017 12:41 PM, "Ladislav Michl" <ladis@linux-mips.org> wrote:
> > 
> > On Tue, Dec 12, 2017 at 12:24:02PM -0600, Derald D. Woods wrote:
> > > On Tue, Dec 12, 2017 at 10:15:03AM -0800, Tony Lindgren wrote:
> > > > Well that's good to hear :) My only concern with your patch is what
> > > > happens if somebody boots with older u-boot with different partition
> > > > sizes?
> > 
> > 
> > It is for this reason that I submitted a patch for the logic PD Torpedo
> > board to remove the partitions from the device tree.
> > 
> 
> I used this same rationale when I updated the device-tree for omap3-evm.
> The issue is that the OMAP34XX boards have been left behind. Though the
> rationale is correct, it is not as applicable to SOC/board combinations
> that have not seen recent maintenance.
> 
> Two things were apparent after some investigation:
> 
> 1. There are no current OMAP34XX boards in U-Boot using
>    CONFIG_OF_CONTROL for booting. I spent some time last night adding
>    the use of OF_CONTROL for omap3-evm. Obviously no other boards have
>    gone down this path, since the '.dtsi' files have yet to be included.
>    I attempt to get this working over the next few days. The following
>    U-Boot files will modified and added.
> 
> 	modified:   arch/arm/dts/Makefile
> 	modified:   configs/omap3_evm_defconfig
> 	modified:   include/configs/omap3_evm.h
> 
> 	arch/arm/dts/omap-gpmc-smsc911x.dtsi
> 	arch/arm/dts/omap3-evm-37xx-u-boot.dtsi
> 	arch/arm/dts/omap3-evm-37xx.dts
> 	arch/arm/dts/omap3-evm-common.dtsi
> 	arch/arm/dts/omap3-evm-processor-common.dtsi
> 	arch/arm/dts/omap3-evm-u-boot.dtsi
> 	arch/arm/dts/omap3-evm.dts
> 	arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi
> 	arch/arm/dts/omap34xx.dtsi
> 
>    The Logic PD devkits(s) are the most recent additions and best
>    examples to date.
> 
> 2. The issue is really with passing the kernel command line. OMAP36XX
>    boards seem to have the command line passed regardless of FDT usage.
>    With OMAP34XX that is not the case. I have a BeageBoard(OMAP3530) and
>    a BeagleBoard-xM(DM3730) to test with. This is an interesting test
>    setup because they share the same U-Boot board files and general
>    architecture. There is something different, with respect to kernel
>    command line passing, between these OMAP3 variants.

There really isn't anything special. Just fixup FDT before passing it
to kernel.

Btw, IGEPv2 boards come with both DM3730 and OMAP3530 and also NAND
or OneNAND. All supported by single setup.

> I will dig a bit deeper over the next few days. I just want to get the
> omap3-evm platform to work properly. I have a few of these systems. I/O
> and peripheral wise, they are the most complete test systems that I own.

Please move this discussion to the U-Boot mailing list as it is getting
off topic here.

Thank you,
	ladis

> - Derald
> 
> > >
> > > I agree. The 'bootargs' mechanisms have seen some recent changes that
> > > may be a factor in what I am seeing. I had to include the command line
> > > in my config to test some NAND partitioning schemes and UBI. I am
> > > learning and Hopefully fixing some things as I go.
> > 
> > u-boot/board/isee/igep00x0/igep00x0.c is using only two MTD partitions,
> > runtime generated. As OMAP's BootROM tries to read from atmost first
> > four sectors before it gives up, size of SPL partiton is runtime
> > generated according to NAND sector size. The rest of NAND is UBI managed.
> > This of course breaks backward compatibility, but is unlikely to break
> > in future. Someone needs to decide :)
> > 
> >         ladis
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
