From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH RESEND v4 2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
Date: Fri, 31 Aug 2012 17:53:18 +0200
Message-ID: <C1D7B7D4-D576-4256-83F3-09689B4087C3@dominion.thruhere.net>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com> <1346141454-18786-3-git-send-email-anilkumar@ti.com> <20120830203505.GB1303@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38581 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2HaPxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 11:53:20 -0400
Received: by eekc1 with SMTP id c1so1270360eek.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 08:53:19 -0700 (PDT)
In-Reply-To: <20120830203505.GB1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca


Op 30 aug. 2012, om 22:35 heeft Tony Lindgren <tony@atomide.com> het volgende geschreven:

> * AnilKumar Ch <anilkumar@ti.com> [120828 01:11]:
>> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
>> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
>> 
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
>> index a7906cb..58f5042 100644
>> --- a/arch/arm/boot/dts/am335x-bone.dts
>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>> @@ -18,6 +18,20 @@
>> 		reg = <0x80000000 0x10000000>; /* 256 MB */
>> 	};
>> 
>> +	am3358_pinmux: pinmux@44E10800 {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&userled_pins>;
>> +
>> +		userled_pins: pinmux_userled_pins {
>> +			pinctrl-single,pins = <
>> +				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
>> +				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
>> +				0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
>> +				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
>> +			>;
>> +		};
>> +	};
>> +
> 
> Looks like this patch should also claim these pins by the led driver.
> Then the led driver should just do pinctrl_get_select_default(&pdev->dev)
> in it's probe function to set the pins.

FWIW, I've been using this for a while now:

+       leds {
+               compatible = "gpio-leds";
+               heartbeat {
+                       label = "beaglebone::usr0";
+                       gpios = <&gpio2 21 0>;
+                       linux,default-trigger = "heartbeat";
+               };
+
+               mmc {
+                       label = "beaglebone:usr1";
+                       gpios = <&gpio2 22 0>;
+                       linux,default-trigger = "mmc0";
+               };