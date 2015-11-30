From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra72-evm: Mark uart1 rxd as wakeup capable
Date: Mon, 30 Nov 2015 13:56:52 -0800
Message-ID: <20151130215652.GF23396@atomide.com>
References: <1448526686-3998-1-git-send-email-vigneshr@ti.com>
 <5657E3DE.5000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5657E3DE.5000107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [151126 21:03]:
> On 11/26/2015 02:31 AM, Vignesh R wrote:
> > Uart1 rxd  is wakeup capable on DRA72 EVM. Hence, mark rxd line as
> > wakeup capable. This is similar to commit 66b0436977e2c ("ARM: dts:
> > dra7-evm: Mark uart1 rxd as wakeup capable") for DRA74 EVM.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> >  arch/arm/boot/dts/dra72-evm.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
> > index d6104d5f0c01..8bf36b0b3c33 100644
> > --- a/arch/arm/boot/dts/dra72-evm.dts
> > +++ b/arch/arm/boot/dts/dra72-evm.dts
> > @@ -478,6 +478,8 @@
> >  
> >  &uart1 {
> >  	status = "okay";
> > +	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> > +			      <&dra7_pmx_core 0x3e0>;
> >  };
> >  
> >  &elm {
> > 
> 
> Acked-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v4.5/dt thanks.

Tony
