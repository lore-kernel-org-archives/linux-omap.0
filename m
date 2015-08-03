From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
Date: Mon, 3 Aug 2015 10:36:44 +0530
Message-ID: <55BEF6E4.2000905@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com> <1438072876-16338-5-git-send-email-vigneshr@ti.com> <20150731212847.GH10676@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150731212847.GH10676-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 08/01/2015 02:58 AM, Brian Norris wrote:
> On Tue, Jul 28, 2015 at 02:11:15PM +0530, Vignesh R wrote:
>> Add qspi memory mapped region entries for DRA7xx based SoCs.
>>
>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ade28c790f4b..5317a0f24ab9 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -902,7 +902,9 @@
>>  
>>  		qspi: qspi@47900000 {
>>  			compatible = "ti,am4372-qspi";
>> -			reg = <0x47900000 0x100>;
>> +			reg = <0x47900000 0x100>,
>> +			      <0x30000000 0x3ffffff>;
> 
> Are you sure this region is 1 byte shy of 64MB in length? Same question
> for patch 5.
> 

Oops, my bad... Its 64MB in length, I entered offset of last byte
instead of length. Will correct this in the actual patch.

>> +			reg-names = "qspi_base", "qspi_mmap";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  			ti,hwmods = "qspi";
>> -- 
>> 2.4.6
>>

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
