From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v3] ARM: dts: OMAP5: Add palmas MFD node and regulator
 nodes
Date: Wed, 12 Jun 2013 08:12:37 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EB0EB@DBDE04.ent.ti.com>
References: <1370928651-6278-1-git-send-email-j-keerthy@ti.com>
 <51B749E7.6070808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51B749E7.6070808@wwwdotorg.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "lee.jones@linaro.org" <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Tuesday, June 11, 2013 9:32 PM
> To: J, KEERTHY
> Cc: Cousson, Benoit; devicetree-discuss@lists.ozlabs.org; linux-
> omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> ldewangan@nvidia.com; grant.likely@secretlab.ca; swarren@nvidia.com;
> sameo@linux.intel.com; gg@slimlogic.co.uk; lee.jones@linaro.org
> Subject: Re: [PATCH v3] ARM: dts: OMAP5: Add palmas MFD node and
> regulator nodes
> 
> On 06/10/2013 11:30 PM, J Keerthy wrote:
> > This patch adds Palmas MFD node and the regulator nodes for OMAP5.
> >
> > The node definitions are based on: https://lkml.org/lkml/2013/6/6/25
> >
> > Boot tested on omap5-uevm board.
> 
> > diff --git a/arch/arm/boot/dts/omap5-uevm.dts
> > b/arch/arm/boot/dts/omap5-uevm.dts
> 
> > +	palmas: palmas@48 {
> > +		reg = <0x48>;
> > +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N
> */
> > +		interrupt-parent = <&gic>;
> > +	};
> > +};
> > +
> > +&palmas {
> > +	compatible = "ti,palmas";
> > +	interrupt-controller;
> > +	#interrupt-cells = <2>;
> 
> I don't really see the point of splitting the node into two parts if
> it's all going into a single file. It made sense if part of the node
> came from a common .dtsi file, but not so much when it doesn't.

The intent was to reduce indentation and to declare its sub-nodes outside
of i2c1. I will club it and resend.

Regards,
Keerthy
