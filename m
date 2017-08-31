From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 12/17] ARM: dts: Add missing aess node and binding for
 omap4
Date: Thu, 31 Aug 2017 07:51:12 -0700
Message-ID: <20170831145112.GL6008@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-13-tony@atomide.com>
 <30241474-5f96-2d94-b1a9-4f163c8a4914@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <30241474-5f96-2d94-b1a9-4f163c8a4914-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170830 22:54]:
> On 2017-08-30 18:19, Tony Lindgren wrote:
> > +		aess: aess@401f1000 {
> > +			compatible = "ti,omap4-aess";
> > +			reg = <0x401f1000 0x400>, /* MPU private access */
> > +			      <0x490f1000 0x400>; /* L3 Interconnect */
> > +			reg-names = "mpu", "dma";
> > +			ti,hwmods = "aess";
> 
> status = "disabled"

That could be done for it's children if needed like I replied in
the McASP patch as this is for the interconnect target module.
And this will need to just use the "ti,sysc-type2" compatible.

> Similar comment applies to AESS as to the McASP. We don't have driver
> for it and we most likely not going to have.

OK

> But the binding is not correct in any case. The latest official Android
> kernel is 3.4(ish) to support AESS/ABE. I have rewritten the whole thing
> as an effort to upstream it and maintained the code up to 3.15. There
> the DT node looks like this:
> 
> aess: aess@0x401f1000 {
> 	compatible = "ti,omap4-aess";
> 	reg = <0x401f1000 0x3ff>, /* MPU private access */
> 		<0x40180000 0xffff>, /* DMEM - MPU */
> 		<0x401a0000 0x1fff>, /* CMEM - MPU */
> 		<0x401c0000 0x5fff>, /* SMEM - MPU */
> 		<0x401e0000 0x1fff>, /* PMEM - MPU */
> 		<0x490f1000 0x3ff>, /* L3 Interconnect */
> 		<0x49080000 0xffff>, /* DMEM - MPU */
> 		<0x490a0000 0x1fff>, /* CMEM - MPU */
> 		<0x490ce000 0x5fff>, /* SMEM - MPU */
> 		<0x490e0000 0x1fff>; /* PMEM - MPU */
> 	reg-names = "mpu", "dmem", "cmem", "smem", "pmem",
> 			"dma","dmem_dma", "cmem_dma", "smem_dma",
> 			"pmem_dma";
> 	interrupts = <0 99 0x4>;
> 	ti,hwmods = "aess";
> 	dmas = <&sdma 101>,
> 		<&sdma 102>,
> 		<&sdma 103>,
> 		<&sdma 104>,
> 		<&sdma 105>,
> 		<&sdma 106>,
> 		<&sdma 107>,
> 		<&sdma 108>;
> 	dma-names = "fifo0", "fifo1", "fifo2", "fifo3", "fifo4",
> 			"fifo5", "fifo6", "fifo7";
> };
> 
> This is more closer to what we might need to describe AESS, but it might
> be not correct if I ever have the time to forward port and convert it to
> current upstream framework (DPCM, graph, whatever)

Yeah OK thanks. If there ever is a driver for it, those can then
be added as child nodes of the "ti,sysc-type2" interconnect target
node.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
