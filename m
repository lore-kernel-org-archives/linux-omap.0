From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: OMAP5+: separate the cpu thermal zone definition
 from omap4
Date: Mon, 23 Mar 2015 12:16:39 +0200
Message-ID: <550FE807.6020107@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com> <1426880861-9266-2-git-send-email-nm@ti.com> <20150320215402.GB7346@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbCWKRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 06:17:00 -0400
In-Reply-To: <20150320215402.GB7346@developer.amazonguestwifi.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>

On 03/20/2015 11:54 PM, Eduardo Valentin wrote:
> On Fri, Mar 20, 2015 at 02:47:39PM -0500, Nishanth Menon wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
>> in the thermal zone polling intervals. OMAP5/DRA7 have different counter
>> mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
>> zone accordingly for OMAP5/DRA7.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
>
>> ---
>>   arch/arm/boot/dts/omap5-cpu-thermal.dtsi |   41 ++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap5.dtsi             |    2 +-
>>   2 files changed, 42 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/omap5-cpu-thermal.dtsi
>>
>> diff --git a/arch/arm/boot/dts/omap5-cpu-thermal.dtsi b/arch/arm/boot/dts/omap5-cpu-thermal.dtsi
>> new file mode 100644
>> index 000000000000..4a6427c1e47e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap5-cpu-thermal.dtsi
>> @@ -0,0 +1,41 @@
>> +/*
>> + * Device Tree Source for OMAP4/5 SoC CPU thermal
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + * Contact: Tero Kristo <t-kristo@ti.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +cpu_thermal: cpu_thermal {
>> +	polling-delay-passive = <250>; /* milliseconds */
>> +	polling-delay = <500>; /* milliseconds */
>> +
>> +			/* sensor       ID */
>> +	thermal-sensors = <&bandgap     0>;
>> +
>> +	cpu_trips: trips {
>> +		cpu_alert0: cpu_alert {
>> +			temperature = <100000>; /* millicelsius */
>> +			hysteresis = <2000>; /* millicelsius */
>> +			type = "passive";
>> +		};
>> +		cpu_crit: cpu_crit {
>> +			temperature = <125000>; /* millicelsius */
>> +			hysteresis = <2000>; /* millicelsius */
>> +			type = "critical";
>> +		};
>> +	};
>> +
>> +	cpu_cooling_maps: cooling-maps {
>> +		map0 {
>> +			trip = <&cpu_alert0>;
>> +			cooling-device =
>> +				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index ddff674bd05e..e650d4eb59dd 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -67,7 +67,7 @@
>>   	};
>>
>>   	thermal-zones {
>> -		#include "omap4-cpu-thermal.dtsi"
>> +		#include "omap5-cpu-thermal.dtsi"
>
> Can't we simple change the polling value for the omap5 case and reuse
> the omap4 file?

Hmm yea, I posted a patch like this before for o5 and it was queued 
already. See:

http://thread.gmane.org/gmane.linux.ports.arm.omap/123729

The dra7 part was missing from this set though, so patches 2/3 do not 
directly work with that one and will require some changes similar to the 
linked omap4 one.

-Tero

>
>>   		#include "omap5-gpu-thermal.dtsi"
>>   		#include "omap5-core-thermal.dtsi"
>>   	};
>> --
>> 1.7.9.5
>>

