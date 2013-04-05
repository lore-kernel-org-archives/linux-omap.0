From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4+: Correct L3 interrupts
Date: Fri, 5 Apr 2013 10:22:18 +0200
Message-ID: <515E89BA.9010709@ti.com>
References: <1365098790-9078-1-git-send-email-jon-hunter@ti.com> <515E6EAE.9000107@ti.com> <515E8677.40404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38203 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3DEIW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Apr 2013 04:22:27 -0400
In-Reply-To: <515E8677.40404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Santosh and Jon,

On 04/05/2013 10:08 AM, Benoit Cousson wrote:
> On 04/05/2013 08:26 AM, Santosh Shilimkar wrote:
>> On Thursday 04 April 2013 11:36 PM, Jon Hunter wrote:
>>> The L3 interrupt numbers are incorrect for OMAP4+ and are conflicting
>>> with some of the timer interrupts causing the allocation of timer
>>> interrupts to fail.
>>>
>>> The problem is caused by adding 32 to the interrupt number for the L3
>>> interrupts to account for per processor interrupts (PPI) and software
>>> generated interrupts (SGI) which typically are mapped to the first 32
>>> interrupts in the ARM GIC. This is not necessary because the first
>>> parameter of the ARM GIC interrupt property specifies the GIC interrupt
>>> type (ie. SGI, PPI, etc). Hence, fix the interrupt number fo the L3
>>> interrupts by substracting 32.
>>>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>
>>> Please note that this problem is observed in Benoit's for_3.10/dts branch [1].
>>>
>>> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>>>
>> Thats correct. I overlooked the 32 addition part. This patch should
>> also be pulled into Benoit's 3.10 tree.
> 
> Done. I've just applied it. But I will probably merge it with the
> original patch, because having a broken patch and the fix in the same
> pull request does not look right.

Please find below the fixed version.

Regards,
Benoit


>From 90c2d172ef86d6c3283df43358d4425f9016be48 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 26 Feb 2013 17:36:14 +0530
Subject: [PATCH] ARM: dts: OMAP4/5: Update l3-noc DT nodes

Add l3-noc node for OMAP4 and OMAP5 devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[jon-hunter@ti.com: Fix the problem caused by adding 32 to the interrupt
number for the L3 interrupts to account for per processor interrupts (PPI)
and software generated interrupts (SGI) which typically are mapped to the
first 32 interrupts in the ARM GIC. This is not necessary because the first
parameter of the ARM GIC interrupt property specifies the GIC interrupt
type (ie. SGI, PPI, etc). Hence, fix the interrupt number for the L3
interrupts by substracting 32]
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
---
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 arch/arm/boot/dts/omap5.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index ddfc54a..3ae6a3f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -94,6 +94,11 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+		reg = <0x44000000 0x1000>,
+		      <0x44800000 0x2000>,
+		      <0x45000000 0x1000>;
+		interrupts = <0 9 0x4>,
+			     <0 10 0x4>;
 
 		counter32k: counter@4a304000 {
 			compatible = "ti,omap-counter32k";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e539258..94b5ec9 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -87,6 +87,11 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+		reg = <0x44000000 0x2000>,
+		      <0x44800000 0x3000>,
+		      <0x45000000 0x4000>;
+		interrupts = <0 9 0x4>,
+			     <0 10 0x4>;
 
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
-- 
1.7.0.4


