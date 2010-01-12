From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing
 different OPP types
Date: Tue, 12 Jan 2010 18:36:37 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E73BDA08@dnce01.ent.ti.com>
References: <1263299979.1536.7.camel@boson>
 <87iqb7fdgf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab0ALRgx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 12:36:53 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <87iqb7fdgf.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Dasgupta, Romit" <romit@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Kevin Hilman
>Sent: Tuesday, January 12, 2010 6:19 PM
>To: Dasgupta, Romit
>Cc: Menon, Nishanth; linux-omap@vger.kernel.org
>Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing
>different OPP types
>
>Romit Dasgupta <romit@ti.com> writes:
>
>> Introduces enum for identifying OPP types. This helps in querying the OPP
>> layer by passing the type of OPP (enum types) and gets away from
>maintaining
>> the pointer to the OPP data list outside the OPP layer.
>>
>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>
>I like this idea... but I have some questions about how we should
>cleanly handle SMP and future SoCs.

Well, it is better than what we have today, but maybe not super scalable for next device. This information is completely device dependant and should not be in a plat-omap file.
In that case, it will be tricky to have an enum per devices because it will prevent multiple omap build.
That for that reason that I think we might use hwmod to identify the relevant scalable IPs, instead of yet another identifier for something that is IP related.

Regards,
Benoit


>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-
>omap/include/plat/opp.h
>> index 9f91ad3..c4d5bf9 100644
>> --- a/arch/arm/plat-omap/include/plat/opp.h
>> +++ b/arch/arm/plat-omap/include/plat/opp.h
>> @@ -13,9 +13,18 @@
>>  #ifndef __ASM_ARM_OMAP_OPP_H
>>  #define __ASM_ARM_OMAP_OPP_H
>>
>> -extern struct omap_opp *mpu_opps;
>> -extern struct omap_opp *dsp_opps;
>> -extern struct omap_opp *l3_opps;
>> +#ifdef CONFIG_ARCH_OMAP3
>> +#define OPP_TYPES 3
>> +#else
>> +#error "You need to put the number of OPP types for OMAP chip type."
>> +#endif
>
>Rather than the #ifdef...
>> +enum opp_t {
>> +    OPP_NONE,
>> +    OPP_MPU,
>> +    OPP_L3,
>> +    OPP_DSP
>
>add OPP_MAX_TYPES here
>
>> +};
>
>And with that, how do you suggest handling SMP.  Do we assume that the
>OPP_MPU OPPs are common across all CPUs?  Do we possibly need other
>types for other busses on future SoCs?
>
>We don't need the answeres to all these questions today, but I'd like
>to know your thoughts on how this would be extended or made SoC
>specific.
>
>Thanks,
>
>Kevin
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



