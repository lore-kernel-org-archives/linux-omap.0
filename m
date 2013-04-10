From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Wed, 10 Apr 2013 15:43:00 -0500
Message-ID: <5165CED4.1040800@ti.com>
References: <20130409212318.GR10155@atomide.com> <5165A1DB.3020404@ti.com> <20130410182034.GH10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42075 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935833Ab3DJUnC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 16:43:02 -0400
In-Reply-To: <20130410182034.GH10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>


On 04/10/2013 01:20 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130410 10:35]:
>> Hi Tony,
>>
>> On 04/09/2013 04:23 PM, Tony Lindgren wrote:
>>> Hi Jon,
>>>
>>> Looks like at least 4430sdp nfsroot got broken with commit
>>> ff5c9059 (ARM: dts: OMAP3+: Correct gpio #interrupts-cells
>>> property).
>>
>> Thanks for reporting. I am actually amazed that ethernet is 
>> working on any OMAP board (with device-tree) that requires a
>> gpio as an interrupt because we have still not come to an
>> agreement on [1]. Looking at the OMAP4 SDP I believe this is
>> working by luck because there are other gpios in the same
>> bank that are active and so the bank is enabled. If that were
>> not the case then this would not work. 
>>
>> Hence, I have not been testing ethernet when booting with 
>> device-tree because we need to fix [1] which has been really
>> crippling my testing. So this needs to be resolved so ethernet
>> can work consistently on all omap boards.
> 
> Cool.
>   
>>> Do we need to pass the GPIO edge/level info now?
>>
>> Yes and here is a patch. I have tested on my OMAP4 SDP this
>> morning. Reviewing all the OMAP/AM dts(i) files I believe
>> that only the SDP and OMAP4-VAR-SOM are impacted by this. I
>> don't see any other boards currently using the gpio as an 
>> interrupt-controller.
> 
> Great. Just one comment: You might be able to already use
> the DT preprocessor now easily with linux next for the edge
> info.

Good idea. We could do something like the below, but it would
be better to include the "arm-gic.h" from the omap4.dtsi file
so that the definitions can be used there too. The problem is
that if I include "arm-gic.h" in the omap4.dtsi file I get a
DTC compiler error because of the "#include" statement. It
appears that the compiler does not like it if a file includes
a file using "/include/" and the file it is including uses
"#include". So really I think that we need to switch all the
dts/dtsi files to use "#include" first.

Jon

>From fe74fee9ac4d011703918557f7b9b638bfead300 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Wed, 10 Apr 2013 11:44:44 -0500
Subject: [PATCH] ARM: dts: OMAP4: Fix ethernet IRQ for OMAP4 boards

Commit ff5c9059 (ARM: dts: OMAP3+: Correct gpio #interrupts-cells
property) updated the number of interrupt cells required for configuring
gpios as interrupts for other devices (such as ethernet controllers).
This update allowed the interrupt type (edge, level, etc) to be
configured via device-tree (as described in the
Documentation/devicetree/bindings/gpio/gpio-omap.txt).

This broke ethernet support on the OMAP4 SDP board that defines a gpio
as the ethernet IRQ because the interrupt type (level, edge, etc) was
not getting configured correctly. This board use the ks8851 ethernet
chip which has an active low interrupt. Fix this by defining the gpio
interrupt as active-low in the device-tree binding.

Please note that the OMAP4-VAR-SOM also uses the same ethernet
controller and it is expected it will have the same problem. So the
same fix is also applied to this board.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts     |    3 ++-
 arch/arm/boot/dts/omap4-var-som.dts |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index c387bdc..5d0c925 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -9,6 +9,7 @@
 
 /include/ "omap443x.dtsi"
 /include/ "elpida_ecb240abacn.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	model = "TI OMAP4 SDP board";
@@ -363,7 +364,7 @@
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <2>; /* gpio line 34 */
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>; /* gpio line 34 */
 		vdd-supply = <&vdd_eth>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index 222a413..ade7d46 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap443x.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	model = "Variscite OMAP4 SOM";
@@ -68,7 +69,7 @@
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <11>; /* gpio line 171 */
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* gpio line 171 */
 		vdd-supply = <&vdd_eth>;
 	};
 };
-- 
1.7.10.4

