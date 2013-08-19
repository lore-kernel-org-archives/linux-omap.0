From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 7/8] ARM: dts: omap4: update omap-control-usb nodes
Date: Mon, 19 Aug 2013 10:24:58 +0300
Message-ID: <5211C84A.5040000@ti.com>
References: <1376658571-20992-1-git-send-email-rogerq@ti.com> <1376658571-20992-8-git-send-email-rogerq@ti.com> <520E379B.4090108@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39814 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab3HSHZr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 03:25:47 -0400
In-Reply-To: <520E379B.4090108@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: balbi@ti.com, tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Benoit,

On 08/16/2013 05:30 PM, Benoit Cousson wrote:
> Hi Roger,
> 
> Sorry I missed something in the previous revision :-(

no problem :)
> 
> On 16/08/2013 15:09, Roger Quadros wrote:
>> Split otghs_ctrl and USB2 PHY power down into separate
>> omap-control-usb nodes. Get rid of "ti,type" property.
> 
> You should add that you update the usb_otg_hs node accordingly as well.

OK.
> 
>> CC: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
>>   1 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 22d9f2b..a77dd0a 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -519,7 +519,7 @@
>>               usb2_phy: usb2phy@4a0ad080 {
>>                   compatible = "ti,omap-usb2";
>>                   reg = <0x4a0ad080 0x58>;
>> -                ctrl-module = <&omap_control_usb>;
>> +                ctrl-module = <&omap_control_usb2phy>;
>>               };
>>           };
>>
>> @@ -643,12 +643,16 @@
>>               };
>>           };
>>
>> -        omap_control_usb: omap-control-usb@4a002300 {
>> -            compatible = "ti,omap-control-usb";
>> -            reg = <0x4a002300 0x4>,
>> -                  <0x4a00233c 0x4>;
>> -            reg-names = "control_dev_conf", "otghs_control";
>> -            ti,type = <1>;
>> +        omap_control_usb2phy: omap-control-usb@4a002300 {
>> +            compatible = "ti,usb2-control-usb";
>> +            reg = <0x4a002300 0x4>;
>> +            reg-names = "power";
>> +        };
>> +
>> +        omap_control_usbotg: omap-control-usb@4a00233c {
>> +            compatible = "ti,omap4-control-usb";
>> +            reg = <0x4a00233c 0x4>;
>> +            reg-names = "otghs_control";
>>           };
>>
>>           usb_otg_hs: usb_otg_hs@4a0ab000 {
>> @@ -661,7 +665,7 @@
>>               multipoint = <1>;
>>               num-eps = <16>;
>>               ram-bits = <12>;
>> -            ti,has-mailbox;
>> +            ctrl-module = <&omap_control_usbotg>;
> 
> In omap-usb.txt, ti,has-mailbox is still marked as mandatory whereas the ctrl-module is optional.
> 
> You should update the usb-otg-hs bindings as well.

Right, I removed it from the binding information, but missed the example.

> 
> BTW, why is that property not prefixed with "ti,"? Is ctrl-module really meaningful for other arch?

The ctrl-module thing is TI specific, but otg_hs is used by other platforms, maybe that's why
the "ti," prefix was used.

cheers,
-roger
