From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Mon, 20 Aug 2012 21:21:58 +0530
Message-ID: <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com> <503240EF.4050805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59041 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221Ab2HTPxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 11:53:37 -0400
Received: by yenm2 with SMTP id m2so5913378yen.37
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 08:52:19 -0700 (PDT)
In-Reply-To: <503240EF.4050805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

On Mon, Aug 20, 2012 at 7:21 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Santosh,
>
> On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
>> This provides PL310 Level 2 Cache Controller Device Tree
>> support for OMAP4 based devices.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
>>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 6717c71..cf1efb6 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -36,6 +36,13 @@
>>               };
>>       };
>>
>
>> +     L2: l2-cache-controller {
>
> The reg offset is missing: l2-cache-controller@48242000
>
>> +             compatible = "arm,pl310-cache";
>> +             reg = <0x48242000 0x1000>;
>> +             cache-unified;
>> +             cache-level = <2>;
>> +     };
>> +
>
> In theory, the L2 cache should be referenced from the CPUs.
>
Agree.

> Here is the way it is done for mpc8541cdc.dts for example:
>
I will move it under CPU. Thanks

regards
Santosh
