From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: AM572x-IDK Initial Support
Date: Mon, 28 Mar 2016 11:37:03 -0500
Message-ID: <56F95DAF.1080901@ti.com>
References: <1458858644-13800-1-git-send-email-nm@ti.com>
 <20160325150344.GA1268@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325150344.GA1268@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Schuyler Patton <spatton@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/25/2016 10:03 AM, Rob Herring wrote:
> On Thu, Mar 24, 2016 at 05:30:44PM -0500, Nishanth Menon wrote:
>> From: Schuyler Patton <spatton@ti.com>
[...]

>> +- AM5728 IDK
>> +  compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> 
> Okay, but I think the TI folks have gone a bit crazy with all these 
> compatible strings...
> 

Sadly yes :( too many paper spins and trying to maintain requirements
of exact match than wild cards is starting to look crazier over time :(

>> diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
>> new file mode 100644
>> index 000000000000..bb51f6de7b45
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am572x-idk.dts
>> @@ -0,0 +1,85 @@
[...]

>> +	leds {
>> +		compatible = "gpio-leds";
>> +		led@0 {
> 
> Unit-address without reg is going to start warning in dtc. Use something 
> like "cpu0-led" instead.
> 
Fixed. Thanks. Updated version posted
https://patchwork.kernel.org/patch/8679861/

-- 
Regards,
Nishanth Menon
