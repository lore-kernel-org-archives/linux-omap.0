From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Fri, 18 Feb 2011 17:50:50 +0100
Message-ID: <4D5EA36A.4000903@ti.com>
References: <20110217162000.GP20795@atomide.com> <20110217162209.GA13425@legolas.emea.dhcp.ti.com> <20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com> <20110217171747.GC14574@legolas.emea.dhcp.ti.com> <4D5D59E5.6020307@ti.com> <20110217173711.GF14574@legolas.emea.dhcp.ti.com> <4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com> <4D5E7DFF.7020609@ti.com> <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100Ab1BRQu7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 11:50:59 -0500
In-Reply-To: <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

On 2/18/2011 4:41 PM, Balbi, Felipe wrote:
> Hi all,
>
> On Fri, Feb 18, 2011 at 03:11:11PM +0100, Cousson, Benoit wrote:
>> On 2/17/2011 7:18 PM, Tony Lindgren wrote:
>>> * Cousson, Benoit<b-cousson@ti.com>   [110217 09:45]:
>>>>
>>>> Done, boot tested, and that does remove the warning about the
>>>> missing opt clock you had with the previous data.
>>>>
>>>> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
>>>>
>>>> Just let me know if it does break anything else.
>>>
>>> Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
>>> and devel-mcspi branches.
>>
>> McSPI OMAP4 hwmod data are missing a couple of flags that break the boot for the moment.
>>
>> Govindraj should rebase on the omap4_hwmod_data branch and add the missing rev and dev_attr for the McSPI.
>>
>> Unfortunately, even with that patch omap-for-linus boot hangs after the following trace:
>>
>> [    0.875091] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
>> [    0.886657] usbcore: registered new interface driver usbfs
>> [    0.892822] usbcore: registered new interface driver hub
>> [    0.898681] usbcore: registered new device driver usb
>> [    0.904815] omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz
>
> I tested your branch merged with mine and it was working fine. What else
> is on omap-for-linus ? There are only 28 patches on that branch, a
> bisect would be quick ?

This patch is at least fixing the McSPI crash. I still don't have a clue 
about the final hang :-(

Benoit

---
 From b2190f0d339c9d843eb5e370d0db8b7090fbcfab Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 18 Feb 2011 14:01:06 +0100
Subject: [PATCH] OMAP4: hwmod data: Add rev and dev_attr fields in McSPI

- Add a rev attribute to identify various McSPI IP version.
- Add a dev_attr structure to provide the number of chipselect
   supported by the instance.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 
++++++++++++++++++++++++++
  1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 84e795c..182aa79 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,7 @@
  #include <plat/cpu.h>
  #include <plat/gpio.h>
  #include <plat/dma.h>
+#include <plat/mcspi.h>

  #include "omap_hwmod_common_data.h"

@@ -3114,6 +3115,7 @@ static struct omap_hwmod_class_sysconfig 
omap44xx_mcspi_sysc = {
  static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
  	.name	= "mcspi",
  	.sysc	= &omap44xx_mcspi_sysc,
+	.rev	= OMAP4_MCSPI_REV,
  };

  /* mcspi1 */
@@ -3156,6 +3158,11 @@ static struct omap_hwmod_ocp_if 
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
@@ -3169,6 +3176,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi1_dev_attr,
  	.slaves		= omap44xx_mcspi1_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -3210,6 +3218,11 @@ static struct omap_hwmod_ocp_if 
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
@@ -3223,6 +3236,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi2_dev_attr,
  	.slaves		= omap44xx_mcspi2_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -3264,6 +3278,11 @@ static struct omap_hwmod_ocp_if 
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
@@ -3277,6 +3296,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi3_dev_attr,
  	.slaves		= omap44xx_mcspi3_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -3316,6 +3336,11 @@ static struct omap_hwmod_ocp_if 
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
@@ -3329,6 +3354,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mcspi4_dev_attr,
  	.slaves		= omap44xx_mcspi4_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4


