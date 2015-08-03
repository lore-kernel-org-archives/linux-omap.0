From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
Date: Mon, 3 Aug 2015 10:39:38 +0530
Message-ID: <55BEF792.7000307@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com> <1438072876-16338-5-git-send-email-vigneshr@ti.com> <55BB7CA4.1020300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BB7CA4.1020300-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 07/31/2015 07:18 PM, Sekhar Nori wrote:
> On Tuesday 28 July 2015 02:11 PM, Vignesh R wrote:
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
> 
> The patch talks about DRA7x in subject and description but you modify
> AM437x here. You have got commit text mixed up between 4/5 and 5/5.
> 
> Probably not the kind of feedback you are looking for an RFC, but since
> I noticed it..

Oh, my bad.. I will correct $subject when I submit actual patch series.

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
