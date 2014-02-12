From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: OMAP5: add pmu node
Date: Wed, 12 Feb 2014 14:00:34 +0100
Message-ID: <52FB7072.5000005@baylibre.com>
References: <1391014601-31663-1-git-send-email-nathan_lynch@mentor.com> <52FA8498.5050507@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:47150 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaBLNAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2014 08:00:38 -0500
Received: by mail-we0-f176.google.com with SMTP id q58so5932147wes.35
        for <linux-omap@vger.kernel.org>; Wed, 12 Feb 2014 05:00:37 -0800 (PST)
In-Reply-To: <52FA8498.5050507@mentor.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com

Hi Nathan,

On 11/02/2014 21:14, Nathan Lynch wrote:
> On 01/29/2014 10:56 AM, Nathan Lynch wrote:
>> Expose the PMU on OMAP5.
>>
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>
> OMAP folks, any issues with this patch?

Yes :-)

>> Notes:
>>      Briefly tested with perf on OMAP5 UEVM with next-20140124.
>>
>>   arch/arm/boot/dts/omap5.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.=
dtsi
>> index a72813a9663e..fbf4661436e2 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -76,6 +76,12 @@
>>   			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>>   	};
>>
>> +	pmu {
>> +		compatible =3D "arm,cortex-a15-pmu";
>> +		interrupts =3D <0 131 4>,
>> +			     <0 132 4>;

Could you use the macros instead of hard coded value? You have the=20
example just before your modification in the patch itself.

Thanks,
Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
