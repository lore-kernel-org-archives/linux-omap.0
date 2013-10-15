From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RESEND PATCH V2 1/2] ARM: dts: AM33xx: Add RNG node
Date: Tue, 15 Oct 2013 08:49:08 +0200
Message-ID: <525CE564.6010605@baylibre.com>
References: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com> <1377780731-3648-2-git-send-email-lokeshvutla@ti.com> <52594DF0.1050002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41030 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3JOGtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Oct 2013 02:49:13 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so7961305wes.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 23:49:12 -0700 (PDT)
In-Reply-To: <52594DF0.1050002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Lokesh,

On 12/10/2013 15:26, Lokesh Vutla wrote:
> Hi Benoit,
> On Thursday 29 August 2013 06:22 PM, Lokesh Vutla wrote:
>> Add the AM33xx RNG module's device tree data.
>> Also add Documentation file describing the data
>> for the RNG module.
> Seems you missed this patch. Please consider this for this merge wind=
ow.

Indeed I missed it. Sorry :-(

> Patch 2/2 is already taken by Paul.
> Without this patch AM335x boot will crash as I mentioned in my cover =
letter.
>
> Thanks and regards,
> Lokesh
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since V1:
>> - Drop "status=3Ddisabled" entry in dt node, Since
>>    RNG is present on all AM33xx platforms.
>>
>>   .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++=
++++++++++++
>>   arch/arm/boot/dts/am33xx.dtsi                      |    7 +++++++
>>   2 files changed, 29 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rn=
g.txt

I do not see the acked-by for the binding part. You do need that for an=
y=20
new bindings nowadays.

>>
>> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/=
Documentation/devicetree/bindings/hwrng/omap_rng.txt
>> new file mode 100644
>> index 0000000..6a62acd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
>> @@ -0,0 +1,22 @@
>> +OMAP SoC HWRNG Module
>> +
>> +Required properties:
>> +
>> +- compatible : Should contain entries for this and backward compati=
ble
>> +  RNG versions:
>> +  - "ti,omap2-rng" for OMAP2.
>> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
>> +  Note that these two versions are incompatible.
>> +- ti,hwmods: Name of the hwmod associated with the RNG module
>> +- reg : Offset and length of the register set for the module
>> +- interrupts : the interrupt number for the RNG module.
>> +		Only used for "ti,omap4-rng".
>> +
>> +Example:
>> +/* AM335x */
>> +rng: rng@48310000 {
>> +	compatible =3D "ti,omap4-rng";
>> +	ti,hwmods =3D "rng";
>> +	reg =3D <0x48310000 0x2000>;
>> +	interrupts =3D <111>;
>> +};
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33x=
x.dtsi
>> index 38b446b..26ebe30 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -530,5 +530,12 @@
>>   			#size-cells =3D <1>;
>>   			status =3D "disabled";
>>   		};
>> +
>> +		rng: rng@48310000 {
>> +			compatible =3D "ti,omap4-rng";
>> +			ti,hwmods =3D "rng";
>> +			reg =3D <0x48310000 0x2000>;
>> +			interrupts =3D <111>;
>> +		};
>>   	};
>>   };
>>
>

It looks good to me, but it does not apply on my branch.
Please rebase it and repost with the proper acked-by.

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
