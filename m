From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
Date: Thu, 17 Feb 2011 12:07:14 +0100
Message-ID: <4D5D0162.6010505@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com> <20110217104207.GB17370@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49713 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab1BQLHW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:07:22 -0500
In-Reply-To: <20110217104207.GB17370@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Lambert, David" <dlambert@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Manjunath,

On 2/17/2011 11:42 AM, G, Manjunath Kondaiah wrote:
> On Thu, Feb 17, 2011 at 11:24:41AM +0100, Benoit Cousson wrote:
>> All,
>>
>> Due to the important number of modifications recently done on the
>> OMAP4 data compared to the original and the total absence of explanation
>> in the changelog, I re-submit the data before the driver series in order
>> to maintain the integrity of the original file and to avoid a huge pain
>> during the merge.
>>
>> Govind, Tarun and Kishon,
>> Please note that I cannot include here the dev_attr or rev field for
>> McSPI, McBSP and timer since it requires some modification in the device
>> header.
>
> McSPI is already merged to l-o master. Will not this series breaks spi
> hwmod?

It will not break, it will just make the merge a little bit painful for 
Tony if we do not re-submit the updated McSPI hwmod data for OMAP4.

Please find below a sample of what the patch should now look like.

BTW, in this case, it will be much better to rename omap2_mcspi_dev_attr 
using the same convention as others: <class_name>_dev_attr -> 
mcspi_dev_attr.

Regards,
Benoit

---
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f108614..fc7fabf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,9 @@
  #include <plat/cpu.h>
  #include <plat/gpio.h>
  #include <plat/dma.h>
+#include <plat/mcspi.h>

  #include "omap_hwmod_common_data.h"

@@ -2497,6 +2508,11 @@ static struct omap_hwmod_ocp_if 
*omap44xx_mcspi1_slaves[] = {
  	&omap44xx_l4_per__mcspi1,
  };

+/* mcspi1 dev_attr */
+static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
+	.num_chipselect	= 4,
+};
+
  static struct omap_hwmod omap44xx_mcspi1_hwmod = {
  	.name		= "mcspi1",
  	.class		= &omap44xx_mcspi_hwmod_class,
@@ -2510,6 +2526,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi1_dev_attr,
  	.slaves		= omap44xx_mcspi1_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2551,6 +2568,11 @@ static struct omap_hwmod_ocp_if 
*omap44xx_mcspi2_slaves[] = {
  	&omap44xx_l4_per__mcspi2,
  };

+/* mcspi2 dev_attr */
+static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
+	.num_chipselect	= 2,
+};
+
  static struct omap_hwmod omap44xx_mcspi2_hwmod = {
  	.name		= "mcspi2",
  	.class		= &omap44xx_mcspi_hwmod_class,
@@ -2564,6 +2586,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi2_dev_attr,
  	.slaves		= omap44xx_mcspi2_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2605,6 +2628,11 @@ static struct omap_hwmod_ocp_if 
*omap44xx_mcspi3_slaves[] = {
  	&omap44xx_l4_per__mcspi3,
  };

+/* mcspi3 dev_attr */
+static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
+	.num_chipselect	= 2,
+};
+
  static struct omap_hwmod omap44xx_mcspi3_hwmod = {
  	.name		= "mcspi3",
  	.class		= &omap44xx_mcspi_hwmod_class,
@@ -2618,6 +2646,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi3_dev_attr,
  	.slaves		= omap44xx_mcspi3_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2657,6 +2686,11 @@ static struct omap_hwmod_ocp_if 
*omap44xx_mcspi4_slaves[] = {
  	&omap44xx_l4_per__mcspi4,
  };

+/* mcspi4 dev_attr */
+static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
+	.num_chipselect	= 1,
+};
+
  static struct omap_hwmod omap44xx_mcspi4_hwmod = {
  	.name		= "mcspi4",
  	.class		= &omap44xx_mcspi_hwmod_class,
@@ -2670,6 +2704,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi4_dev_attr,
  	.slaves		= omap44xx_mcspi4_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
---


