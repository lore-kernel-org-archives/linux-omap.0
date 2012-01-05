From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
Date: Thu, 5 Jan 2012 11:09:24 -0700
Message-ID: <20120105180924.GE22653@ponder.secretlab.ca>
References: <1324019153-13316-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A80719AC@DBDE01.ent.ti.com>
 <4F05ABAF.8080702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58182 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab2AESJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 13:09:28 -0500
Received: by yhnn56 with SMTP id n56so260745yhn.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Jan 2012 10:09:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F05ABAF.8080702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 05, 2012 at 02:54:55PM +0100, Cousson, Benoit wrote:
> Hi Vaibhav,
> 
> On 1/5/2012 12:18 PM, Hiremath, Vaibhav wrote:
> >>From: Hiremath, Vaibhav
> >>Sent: Friday, December 16, 2011 12:36 PM
> >>To: linux-omap@vger.kernel.org
> >>Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org; devicetree-
> >>discuss@lists.ozlabs.org; grant.likely@secretlab.ca; Cousson, Benoit;
> >>Hiremath, Vaibhav
> >>Subject: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
> >>
> >>Add OMAP3 EVM (OMAP3530, AM/DM37x) DTS file to use the omap3.dtsi SoC file,
> >>along with memory node information.
> >>
> >>Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
> >>---
> >>Boot tested it on AM/DM37x EVM, kernel parses the info correctly.
> >>
> >>  arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
> >>  1 files changed, 20 insertions(+), 0 deletions(-)
> >>  create mode 100644 arch/arm/boot/dts/omap3-evm.dts
> >>
> >>diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-
> >>evm.dts
> >>new file mode 100644
> >>index 0000000..2eee16e
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/omap3-evm.dts
> >>@@ -0,0 +1,20 @@
> >>+/*
> >>+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ */
> >>+/dts-v1/;
> >>+
> >>+/include/ "omap3.dtsi"
> >>+
> >>+/ {
> >>+	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
> >>+	compatible = "ti,omap3-evm", "ti,omap3";
> >>+
> >>+	memory {
> >>+		device_type = "memory";
> >>+		reg =<0x80000000 0x10000000>; /* 256 MB */
> >>+	};
> >>+};
> >Can this merged? OR anybody has any comments here?
> 
> I guess that with Rob or Grant's ack, Tony should be able to merge it.
> That being said, since it is outside mach-omap, I'm not sure what
> the right path is.
> I can add it in my DTS series, but that one will have dependencies
> with the i2c driver DT adaptation.
> 
> FWIW, Acked-by: Benoit Cousson <b-cousson@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> Regards,
> Benoit
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
