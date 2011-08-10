From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 11/14] dt: omap3: add soc file for handling i2c
 controllers
Date: Wed, 10 Aug 2011 22:27:45 +0530
Message-ID: <20110810165745.GB2705@manju-desktop>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-12-git-send-email-manjugk@ti.com>
 <4E427B62.1000907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33001 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709Ab1HJQ57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 12:57:59 -0400
Received: by mail-pz0-f47.google.com with SMTP id 2so2944809pzk.34
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 09:57:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E427B62.1000907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On Wed, Aug 10, 2011 at 02:36:50PM +0200, Cousson, Benoit wrote:
> On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> >
> >Add omap3 soc file for handling omap3 soc i2c controllers existing
> >on l4-core bus.
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >---
> >  arch/arm/boot/dts/omap3-soc.dtsi |   62 ++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 62 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
> >
> >diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> >new file mode 100644
> >index 0000000..85de92f
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/omap3-soc.dtsi
> >@@ -0,0 +1,62 @@
> >+/*
> >+ * Device Tree Source for OMAP3 SoC
> >+ *
> >+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >+ *
> >+ * This file is licensed under the terms of the GNU General Public License
> >+ * version 2.  This program is licensed "as is" without any warranty of any
> >+ * kind, whether express or implied.
> >+ */
> >+
> >+/dts-v1/;
> >+/include/ "skeleton.dtsi"
> >+
> >+/ {
> >+	#address-cells =<1>;
> >+	#size-cells =<1>;
> >+	model = "ti,omap3";
> >+
> >+	aliases {
> >+		i2c1 =&i2c1;
> >+		i2c2 =&i2c2;
> >+		i2c3 =&i2c3;
> >+	};
> >+
> >+	l4-core {
> 
> That comment is probably subject to discussion, but even if this
> interconnect is there physically, I'm not sure of the added value to
> add it.
> It will add an extra level of indentation and that all. Moreover, it
> will mess up the physical address that are expressed using absolute
> value in the TRM with a less readable offset value.
> In fact, most DTS files in the ARM directory are using a purely flat
> representation of the interconnect.
This is as per alignment with Tony and Grant:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/60391

> 
> >+		compatible = "ti,omap3-l4-core";
> 
> Assuming we will keep that, you should probably add a more generic
> compatible name after that one. Like "ti,s3220" or even
> "sonics,s3220", assuming that this IP is generic enough for other
> SoC.
will check this. I don't remember any generic names.
> 
> >+		#address-cells =<1>;
> >+		#size-cells =<1>;
> >+		ranges =<0 0x48000000 0x1000000>;
> >+
> >+		i2c1: i2c@70000 {
> >+			#address-cells =<1>;
> >+			#size-cells =<0>;
> >+			compatible = "ti,omap3-i2c";
> 
> The I2C IP and thus the driver is generic across OMAP generations
> and is even potentially used by other non-OMAP TI chips like DSP or
> Davinci. So having an extra compatible entry with "ti,i2c" or "ti,
> omap-i2c" seems mandatory.
This can be updated as and when new soc/board adaptations are done. 
As of now, it is omap3 and when we have omap4 it will be appended with
"ti,omap4-i2c" etc

-M
