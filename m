From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH] ARM: dts: omap3-devkit8000: fix NAND memory binding
Date: Tue, 11 Jun 2013 16:53:19 +0200
Message-ID: <51B739DF.6080802@epfl.ch>
References: <1369296697-22495-1-git-send-email-florian.vaussard@epfl.ch> <51A8AA6B.6010608@epfl.ch>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:57284 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751720Ab3FKOxY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:53:24 -0400
In-Reply-To: <51A8AA6B.6010608@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Anil Kumar <anilk4.v@gmail.com>

Hello,

On 05/31/2013 03:49 PM, Florian Vaussard wrote:
> Hello,
>
> Gentle ping. Does someone has any comments on this fix? Can someone
> tests on the real hardware?
>

Nobody has this hardware somewhere in a drawer? :-)

Regards,

Florian

> Regards,
>
> Florian
>
> On 05/23/2013 10:11 AM, Florian Vaussard wrote:
>> Commit d36b4cd 'ARM: OMAP2+: Add additional GPMC timing parameters'
>> updated GPMC binding, but omap3-devkit8000 was not updated accordingly,
>> resulting in a broken configuration.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   arch/arm/boot/dts/omap3-devkit8000.dts |   29
>> +++++++++++++++--------------
>>   1 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts
>> b/arch/arm/boot/dts/omap3-devkit8000.dts
>> index 8a5cdcc..e5b35f5 100644
>> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
>> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
>> @@ -123,20 +123,21 @@
>>           reg = <0 0 0>; /* CS0, offset 0 */
>>           nand-bus-width = <16>;
>>
>> -        gpmc,sync-clk = <0>;
>> -        gpmc,cs-on = <0>;
>> -        gpmc,cs-rd-off = <44>;
>> -        gpmc,cs-wr-off = <44>;
>> -        gpmc,adv-on = <6>;
>> -        gpmc,adv-rd-off = <34>;
>> -        gpmc,adv-wr-off = <44>;
>> -        gpmc,we-off = <40>;
>> -        gpmc,oe-off = <54>;
>> -        gpmc,access = <64>;
>> -        gpmc,rd-cycle = <82>;
>> -        gpmc,wr-cycle = <82>;
>> -        gpmc,wr-access = <40>;
>> -        gpmc,wr-data-mux-bus = <0>;
>> +        gpmc,device-nand;
>> +        gpmc,sync-clki-ps = <0>;
>> +        gpmc,cs-on-ns = <0>;
>> +        gpmc,cs-rd-off-ns = <44>;
>> +        gpmc,cs-wr-off-ns = <44>;
>> +        gpmc,adv-on-ns = <6>;
>> +        gpmc,adv-rd-off-ns = <34>;
>> +        gpmc,adv-wr-off-ns = <44>;
>> +        gpmc,we-off-ns = <40>;
>> +        gpmc,oe-off-ns = <54>;
>> +        gpmc,access-ns = <64>;
>> +        gpmc,rd-cycle-ns = <82>;
>> +        gpmc,wr-cycle-ns = <82>;
>> +        gpmc,wr-access-ns = <40>;
>> +        gpmc,wr-data-mux-bus-ns = <0>;
>>
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>
>

-- 
Florian Vaussard
EPFL - STI - IMT - LSRO1
MEB330 - Station 9
1015 Lausanne / Switzerland

tel: +41 21 693 78 39
fax: +41 21 693 78 07
http://lsro.epfl.ch
