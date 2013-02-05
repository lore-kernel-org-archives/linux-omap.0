From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Tue, 5 Feb 2013 10:54:38 +0200
Message-ID: <5110C8CE.2020606@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-11-git-send-email-rogerq@ti.com> <5110A5B8.3030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48800 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab3BEIyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 03:54:51 -0500
In-Reply-To: <5110A5B8.3030803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On 02/05/2013 08:24 AM, kishon wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> Adds device nodes for HS USB Host module, TLL module,
>> OHCI and EHCI controllers.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>>   1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 739bb79..3429280 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -529,5 +529,35 @@
>>               ti,hwmods = "timer11";
>>               ti,timer-pwm;
>>           };
>> +
>> +        usbhstll: usbhstll@0x4a062000 {
>> +            compatible = "ti,usbhs-tll";
>> +            reg = <0x4a062000 0x1000>;
>> +            interrupts = <0 78 0x4>;
>> +            ti,hwmods = "usb_tll_hs";
>> +        };
>> +
>> +        usbhshost: usbhshost@0x4a064000 {
>> +            compatible = "ti,usbhs-host";
>> +            reg = <0x4a064000 0x800>;
>> +            ti,hwmods = "usb_host_hs";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            usbhsohci: ohci@0x4a064800 {
>> +                compatible = "ti,omap3-ohci", "usb-ohci";
>> +                reg = <0x4a064800 0x400>;
>> +                interrupt-parent = <&gic>;
> 
> Just curious.. Were you facing issues if you are not having interrupt-parent here? It's also missing in your dt node usbhstll.

Yes I was. Interrupt-parent is not there in any of the children which are at the same level as usbhstll.

cheers,
-roger
