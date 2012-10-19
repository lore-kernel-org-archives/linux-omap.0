From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v2] arm/dts: AM33XX: Add SPI device tree data
Date: Fri, 19 Oct 2012 07:30:16 -0400
Message-ID: <20121019113016.GE25164@beef>
References: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
 <50810E2F.5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50810E2F.5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, linux@arm.linux.org.uk, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 19, 2012 at 10:24:15AM +0200, Benoit Cousson wrote:
> Hi Avinash,
> 
> This look good to me except the: status = "disabled".
> 
> The "disabled" should be reserved for variant that does not contain the IP.
> Is it the case here?

http://comments.gmane.org/gmane.linux.drivers.devicetree/18968 is what
I've been going by with the DTS support in the EDMA dmaengine series. It
does make the most sense to only enable what you need in the
<board>.dts.

-Matt

> On 09/18/2012 07:30 AM, Philip, Avinash wrote:
> > Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> > as the driver) is reused from OMAP4.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > Tested-by: Matt Porter <mporter@ti.com>
> > ---
> > Changes since v1:
> >         - Corrected reg offset in reg DT entry.
> > 
> > :100644 100644 ff3badb... 065fd54... M	arch/arm/boot/dts/am33xx.dtsi
> >  arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index ff3badb..065fd54 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -219,5 +219,30 @@
> >  			interrupt-parent = <&intc>;
> >  			interrupts = <91>;
> >  		};
> > +
> > +		spi0: spi@48030000 {
> > +			compatible = "ti,omap4-mcspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x48030000 0x400>;
> > +			interrupt-parent = <&intc>;
> > +			interrupt = <65>;
> > +			ti,spi-num-cs = <2>;
> > +			ti,hwmods = "spi0";
> > +			status = "disabled";
> > +
> > +		};
> > +
> > +		spi1: spi@481a0000 {
> > +			compatible = "ti,omap4-mcspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x481a0000 0x400>;
> > +			interrupt-parent = <&intc>;
> > +			interrupt = <125>;
> > +			ti,spi-num-cs = <2>;
> > +			ti,hwmods = "spi1";
> > +			status = "disabled";
> > +		};
> >  	};
> >  };
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
