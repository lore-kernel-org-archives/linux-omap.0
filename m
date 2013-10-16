From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
Date: Wed, 16 Oct 2013 08:27:16 -0500
Message-ID: <525E9434.1090006@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com> <525E9206.9010501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525E9206.9010501-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/16/2013 08:17 AM, Kishon Vijay Abraham I wrote:
> Benoit,
> 
> On Thursday 10 October 2013 04:19 PM, Kishon Vijay Abraham I wrote:
>> smps10 should be enabled only in the case of host mode. So stop
>> doing always_on, boot_on from smps10_out1. The driver will enable it in host
>> mode.
> 
> Can you take this patch too?

Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Thanks
> Kishon
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index d784b3a..e06a04a 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -334,8 +334,6 @@
>>  					regulator-name = "smps10_out1";
>>  					regulator-min-microvolt = <5000000>;
>>  					regulator-max-microvolt = <5000000>;
>> -					regulator-always-on;
>> -					regulator-boot-on;
>>  				};
>>  
>>  				ldo1_reg: ldo1 {
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
