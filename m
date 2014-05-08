From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
Date: Thu, 8 May 2014 15:37:00 -0500
Message-ID: <20140508203659.GA5620@kahuna>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
 <1399299527-10955-4-git-send-email-r.sricharan@ti.com>
 <536BD9D8.4080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755598AbaEHUhZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 16:37:25 -0400
Content-Disposition: inline
In-Reply-To: <536BD9D8.4080905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, santosh.shilimkar@ti.com

On 14:24-20140508, Joel Fernandes wrote:
> On 05/05/2014 09:18 AM, Sricharan R wrote:
> > From: Nishanth Menon <nm@ti.com>
> > 
> > When, in the system due to varied reasons, interrupts might be unusable
> > due to hardware behavior, but register maps do exist, then those interrupts
> > should be skipped while mapping irq to crossbars.
> > 
> 
> Just wondering, instead of hardcoding this data in the code, and
> introducing additional flags (IRQ_SKIP), why not just put these GIC IRQs
> in the ti,irq-reserved property in DTS for platforms where such IRQs are
> not usable. That way you're skipping these IRQs anyway.
> 
> Also that would avoid adding more hard coded data for future SoCs into
> the source for such IRQs that must be skipped, and also reduces LOC.
> 

Good question - lets try to explain the hardware a little here ->
obviously a driver that cannot use the hardware is useless compared to
reducing LOC count ;).. and apologies about the long reply..

Basic understanding:
GIC has 160 SPIs and number of hardware block interrupt sources is around or
more than 400. So, in comes crossbar - which is basically a mapper by
allowing us to select an hardware block interrupt source (identified as
crossbar_number or cb_no in code). So all we have to do is to write to a
register in crossbar corresponding to GIC and viola, we now routed the
interrupt source to a GIC interrupt of our choice. At least the
Specification reads so.... until you drill down to the details.

A) You have 160 SPI GIC, and 152 crossbar registers. So, you have 8 GIC SPI
interrupts that are hardwired. the reserved mapping basically marks
these to indicate that we dont have registers. Example: 0 1 2 3 5
6 131 and 132
	- Limitation today - if you want to use PMU for CPU0, SPI
	interrupt is 131, then if you define, in dts:
	interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>
	driver assumes it is crossbar number 131(reserved), Similarly:
	GIC CS_CTI_MPU_C0_IRQ (SPI 1) is ELM_IRQ (crossbar 1)
	GIC CS_CTI_MPU_C1_IRQ (SPI 2) is EXT_SYS_IRQ_1 (crossbar 2)
	GIC MPU_CLUSTER_IRQ_AXIERR (SPI 3) is reserved (crossbar 3)
	GIC WD_TIMER_MPU_C0_IRQ_WARN (SPI 5) is L3_MAIN_IRQ_APP_ERR (crossbar 5)
	GIC WD_TIMER_MPU_C1_IRQ_WARN (SPI 6) is PRM_IRQ_MPU (crossbar 6)
	GIC MPU_CLUSTER_IRQ_PMU_C0 (SPI 131) is reserved (crossbar 131)
	GIC MPU_CLUSTER_IRQ_PMU_C1 (SPI 132) is reserved (crossbar 132)

	As of today, we cannot differentiate in DTS if it is one of
	these "direct map" interrupts we are requesting or crossbar
	number we are requesting.

B) among the 152 cross bar registers, you have three sets:
B.1) The ones like Crossbar register 1 which maps to SPI4 - no problem -
     you write the crossbar number you want to map, bingo, job done.
     - The driver works brilliantly here. and this is true for 148 GIC
     SPIs.
B.2) The ones like 10 139 140 - these are interesting, because we have
     crossbar registers corresponding to these, However writing anything
     to them has no impact - at least 10 is confirmed to have been
     hardwired to L3_APP_IRQ (but not documented), we are trying to get
     explanations for 139 and 140. - but there is strong indication
     based on testing performed that the registers are NOPs and GIC is
     hardwired in.

     I had originally discovered 10, but only a day or so back did we
     understand what is going on, others we dont know yet.
B.3) 133 is a variation to B.2 - There is an magical efuse register
    which controls if the GIC is hardwired or not. when the efuse bit is
    0, it behaves like B.1(program and it works), but almost all silicon
    have it set to "hardwired mode" :(

The following you wont find in any TRM, and is based on tests performed
during the last few days - primarily meant to illustrate this.

                      MPU Crossbar                  
                      152 registers                 
   +-------+         +------+                       
   |       |    +----+C1    |                       
   | PPI.. |    |    +------+                       
   | 0..32 |    | <--+C2    |                       
   |       |    |    +------+     +------------+    
   +-------+    | +--+C5    |     |            +---+
   |  SPI1 |    | |  +------+   <-+ L3 APP IRQ |   |
   |       |    | |  |      |     ++-------+---+   |
   +-------+    | |  |      |      +-------+       |
   |  SPI3 |    | |  +------+      | CPU0  |       |
   |       |    | |  |      |      | PMU   +----+  |
   +-------+    | |  +------+      +-------+    |  |
   | SPI4  | <--+ |  |      |                   |  |
   |       |      |  |      |                   |  |
   +-------+      |  |      |    +---------+    |  |
   | SPI10 | <----+  |      |    | External|    |  |
+> |       |         |      |    | NMI     |    |  |
|  +-------+         +------+    +-+-----+-++   |  |
|  | SPI131|         |      |      +-----+  |   |  |
|  |       | <+      +------+      | Efuse  |   |  |
|  +-------+  |      |C126  | <--+-----+-+  |   |  |
|  | SPI133| <---+   +------+    +-----+    |   |  |
|  +-------+  |  | +-+C132  |    |CPU0 |    |   |  |
|  | SPI139| <-----+ +------+    |WDT  |    |   |  |
|  +-------+  |  | | +------+    +--+--+    |   |  |
|  | ..... |  |  | |                |       |   |  |
|  +-------+  |  | +----------------+       |   |  |
|  | SPI159|  |  |                          |   |  |
|  +-------+  |  +--------------------------+   |  |
|             |                                 |  |
|    GIC      +---------------------------------+  |
|  160 SPI                                         |
|                                                  |
+--------------------------------------------------+


So, to answer your question - I hope this explains skip and reserved.
Now, we happily can handle case B.1 (148 SPI interrupts) - However,

The reason I requested this series to be blocked is:
a) We dont completely (yet) have explanation about hardware for B.2 139
   and 140.
b) we definitely need to be able to request the interrupts of A, B.2,
   B.3 - and our framework as it stands right now fails.

NOTE:
obviously we claim dra7 compatibility. dra742 and 744 seem similar - but
we dont have confirmation for the same yet. following device tree
maintainer recommendations of having dts compatibility closely match
with SoC behavior. yeah, we could make the driver too generic and move
everything to dts.. but that does not seem to be the way we do things with dt.

-- 
Regards,
Nishanth Menon
