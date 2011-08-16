From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 11/14] dt: omap3: add soc file for handling i2c
 controllers
Date: Tue, 16 Aug 2011 12:02:27 +0530
Message-ID: <20110816063227.GA17165@manju-desktop>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-12-git-send-email-manjugk@ti.com>
 <4E427B62.1000907@ti.com>
 <20110810165745.GB2705@manju-desktop>
 <4E42C3C6.1070806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45047 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab1HPGdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 02:33:43 -0400
Received: by mail-gw0-f49.google.com with SMTP id 1so3856757gwb.36
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 23:33:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E42C3C6.1070806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 07:45:42PM +0200, Cousson, Benoit wrote:
> + Tony
> 
> On 8/10/2011 6:57 PM, G, Manjunath Kondaiah wrote:
> >On Wed, Aug 10, 2011 at 02:36:50PM +0200, Cousson, Benoit wrote:
> >>On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> >>>
> >>>Add omap3 soc file for handling omap3 soc i2c controllers existing
> >>>on l4-core bus.
> >>>
> >>>Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >>>---
> >>>  arch/arm/boot/dts/omap3-soc.dtsi |   62 ++++++++++++++++++++++++++++++++++++++
> >>>  1 files changed, 62 insertions(+), 0 deletions(-)
> >>>  create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
> >>>
> >>>diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> >>>new file mode 100644
> >>>index 0000000..85de92f
> >>>--- /dev/null
> >>>+++ b/arch/arm/boot/dts/omap3-soc.dtsi
> >>>@@ -0,0 +1,62 @@
> >>>+/*
> >>>+ * Device Tree Source for OMAP3 SoC
> >>>+ *
> >>>+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >>>+ *
> >>>+ * This file is licensed under the terms of the GNU General Public License
> >>>+ * version 2.  This program is licensed "as is" without any warranty of any
> >>>+ * kind, whether express or implied.
> >>>+ */
> >>>+
> >>>+/dts-v1/;
> >>>+/include/ "skeleton.dtsi"
> >>>+
> >>>+/ {
> >>>+	#address-cells =<1>;
> >>>+	#size-cells =<1>;
> >>>+	model = "ti,omap3";
> >>>+
> >>>+	aliases {
> >>>+		i2c1 =&i2c1;
> >>>+		i2c2 =&i2c2;
> >>>+		i2c3 =&i2c3;
> >>>+	};
> >>>+
> >>>+	l4-core {
> >>
> >>That comment is probably subject to discussion, but even if this
> >>interconnect is there physically, I'm not sure of the added value to
> >>add it.
> >>It will add an extra level of indentation and that all. Moreover, it
> >>will mess up the physical address that are expressed using absolute
> >>value in the TRM with a less readable offset value.
> >>In fact, most DTS files in the ARM directory are using a purely flat
> >>representation of the interconnect.
> >This is as per alignment with Tony and Grant:
> >http://permalink.gmane.org/gmane.linux.ports.arm.omap/60391
> 
> So I'm asking the same question to Grant and Tony then:-)

What is the conclusion here? I will go ahead with current approach since
tony and grant has voted for it.

-M

> 
> >>>+		compatible = "ti,omap3-l4-core";
> >>
> >>Assuming we will keep that, you should probably add a more generic
> >>compatible name after that one. Like "ti,s3220" or even
> >>"sonics,s3220", assuming that this IP is generic enough for other
> >>SoC.
> >will check this. I don't remember any generic names.
> >>
> >>>+		#address-cells =<1>;
> >>>+		#size-cells =<1>;
> >>>+		ranges =<0 0x48000000 0x1000000>;
> >>>+
> >>>+		i2c1: i2c@70000 {
> >>>+			#address-cells =<1>;
> >>>+			#size-cells =<0>;
> >>>+			compatible = "ti,omap3-i2c";
> >>
> >>The I2C IP and thus the driver is generic across OMAP generations
> >>and is even potentially used by other non-OMAP TI chips like DSP or
> >>Davinci. So having an extra compatible entry with "ti,i2c" or "ti,
> >>omap-i2c" seems mandatory.
> >This can be updated as and when new soc/board adaptations are done.
> >As of now, it is omap3 and when we have omap4 it will be appended with
> >"ti,omap4-i2c" etc
> 
> To infinity and beyond?
> 
> There is no need, and we should absolutely not update the driver
> each time we introduce a new SoC version/revision.
> The driver should match with the generic device name in that case.
> Until we change the IP and potentially introduce a new driver.
> 
> BTW, even omap3 should not be in the name in theory. It should be
> potentially "ti,i2c-v3" or whatever HW version the IP is using.
> But for some reason, most devices are using such convention in
> existing DTS:-(
> This is probably due to the lack of well identified IP version in
> most SoC... including OMAP:-)
> 
> 
> Benoit
