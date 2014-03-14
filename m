From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 09:10:02 +0000
Message-ID: <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
 <1394701109-6721-5-git-send-email-sathyap@ti.com>
 <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
 <5321F77E.9000302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44428 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843AbaCNJKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 05:10:35 -0400
Content-Disposition: inline
In-Reply-To: <5321F77E.9000302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Mar 13, 2014 at 06:22:54PM +0000, Tomi Valkeinen wrote:
> On 13/03/14 19:46, Mark Rutland wrote:
> > On Thu, Mar 13, 2014 at 08:58:29AM +0000, Sathya Prakash M R wrote:
> >> Add device node for DSS module for AM4372. Both the
> >> AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
> >> The lcd timings are added in respective dts files.
> >> Adds display pinctrl and enables required gpio.
> >> Also set the right parent clock to the DSS clock.
> >>
> >> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> >> ---
> >>  arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
> >>  arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
> >>  4 files changed, 180 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> >> index ea55a4e..b72a7df 100644
> >> --- a/arch/arm/boot/dts/am4372.dtsi
> >> +++ b/arch/arm/boot/dts/am4372.dtsi
> >> @@ -684,6 +684,34 @@
> >>  			num-cs = <4>;
> >>                          status = "disabled";
> >>                  };
> >> +
> >> +		dss: dss@4832A000 {
> >> +			compatible = "ti,omap3-dss", "simple-bus";
> > 
> > This doesn't look right to me. I'm not sure it makes sense for
> > "simple-bus" to be in the compatible list.
> > 
> > Are the child nodes usable in isolation, or are they dependent on the
> > "ti,omap3-dss" node? What exactly does the "ti,omap3-dss" node
> > represent?
> 
> The child nodes are dependent on the dss node.

Ok. Then simple-bus is not appropriate, as the dss node cannot be
ignored for the children to function.

> 
> The "ti,omap3-dss" represents the dss_core block of the OMAP display
> subsystem. The dss_core is a small IP, a wrapper for the submodules,
> handling things like clock and video path routing between the submodules
> and the OMAP's other components (like the PRCM where we get clocks). It
> also handles reset, so when dss_core is reset, all the submodules are reset.
> 
> The HW design is a bit odd, in my opinion, as the submodules are proper
> IP blocks, and as far as I see, they could be designed to be independent
> of each others. But they have not been designed so.
> 
> Having dss_core as the parent node for the submodules gives us automatic
> runtime-pm handling, so when one submodule is enabled, it forces
> dss_core to be enabled first. This makes the reset work right (i.e. we
> don't accidentally reset dss_core when one of the submodules is in use),
> and, as the dss_core is always needed to setup the clock and video path
> routing, it gets properly initialized before any of the submodules will
> use it.
> 
> What "simple-bus" mostly gives us here is automatic creation of the
> platform devices for the submodules. We could also create the devices
> for submodules in the driver of the dss_core. I did have that at some
> point, but the "simple-bus" does identical job, and it seemed to make
> sense to me.

The "simple-bus" compatible string is intended for busses which are
transparent (bar some address remapping expressed via ranges), and is
not intended as an annotation to get Linux to probe child nodes.

Any node with a "simple-bus" entry in the compatible list should either
be handled as a transparent bus, or optionally as the more specific bus
it claims to be (where some hardware configuration may be required
before children can be probed). Unfortunately Linux probes chidlren
regardless, which is arguable a Linux bug.

There's no reason to leak this issue into dts files. Please remove the
"simple-bus" string, and get the dss driver to probe children as
required -- as described above the dss node never makes sense as a
simple-bus.

> 
> Note that the same method is used for omap2/3/4 also, in the patches
> that have been going around for some time in the lists.

And those should be fixed.

Cheers,
Mark.
