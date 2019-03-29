From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
Date: Fri, 29 Mar 2019 16:02:25 +0200
Message-ID: <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-4-git-send-email-rogerq@ti.com>
 <20190204180359.GM5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204180359.GM5720@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 04/02/2019 20:03, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190204 15:54]:
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -167,6 +167,200 @@
>>  		l4_per3: interconnect@48800000 {
>>  		};
>>  
>> +		pru_icss1: target-module@4b200000 {
> 
> I suggest you add these into dra7-pruss.dtsi as they
> have internal interconnects. And eventually some of
> the *pruss.dtsi files might become shared :) And we
> avoid moving these around when we define the l3
> interconnects and avoid a lot of extra long dtsi
> line lengths with the added nestedness later on.

PRUSS is only present on AM57x variants.
I will move this to am57x-pruss.dtsi.

This means all AM57x boards will have to include it.

Is this OK?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
