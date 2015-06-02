From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: am4372: Add emif node
Date: Tue, 2 Jun 2015 12:58:42 -0700
Message-ID: <20150602195841.GM30984@atomide.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
 <1430933133-33412-3-git-send-email-d-gerlach@ti.com>
 <20150602192228.GF9623@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55458 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbFBT6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 15:58:44 -0400
Content-Disposition: inline
In-Reply-To: <20150602192228.GF9623@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <balbi@ti.com> [150602 12:26]:
> On Wed, May 06, 2015 at 12:25:33PM -0500, Dave Gerlach wrote:
> > Add node for TI AM4372 EMIF.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> 
> Tony, this patch fixes the regression I just reported at [1], care to
> pick this one up ?

OK thanks yes tag this for v4.2 fixes.

Regards,

Tony
 
> Tested-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> [1] http://marc.info/?l=linux-omap&m=143327283632248&w=2
> 
> > ---
> >  Documentation/devicetree/bindings/memory-controllers/ti/emif.txt | 1 +
> >  arch/arm/boot/dts/am4372.dtsi                                    | 6 ++++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> > index 938f8e1..0db6047 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> > +++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> > @@ -8,6 +8,7 @@ of the EMIF IP and memory parts attached to it.
> >  Required properties:
> >  - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
> >    is the IP revision of the specific EMIF instance.
> > +		  For am437x should be ti,emif-am4372.
> >  
> >  - phy-type	: <u32> indicating the DDR phy type. Following are the
> >    allowed values
> > diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> > index c80a3e2..9521a38 100644
> > --- a/arch/arm/boot/dts/am4372.dtsi
> > +++ b/arch/arm/boot/dts/am4372.dtsi
> > @@ -132,6 +132,12 @@
> >  			};
> >  		};
> >  
> > +		emif: emif@4c000000 {
> > +			compatible = "ti,emif-am4372";
> > +			reg = <0x4c000000 0x1000000>;
> > +			ti,hwmods = "emif";
> > +		};
> > +
> >  		edma: edma@49000000 {
> >  			compatible = "ti,edma3";
> >  			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > -- 
> > 2.3.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi


