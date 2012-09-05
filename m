From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Wed, 5 Sep 2012 06:11:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45171 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2IEGLg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 02:11:36 -0400
In-Reply-To: <5045D557.30404@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 04, 2012 at 15:47:59, Cousson, Benoit wrote:
> Hi Vaibhav,
> 
> On 09/04/2012 05:42 AM, Vaibhav Hiremath wrote:
> > On 9/3/2012 8:16 PM, Benoit Cousson wrote:
> >> Hi Peter,
> >>
> >> The overall series looks good to me, but I do have a couple of comments.
> >>
> >> On 08/29/2012 03:31 PM, Peter Ujfalusi wrote:
> >>> The McBSP IP within OMAP2420 and 2430 is different we need to create separate
> >>> dtsi files for them.
> >>>
> >>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>> ---
> >>>  arch/arm/boot/dts/omap2420.dtsi |   39 ++++++++++++++++++
> >>>  arch/arm/boot/dts/omap2430.dtsi |   83 +++++++++++++++++++++++++++++++++++++++
> >>>  2 files changed, 122 insertions(+), 0 deletions(-)
> >>>  create mode 100644 arch/arm/boot/dts/omap2420.dtsi
> >>>  create mode 100644 arch/arm/boot/dts/omap2430.dtsi
> >>>
> >>> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> >>> new file mode 100644
> >>> index 0000000..f375c68
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/omap2420.dtsi
> >>> @@ -0,0 +1,39 @@
> >>> +/*
> >>> + * Device Tree Source for OMAP2420 SoC
> >>> + *
> >>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >>
> >> Nit: 2012
> >>
> >>> + *
> >>> + * This file is licensed under the terms of the GNU General Public License
> >>> + * version 2.  This program is licensed "as is" without any warranty of any
> >>> + * kind, whether express or implied.
> >>> + */
> >>> +
> >>> +/include/ "omap2.dtsi"
> >>> +
> >>> +/ {
> >>> +	compatible = "ti,omap2420", "ti,omap2";
> >>> +
> >>> +	ocp {
> >>> +		mcbsp1: mcbsp@48074000 {
> >>> +			compatible = "ti,omap2420-mcbsp";
> >>> +			reg = <0x48074000 0xff>;
> >>> +			reg-names = "mpu";
> >>> +			interrupts = <0 59 0x4>, /* TX interrupt */
> >>> +				     <0 60 0x4>; /* RX interrupt */
> >>
> >> That one is not correct because it does comply with the interrupt
> >> controller specifier that require only one cell:
> >>
> >> 		intc: interrupt-controller@48200000 {
> >> 			compatible = "ti,omap2-intc";
> >> 			interrupt-controller;
> >> 			#interrupt-cells = <1>;
> >> ...
> >>
> >> The one you are using is for GIC IRQ controller.
> >> It works probably because we are using hwmod so far :-)
> >>
> > 
> > I think now we should kill the resource overwrite path, and should
> > respect and use resources passed from DT.
> > 
> > Benoit,
> > Did you get a chance to validate patch submitted towards this??
> 
> Not yet, but we discussed that with Peter and since he does have these
> patches for DT, he'll be able to test your series with the McBSP changes.
> 

Great.

> I still want to update a couple of DTS to test that on some other IPs.
> 

Ohh ok. Please let me know if I can help you here by any means.
I am equipped with AM37xEVM, BeagleBoard and Panda.

Thanks,
Vaibhav

