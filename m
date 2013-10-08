From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: mark TWL6037 as system-power-controller
Date: Wed, 09 Oct 2013 00:40:10 +0200
Message-ID: <525489CA.10906@baylibre.com>
References: <1379617896-15213-1-git-send-email-nm@ti.com> <52542813.7020208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38370 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab3JHWkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 18:40:14 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so7459634wib.17
        for <linux-omap@vger.kernel.org>; Tue, 08 Oct 2013 15:40:13 -0700 (PDT)
In-Reply-To: <52542813.7020208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nishanth,

On 08/10/2013 17:43, Nishanth Menon wrote:
> On 09/19/2013 02:11 PM, Nishanth Menon wrote:
>> This allows the palmas pm_power_off to kick in on power off command
>> and switch off the board.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Based on: (benoit's for_3.13/dts branch)
>> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
>> This uses the support introduced by:
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b81eec09a484c588ead035003ce7555ca8a9963a
>>
>>   arch/arm/boot/dts/omap5-uevm.dts |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index da25a14..8227386 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -271,6 +271,7 @@
>>   		reg = <0x48>;
>>   		interrupt-controller;
>>   		#interrupt-cells = <2>;
>> +		ti,system-power-controller;
>>
>>   		extcon_usb3: palmas_usb {
>>   			compatible = "ti,palmas-usb-vid";
>>
> Gentle ping.
> patchworks link: https://patchwork.kernel.org/patch/2913111/

I've just applied it and pushed it to my branch.

Thanks,
Benoit

