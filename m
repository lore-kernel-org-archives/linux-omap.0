From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Tue, 17 Mar 2015 17:06:52 -0700
Message-ID: <20150318000652.GJ31346@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
 <20150202160932.GF16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38213 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbbCRALj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 20:11:39 -0400
Content-Disposition: inline
In-Reply-To: <20150202160932.GF16250@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

* Tony Lindgren <tony@atomide.com> [150202 08:15]:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150131 17:54]:
> > I just noticed the dm816x.dtsi says:
> > 
> > ocp {
> >         compatible = "ti,omap3-l3-smx", "simple-bus";
> > 
> > This is incorrect: the DM81xx (and siblings like the AM335x) use
> > Arteris FlexNOC for the L3 interconnect, same as omap4/5 and vayu, not
> > SonicsMX. (In general everything on the DM81xx seems to be
> > omap4-generation)
> 
> Good catch, yes it seems it's mostly omap4. Looks like we
> should also add it for am33xx.dtsi while at it.
> 
> I'll also check the devices one more time if I have some as
> compatible with omap3 instead of omap4.

Hmm this is also broken on am33xx, and the following patch is needed.
And we also need to populate the tables along the lines of 27b7d5f3cc49
("bus: omap_l3_noc: Add AM4372 interconnect error data").

Do the below ranges match your JTAG results? I scanned them in u-boot
using md for the ranges where I found some related data.

That got me wondering if we can actually scan that data based
on the ranges below as target is 00130001 and flagmux 00370001.
We would be missing the names, but that would be still less data
to pile up in the kernel :) If some module is disabled, then it
should never produce errors so it seems safe to scan the data..

Can we dig even more info based on the RX port address at offset
0x10?  That's the L3_TARG_STDHOSTHDR_NTTPADDR_0.

Or got any good ideas for populating the names?

Regards,

Tony

8< ------------------------------
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -105,7 +105,10 @@
 	 * the whole bus hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "ti,am335-l3-noc", "simple-bus";
+		reg = <0x44000000 0x1200
+		       0x44800000 0x1000>;
+		interrupts = <9 10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -58,8 +58,10 @@
 	 * the whole bus hierarchy.
 	 */
 	ocp {
-		compatible = "ti,omap4-l3-noc", "simple-bus";
-		reg = <0x44000000 0x10000>;
+		compatible = "ti,dm816-l3-noc", "simple-bus";
+		reg = <0x44000000 0x1200
+		       0x44400000 0x1200
+		       0x44800000 0x1000>;
 		interrupts = <9 10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
