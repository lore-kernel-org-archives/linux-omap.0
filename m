From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2] ARM: dts: DRA7: provide arch-timer frequenecy parameter
Date: Wed, 18 Sep 2013 08:02:32 -0500
Message-ID: <5239A468.2070105@ti.com>
References: <5238899D.60903@ti.com> <1379437288-10831-1-git-send-email-nm@ti.com> <52398F87.6090108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52398F87.6090108-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/18/2013 06:33 AM, Sricharan R wrote:
> Hi,
> 
> On Tuesday 17 September 2013 10:31 PM, Nishanth Menon wrote:
>> CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
>> timer frequency via DT. Without a valid value arch_timer_init results
>> in div0 crash.
>>
>> Cc: R Sricharan <r.sricharan-l0cyMroinI0@public.gmane.org>
>> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
>> Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
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
> 
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg93832.html
> 
> 
> Also posted the below patch to fix this,
> 
>     http://marc.info/?l=linux-omap&m=137950345528918&w=2

Thanks for a better alternative. at least my boot tests indicate that
the patch works fine.


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
