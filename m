From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH V2 1/2] ARM: dts: AM33xx: Add RNG node
Date: Tue, 29 Oct 2013 14:00:14 -0700
Message-ID: <20131029210013.GH15154@atomide.com>
References: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com>
 <1377780731-3648-2-git-send-email-lokeshvutla@ti.com>
 <52594DF0.1050002@ti.com>
 <525CE564.6010605@baylibre.com>
 <525E7599.8010504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20483 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752862Ab3J2VAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 17:00:18 -0400
Content-Disposition: inline
In-Reply-To: <525E7599.8010504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rob.herring@calxeda.com, mark.rutland@arm.com

* Lokesh Vutla <lokeshvutla@ti.com> [131016 04:16]:
> + Rob and Mark
> On Tuesday 15 October 2013 12:19 PM, Benoit Cousson wrote:
> > Hi Lokesh,
> > 
> > On 12/10/2013 15:26, Lokesh Vutla wrote:
> >> Hi Benoit,
> >> On Thursday 29 August 2013 06:22 PM, Lokesh Vutla wrote:
> >>> Add the AM33xx RNG module's device tree data.
> >>> Also add Documentation file describing the data
> >>> for the RNG module.
> Can you please review this patch..

OK enough of waiting here, I'm picking this patch into
omap-for-v3.13/dt branch as it removes some boot time warnings
we're seeing.

Regards,

Tony
 
> Thanks and regards,
> Lokesh
> >> Seems you missed this patch. Please consider this for this merge window.
> > 
> > Indeed I missed it. Sorry :-(
> > 
> >> Patch 2/2 is already taken by Paul.
> >> Without this patch AM335x boot will crash as I mentioned in my cover letter.
> >>
> >> Thanks and regards,
> >> Lokesh
> >>>
> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>> ---
> >>> Changes since V1:
> >>> - Drop "status=disabled" entry in dt node, Since
> >>>    RNG is present on all AM33xx platforms.
> >>>
> >>>   .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
> >>>   arch/arm/boot/dts/am33xx.dtsi                      |    7 +++++++
> >>>   2 files changed, 29 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
> > 
> > I do not see the acked-by for the binding part. You do need that for any new bindings nowadays.
> > 
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> >>> new file mode 100644
> >>> index 0000000..6a62acd
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> >>> @@ -0,0 +1,22 @@
> >>> +OMAP SoC HWRNG Module
> >>> +
> >>> +Required properties:
> >>> +
> >>> +- compatible : Should contain entries for this and backward compatible
> >>> +  RNG versions:
> >>> +  - "ti,omap2-rng" for OMAP2.
> >>> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
> >>> +  Note that these two versions are incompatible.
> >>> +- ti,hwmods: Name of the hwmod associated with the RNG module
> >>> +- reg : Offset and length of the register set for the module
> >>> +- interrupts : the interrupt number for the RNG module.
> >>> +        Only used for "ti,omap4-rng".
> >>> +
> >>> +Example:
> >>> +/* AM335x */
> >>> +rng: rng@48310000 {
> >>> +    compatible = "ti,omap4-rng";
> >>> +    ti,hwmods = "rng";
> >>> +    reg = <0x48310000 0x2000>;
> >>> +    interrupts = <111>;
> >>> +};
> >>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> >>> index 38b446b..26ebe30 100644
> >>> --- a/arch/arm/boot/dts/am33xx.dtsi
> >>> +++ b/arch/arm/boot/dts/am33xx.dtsi
> >>> @@ -530,5 +530,12 @@
> >>>               #size-cells = <1>;
> >>>               status = "disabled";
> >>>           };
> >>> +
> >>> +        rng: rng@48310000 {
> >>> +            compatible = "ti,omap4-rng";
> >>> +            ti,hwmods = "rng";
> >>> +            reg = <0x48310000 0x2000>;
> >>> +            interrupts = <111>;
> >>> +        };
> >>>       };
> >>>   };
> >>>
> >>
> > 
> > It looks good to me, but it does not apply on my branch.
> > Please rebase it and repost with the proper acked-by.
> > 
> > Thanks,
> > Benoit
> > 
> > 
> 
