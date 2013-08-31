From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 1/1] arm: dts: am33xx: correcting dt node unit address
 for usb
Date: Sat, 31 Aug 2013 23:59:22 +0530
Message-ID: <52223602.9060206@ti.com>
References: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com> <52222AEE.2090607@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60447 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab3HaS3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Aug 2013 14:29:43 -0400
In-Reply-To: <52222AEE.2090607@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

On Saturday 31 August 2013 11:12 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 08/30/2013 09:52 PM, Mugunthan V N wrote:
>
>> DT node's unit address should be its own register offset address to
>> make it a
>> unique across the system. This patch corrects the incorrect USB
>> entries with
>> correct register offset for unit address.
>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>>   arch/arm/boot/dts/am33xx.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi
>> b/arch/arm/boot/dts/am33xx.dtsi
>> index f9c5da9..e9b6775 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
> [...]
>> @@ -449,7 +449,7 @@
>>                       "tx14", "tx15";
>>               };
>>
>> -            cppi41dma: dma-controller@07402000 {
>> +            cppi41dma: dma-controller@47402000 {
>
>    Not @47400000? Look at the first entry in the "reg" prop. 
47400000 is already used in USB SS. See below from am33xx.dtsi file

340                 usb: usb@47400000
{                                             
341                         compatible =
"ti,am33xx-usb";                           
342                         reg = <0x47400000
0x1000>;                              
343                         ranges;

Regards
Mugunthan V N
