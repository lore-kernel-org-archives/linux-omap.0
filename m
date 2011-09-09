From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 02/10] arm/dts: OMAP4: Add a main ocp entry bound to
 l3-noc driver
Date: Thu, 8 Sep 2011 19:41:25 -0700
Message-ID: <20110909024125.GB6726@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
 <1314191356-10963-3-git-send-email-b-cousson@ti.com>
 <20110908180300.GB2967@ponder.secretlab.ca>
 <4E695960.8010905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65292 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab1IICl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 22:41:27 -0400
Received: by yxp4 with SMTP id 4so1048369yxp.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 19:41:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E695960.8010905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 09, 2011 at 02:10:08AM +0200, Cousson, Benoit wrote:
> On 9/8/2011 8:03 PM, Grant Likely wrote:
> >On Wed, Aug 24, 2011 at 03:09:08PM +0200, Benoit Cousson wrote:
> >>Used the main OCP node to add bindings with the l3_noc driver.
> >>Remove l3_noc static device creation if CONFIG_OF is defined.
> >>
> >>Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>Cc: Tony Lindgren<tony@atomide.com>
> >>Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> >>---
> >>  arch/arm/boot/dts/omap4.dtsi  |    3 ++-
> >>  arch/arm/mach-omap2/devices.c |    2 ++
> >>  2 files changed, 4 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> >>index 97a3ea7..928a74c 100644
> >>--- a/arch/arm/boot/dts/omap4.dtsi
> >>+++ b/arch/arm/boot/dts/omap4.dtsi
> >>@@ -64,10 +64,11 @@
> >>  	 * hierarchy.
> >>  	 */
> >>  	ocp {
> >>-		compatible = "simple-bus";
> >>+		compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
> >>  		#address-cells =<1>;
> >>  		#size-cells =<1>;
> >>  		ranges;
> >>+		hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> >>
> >>  		gic: interrupt-controller@48241000 {
> >>  			compatible = "ti,omap4-gic", "arm,gic";
> >>diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> >>index 2d4a199..5964650 100644
> >>--- a/arch/arm/mach-omap2/devices.c
> >>+++ b/arch/arm/mach-omap2/devices.c
> >>@@ -70,6 +70,7 @@ static int __init omap3_l3_init(void)
> >>  }
> >>  postcore_initcall(omap3_l3_init);
> >>
> >>+#ifndef CONFIG_OF
> >>  static int __init omap4_l3_init(void)
> >>  {
> >>  	int l, i;
> >>@@ -100,6 +101,7 @@ static int __init omap4_l3_init(void)
> >>  	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> >>  }
> >>  postcore_initcall(omap4_l3_init);
> >>+#endif
> >
> >Don't do this.  Turning on CONFIG_OF must not break non-DT booting.
> >Instead, check at runtime if a DT is available, and if it does then
> >don't run the hook.
> 
> Do you want to check only the availability of the DT or the
> availability of that specific node inside the DT?

Up to you.  What makes the most sense?

g.

