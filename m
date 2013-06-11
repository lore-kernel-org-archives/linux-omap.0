From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
Date: Tue, 11 Jun 2013 19:30:22 +0200
Message-ID: <51B75EAE.6070405@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch> <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch> <51B74267.1000700@collabora.co.uk>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:56291 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754083Ab3FKRa2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 13:30:28 -0400
In-Reply-To: <51B74267.1000700@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Javier,

On 06/11/2013 05:29 PM, Javier Martinez Canillas wrote:
> On 06/11/2013 04:48 PM, Florian Vaussard wrote:
>> Use the MTD constants for NAND and OneNAND nodes used in OMAP3
>> DTS.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   arch/arm/boot/dts/omap3-devkit8000.dts |   10 +++++-----
>>   arch/arm/boot/dts/omap3-igep0020.dts   |   10 +++++-----
>>   arch/arm/boot/dts/omap3-igep0030.dts   |   10 +++++-----
>>   arch/arm/boot/dts/omap3430-sdp.dts     |   28 ++++++++++++++--------------
>>   4 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
>> index 5be71b1..08699cb 100644
>> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
>> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
>> @@ -143,27 +143,27 @@
>>
>>   		x-loader@0 {
>>   			label = "X-Loader";
>> -			reg = <0 0x80000>;
>> +			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
>>   		};
>>
>>   		bootloaders@80000 {
>>   			label = "U-Boot";
>> -			reg = <0x80000 0x1e0000>;
>> +			reg = <(4 * SZ_128K) (15 * SZ_128K)>;
>>   		};
>>
>>   		bootloaders_env@260000 {
>>   			label = "U-Boot Env";
>> -			reg = <0x260000 0x20000>;
>> +			reg = <(19 * SZ_128K) (1 * SZ_128K)>;
>>   		};
>>
>>   		kernel@280000 {
>>   			label = "Kernel";
>> -			reg = <0x280000 0x400000>;
>> +			reg = <(20 * SZ_128K) (32 * SZ_128K)>;
>>   		};
>>
>>   		filesystem@680000 {
>>   			label = "File System";
>> -			reg = <0x680000 0xf980000>;
>> +			reg = <(52 * SZ_128K) MTDPART_SIZ_FULL>;
>>   		};
>>   	};
>>   };
>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>> index e8c4828..3476b3c 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -97,23 +97,23 @@
>>
>>   		partition@0 {
>>   			label = "SPL";
>> -			reg = <0 0x100000>;
>> +			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
>>   		};
>>   		partition@0x80000 {
>>   			label = "U-Boot";
>> -			reg = <0x100000 0x180000>;
>> +			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
>>   		};
>>   		partition@0x1c0000 {
>>   			label = "Environment";
>> -			reg = <0x280000 0x100000>;
>> +			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
>>   		};
>>   		partition@0x280000 {
>>   			label = "Kernel";
>> -			reg = <0x380000 0x300000>;
>> +			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
>>   		};
>>   		partition@0x780000 {
>>   			label = "Filesystem";
>> -			reg = <0x680000 0x1f980000>;
>> +			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
>> index 644d053..e4f078c 100644
>> --- a/arch/arm/boot/dts/omap3-igep0030.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
>> @@ -72,23 +72,23 @@
>>
>>   		partition@0 {
>>   			label = "SPL";
>> -			reg = <0 0x100000>;
>> +			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
>>   		};
>>   		partition@0x80000 {
>>   			label = "U-Boot";
>> -			reg = <0x100000 0x180000>;
>> +			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
>>   		};
>>   		partition@0x1c0000 {
>>   			label = "Environment";
>> -			reg = <0x280000 0x100000>;
>> +			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
>>   		};
>>   		partition@0x280000 {
>>   			label = "Kernel";
>> -			reg = <0x380000 0x300000>;
>> +			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
>>   		};
>>   		partition@0x780000 {
>>   			label = "Filesystem";
>> -			reg = <0x680000 0x1f980000>;
>> +			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
>>   		};
>>   	};
>>   };
>
> Hi Florian,
>
> I don't have access to my IGEP board so I can test it right now but the patch
> looks good to me.
>
> In fact I wanted to use MTDPART_SIZ_FULL when added the NAND nodes since not all
> IGEP boards have 512MB flash but I didn't know that a value of 0 meant that.
>

I had the same problem, and found that 0 was correctly parsed and later 
expanded to
the correct value when probing the NAND.

> So thanks a lot for doing this!
>
> Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>

Thank you.

Florian
