From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Wed, 05 Dec 2012 23:24:26 +0000
Message-ID: <20121205232426.BAD573E0E22@localhost>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com> <1354734571-10774-6-git-send-email-zonque@gmail.com> <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41728 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2LEXYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 18:24:31 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so43470wib.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Dec 2012 15:24:30 -0800 (PST)
In-Reply-To: <50BFCBCC.6030706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: paul@pwsan.com, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, Daniel Mack <zonque@gmail.com>, tony@atomide.com, jacmet@sunsite.dk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Grant,
> 
> On 12/05/2012 04:22 PM, Grant Likely wrote:
> > On Wed,  5 Dec 2012 20:09:31 +0100, Daniel Mack <zonque@gmail.com> wrote:
> >> This patch adds basic DT bindings for OMAP GPMC.
> >>
> >> The actual peripherals are instantiated from child nodes within the GPMC
> >> node, and the only type of device that is currently supported is NAND.
> >>
> >> Code was added to parse the generic GPMC timing parameters and some
> >> documentation with examples on how to use them.
> >>
> >> Successfully tested on an AM33xx board.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  77 ++++++++++
> >>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
> >>  arch/arm/mach-omap2/gpmc.c                         | 171 ++++++++++++++++++++-
> >>  3 files changed, 323 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >> new file mode 100644
> >> index 0000000..7d2a645
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >> @@ -0,0 +1,77 @@
> >> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
> >> +
> >> +The actual devices are instantiated from the child nodes of a GPMC node.
> >> +
> >> +Required properties:
> >> +
> >> + - compatible:		Should be set to "ti,gpmc"
> > 
> > Please, be specific. Use something like "ti,am3340-gpmc" or
> > "ti,omap3430-gpmc". The compatible property is a list so that new
> > devices can claim compatibility with old. Compatible strings that are
> > overly generic are a pet-peave of mine.
> 
> We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
> (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
> implying all omap2+ based devices or should we have a compatible string
> for each device supported?

Are they each register-level compatible with one another?

The general recommended approach here is to make subsequent silicon
claim compatibility with the first compatible implementation.

So, for an am3358 board:
	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";

Essentially, what this means is that "ti,omap2420-gpmc" is the generic
value instead of "omap2-gpmc". The reason for this is so that the value
is anchored against a specific implementation, and not against something
completely imaginary or idealized. If a newer version isn't quite
compatible with the omap2420-gpmc, then it can drop the compatible claim
and the driver really should be told about the new device.

g.



> 
> Thanks
> Jon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
