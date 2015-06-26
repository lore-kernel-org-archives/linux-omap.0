From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/1] arm: dts: am43xx-clock: Add qspi clock node.
Date: Fri, 26 Jun 2015 10:33:05 +0300
Message-ID: <558D0031.1090501@ti.com>
References: <1435167933-5249-1-git-send-email-mugunthanvnm@ti.com> <558CEF2E.3050202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558CEF2E.3050202@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 26/06/15 09:20, Keerthy wrote:
>
>
> On Wednesday 24 June 2015 11:15 PM, Mugunthan V N wrote:
>> From: Sourav Poddar <sourav.poddar@ti.com>
>>
>> Add clock node for qspi controller driver on am437x.
>>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi        | 2 ++
>>   arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi
>> b/arch/arm/boot/dts/am4372.dtsi
>> index 649e7b9..8ab7831 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -903,6 +903,8 @@
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>>               ti,hwmods = "qspi";
>> +            clocks = <&qspi_fclk>;
>> +            clock-names = "fck";
>>               interrupts = <0 138 0x4>;
>>               num-cs = <4>;
>>               status = "disabled";
>> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> index cc88728..1506585 100644
>> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> @@ -763,4 +763,12 @@
>>           ti,bit-shift = <8>;
>>           reg = <0x8a68>;
>>       };
>> +
>> +    qspi_fclk: qspi_fclk {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,fixed-factor-clock";
>> +        clocks = <&dpll_per_m2_div4_ck>;
>
>  From the clock tree this does not seem to be sourced from dpll_per_m2.
> I guess this needs to be changed.

Right. We need to have a mux and divider.

cheers,
-roger

>
>> +        clock-mult = <1>;
>> +        clock-div = <1>;
>> +    };
>>   };
>>
