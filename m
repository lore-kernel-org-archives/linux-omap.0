From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-evm: Fix missing NAND partition
 information
Date: Tue, 12 Dec 2017 10:31:26 -0600
Message-ID: <20171212163125.GA8032@DeraldWoods-PC.wicab.com>
References: <20171212041213.27436-1-woods.technical@gmail.com>
 <20171212063930.GA2791@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212063930.GA2791@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 07:39:30AM +0100, Ladislav Michl wrote:
> On Mon, Dec 11, 2017 at 10:12:13PM -0600, Derald D. Woods wrote:
> > The partition information was omitted during the conversion to OMAP3430
> > specific data.
> 
> That could be intentional...

I am fixing an addition that I created.

> 
> > The data added by this commit is consistent with current U-Boot default
> > definitions.
> 
> What about passing U-Boot partitions information to kernel instead?
> 

I am testing using an appended device-tree. This has been the most
reliable method for the OMAP34XX boards that I have. If you have an
example config, with working command line MTDPARTS, for beagleboard(Rev.
C4), Overo TOBI, or similiar OMAP34XX, I will gladly use it. Also note
that other OMAP34XX boards currently provide a default partition
layout. Is that bad practice for all of those as well? I am open to
exploring the method that actually works.

- Derald


> > Fixes: 62fe1d337461 ("ARM: dts: omap3-evm: Add OMAP3530 specific device
> > tree processor data")
> > 
> > Signed-off-by: Derald D. Woods <woods.technical@gmail.com>
> > ---
> >  arch/arm/boot/dts/omap3-evm.dts | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
> > index 21a3b88aef0c..1220deb47aae 100644
> > --- a/arch/arm/boot/dts/omap3-evm.dts
> > +++ b/arch/arm/boot/dts/omap3-evm.dts
> > @@ -85,5 +85,30 @@
> >  
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> > +
> > +		partition@0 {
> > +			label = "spl";
> > +			reg = <0 0x80000>;
> > +		};
> > +		partition@80000 {
> > +			label = "u-boot";
> > +			reg = <0x80000 0x1c0000>;
> > +		};
> > +		partition@240000 {
> > +			label = "dtb";
> > +			reg = <0x240000 0x20000>;
> > +		};
> > +		partition@260000 {
> > +			label = "u-boot-env";
> > +			reg = <0x260000 0x20000>;
> > +		};
> > +		partition@280000 {
> > +			label = "kernel";
> > +			reg = <0x280000 0x600000>;
> > +		};
> > +		partition@880000 {
> > +			label = "rootfs";
> > +			reg = <0x880000 0>;
> > +		};
> >  	};
> >  };
> > -- 
> > 2.15.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
