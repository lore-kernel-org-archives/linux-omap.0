From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed .atag_offset
 for DT_MACHINE
Date: Thu, 16 Feb 2012 12:00:34 +0100
Message-ID: <4F3CE1D2.5010202@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com> <20120214195249.GS1426@atomide.com> <4F3BAFCD.2000508@ti.com> <20120215181313.GY1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54379 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab2BPLAm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 06:00:42 -0500
In-Reply-To: <20120215181313.GY1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2/15/2012 7:13 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [120215 04:43]:
>> On 2/14/2012 8:52 PM, Tony Lindgren wrote:
>>> * Benoit Cousson<b-cousson@ti.com>   [120213 07:59]:
>>>> Some .atag_offset entries were wrongly added during a merge conflict
>>>> resolution in 3.3.
>>>> Remove them all, since DT boot does not use that attribute anymore.
>>>>
>>>> Replace as well the #if... by #ifdef for consistency.
>>>
>>> How about let's also remove the 0x from the serial@0x.. in the .dts
>>> files in this clean-up patch?
>>
>> In the same patch?
>>
>> I'm fine with fixing that as well, but since this is not in the same
>> file / directory, I'd rather do a different patch.
>>
>> I'll do the fix anyway, it is up to you for the proper location.
> 
> OK separate patch is fine with me.

Please find the patch below, I'll include it in the branch for the pull request.

Thanks,
Benoit


---
>From edc05cc7396228f21d169dd34f1871464f0a00b8 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 16 Feb 2012 11:55:27 +0100
Subject: [PATCH] arm/dts: OMAP3&4: Remove the '0x' prefix for serial nodes

Follow the DTS convention and thus name the nodes <name>@<address> without
any '0x' prefix in the physical address.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |    8 ++++----
 arch/arm/boot/dts/omap4.dtsi |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 216c331..1c9d10a 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -67,25 +67,25 @@
 			#interrupt-cells = <1>;
 		};
 
-		uart1: serial@0x4806a000 {
+		uart1: serial@4806a000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
-		uart2: serial@0x4806c000 {
+		uart2: serial@4806c000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
-		uart3: serial@0x49020000 {
+		uart3: serial@49020000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
-		uart4: serial@0x49042000 {
+		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..f40af04 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,25 +104,25 @@
 			      <0x48240100 0x0100>;
 		};
 
-		uart1: serial@0x4806a000 {
+		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
-		uart2: serial@0x4806c000 {
+		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
-		uart3: serial@0x48020000 {
+		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
-		uart4: serial@0x4806e000 {
+		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
-- 
1.7.0.4


