From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Tue, 21 Aug 2012 15:11:51 +0530
Message-ID: <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com> <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:51079 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755087Ab2HUJmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 05:42:13 -0400
Received: by iabz21 with SMTP id z21so3574413iab.3
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 02:42:12 -0700 (PDT)
In-Reply-To: <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

On Mon, Aug 20, 2012 at 9:21 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Mon, Aug 20, 2012 at 7:21 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Hi Santosh,
>>
>> On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
>>> This provides PL310 Level 2 Cache Controller Device Tree
>>> support for OMAP4 based devices.
>>>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
>>>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>> index 6717c71..cf1efb6 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -36,6 +36,13 @@
>>>               };
>>>       };
>>>
>>
>>> +     L2: l2-cache-controller {
>>
>> The reg offset is missing: l2-cache-controller@48242000
>>
>>> +             compatible = "arm,pl310-cache";
>>> +             reg = <0x48242000 0x1000>;
>>> +             cache-unified;
>>> +             cache-level = <2>;
>>> +     };
>>> +
>>
>> In theory, the L2 cache should be referenced from the CPUs.
>>
> Agree.
>
I have added the reference for the L2 controller in CPUs.
Other information like L1 cache size etc can be added in cpu
DT node with another patch.

Updated patch below. Have also updated git branch
accordingly.

Regards
Santosh

>From 91d6cb4f999061c8cfc844a3916ee3384f2e488a Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 4 Jul 2012 17:57:34 +0530
Subject: [PATCH 1/2 v2] ARM: OMAP4: Add L2 Cache Controller in Device Tree

This provides PL310 Level 2 Cache Controller Device Tree
support for OMAP4 based devices.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi       |    9 +++++++++
 arch/arm/mach-omap2/omap4-common.c |    6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 6717c71..0229dd2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -30,12 +30,21 @@
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 		};
 	};

+	L2: l2-cache-controller@48242000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x48242000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/mach-omap2/omap4-common.c
b/arch/arm/mach-omap2/omap4-common.c
index c29dee9..6f95992 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
+#include <linux/of.h>

 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -171,7 +172,10 @@ static int __init omap_l2_cache_init(void)
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);

-	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+	if (of_have_populated_dt())
+		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
+	else
+		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);

 	/*
 	 * Override default outer_cache.disable with a OMAP4
-- 
1.7.9.5
