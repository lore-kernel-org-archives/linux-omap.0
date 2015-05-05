From: Tony Lindgren <tony@atomide.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Tue, 5 May 2015 07:58:28 -0700
Message-ID: <20150505145828.GB21061@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5548CB54.1040302@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150505 06:54]:
> On 05/04/2015 05:11 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > Adding Peter to Cc as well.
> > 
> > * Robert Schwebel <r.schwebel@pengutronix.de> [150503 23:44]:
> >> Hi,
> >>
> >> since 5e863c561, I get this warning for an AM335x board:
> >>
> >>   omap_hwmod: tptc0 using broken dt data from edma
> >>   omap_hwmod: tptc1 using broken dt data from edma
> >>   omap_hwmod: tptc2 using broken dt data from edma
> >>
> >> It seems like the code in arch/arm/mach-omap2/omap_hwmod.c expects the oftree
> >> entry to look differently than what we currently have in
> >> arch/arm/boot/dts/am33xx.dtsi:
> >>
> >>   edma: edma@49000000 {
> >>           compatible = "ti,edma3";
> >>           ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";    <==========
> >>           reg =   <0x49000000 0x10000>,
> >>                   <0x44e10f90 0x40>;
> >>           interrupts = <12 13 14>;
> >>           #dma-cells = <1>;
> >>   };
> >>
> >> The patch description says the device should be split into more devices instead
> >> of specifying several ti,hwmods entries, but unfortunately the Documentation
> >> still suggests the above format in Documentation/devicetree/bindings/dma/ti-edma.txt.
> >>
> >> How would a correct entry look like?
> > 
> > Each tptc instance has it's own sysconfig register. This means each
> > one of them can be clocked and idled independently. They should be
> > treated as separate device instances. I believe the interrupts all
> > belong to the tpcc, which should be also treated as a separate
> > device instance.
> > 
> > In order to get rid of the ti,hwmods property, we want to have a
> > 1-1-1 mapping of the compatible property, ti,hwmod property, and
> > the device entry.
> > 
> > Looking at the TRM "Table 2-1. L3 Memory Map", these all are on
> > the L3, so they should be like this for now (assuming the
> > interrupts all belong to tpcc):
> > 
> > ocp {
> > 	...
> > 
> > 	edma: tpcc@49000000 {
> > 		compatible = "ti,edma3";
> > 		ti,hwmods = "tpcc"; 
> > 		reg = <0x49000000 0x10000>;
> > 		interrupts = <12 13 14>;
> > 		#dma-cells = <1>;
> > 	};
> > 
> > 	tptc0: tptc@49800000 {
> > 		compatible = "ti,tptc3";
> > 		ti,hwmods = "tptc0";
> > 		reg = <0x49800000 0x10000>;
> > 	};
> > 
> > 	tptc1: tptc@49900000 {
> > 		compatible = "ti,tptc3";
> > 		ti,hwmods = "tptc1";
> > 		reg = <0x49900000 0x10000>;
> > 	};
> > 
> > 	tptc2: tptc@49a00000 {
> > 		compatible = "ti,tptc3";
> > 		ti,hwmods = "tptc2";
> > 		reg = <0x49a00000 0x10000>;
> > 	};
> > 	...
> > };
> 
> It is not that simple ;)
> eDMA consists of Channel Controller(s) and Transfer Controllers. In AM335x we
> have 1 CC and 3 TC. TC is mostly a box for us, we do not need to configure
> anything within so the eDMA driver stack just does that: do not touch anything
> TC related in TC address space, we only deal with the CC.
> But in order to be able to move data around we need both CC and the TCs
> enabled and this is why we have the multiple hwmod. with pm_runtime we manage
> both CC and TCs at the same time.
> But from the SW point of view the TC does not really exists. As I said we only
> touch CC registers, paRAM entries.

There's probably a real reason for each TC to have their own clkctrl
register. Do you have any info on how they are split?
 
> And yes, both TC and CCs can generate interrupts.

Do the TCs have a shared interrupt that could be handled by
each TC instance?
 
> So it is not straight forward to separate the TC from the CC driver (edma3).

It seems pm runtime for these four separate modules needs to be
done at the CC driver level if it can't be done separately for
each instance.

Regards,

Tony
