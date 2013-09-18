From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2] ARM: dts: DRA7: provide arch-timer frequenecy parameter
Date: Wed, 18 Sep 2013 09:23:31 -0400
Message-ID: <5239A953.3040900@ti.com>
References: <5238899D.60903@ti.com> <1379437288-10831-1-git-send-email-nm@ti.com> <52398F87.6090108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39134 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3IRNX5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 09:23:57 -0400
In-Reply-To: <52398F87.6090108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

On Wednesday 18 September 2013 07:33 AM, Sricharan R wrote:
> Hi,
> 
> On Tuesday 17 September 2013 10:31 PM, Nishanth Menon wrote:
>> CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
>> timer frequency via DT. Without a valid value arch_timer_init results
>> in div0 crash.
>>
>> Cc: R Sricharan <r.sricharan@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Sourav Poddar <sourav.poddar@ti.com>
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Based on Benoit's for_3.13/dts branch. 
>> http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
>>
>> Crash log: http://pastebin.com/B2sDauS9
>>
>> V2: commit message update
>> V1: https://patchwork.kernel.org/patch/2903261/
>>
>>  arch/arm/boot/dts/dra7.dtsi |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index c98997b..71c2749 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -50,6 +50,7 @@
>>  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <6144000>;
>>  	};
>>  
>>  	gic: interrupt-controller@48211000 {
> This is not the right way to pass the frequency. In fact, initially the frequency value was present
> when the dts was added, but had to revert it back based on the feedbacks. Please refer below.
> 
There is nothing wrong in this method as well except the guest DT needs to
be updated and that is bothersome.
Ofcourse if there is an option setting up the CNTFREQ directly is the option.

Regards,
Santosh
  

