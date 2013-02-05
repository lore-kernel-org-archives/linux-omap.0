From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Tue, 5 Feb 2013 10:57:58 +0200
Message-ID: <5110C996.6020208@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-11-git-send-email-rogerq@ti.com> <20130205074141.GB32118@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3BEI6K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 03:58:10 -0500
In-Reply-To: <20130205074141.GB32118@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, b-cousson@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On 02/05/2013 09:41 AM, Felipe Balbi wrote:
> On Mon, Feb 04, 2013 at 05:58:57PM +0200, Roger Quadros wrote:
>> Adds device nodes for HS USB Host module, TLL module,
>> OHCI and EHCI controllers.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>>  1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 739bb79..3429280 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -529,5 +529,35 @@
>>  			ti,hwmods = "timer11";
>>  			ti,timer-pwm;
>>  		};
>> +
>> +		usbhstll: usbhstll@0x4a062000 {
>> +			compatible = "ti,usbhs-tll";
>> +			reg = <0x4a062000 0x1000>;
>> +			interrupts = <0 78 0x4>;
>> +			ti,hwmods = "usb_tll_hs";
>> +		};
>> +
>> +		usbhshost: usbhshost@0x4a064000 {
>> +			compatible = "ti,usbhs-host";
>> +			reg = <0x4a064000 0x800>;
>> +			ti,hwmods = "usb_host_hs";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			usbhsohci: ohci@0x4a064800 {
> 
> usbhsohci is a bit misleading :-)
> 
> How about we stick to ohci and ehci for these nodes ? :-)
> 
Was just thinking of a unique label that will point to the OHCI/EHCI
controller in the HS USB subsystem. We need the label to provide
PHY information in the board DT.

If we are sure we won't have another OHCI/EHCI controller then I can
just use ehci/ohci.

cheers,
-roger
