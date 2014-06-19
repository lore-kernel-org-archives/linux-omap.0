From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 13/18] ARM: dts: dra7xx-clocks: Add missing clocks
 for second PCIe PHY instance
Date: Thu, 19 Jun 2014 18:55:04 +0530
Message-ID: <53A2E4B0.7030204@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com> <1401345500-20188-14-git-send-email-kishon@ti.com> <53A2C787.5060905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A2C787.5060905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 19 June 2014 04:50 PM, Tero Kristo wrote:
> On 05/29/2014 09:38 AM, Kishon Vijay Abraham I wrote:
>> Added missing clocks used by second instance of PCIe PHY.
>> The documention for this nodes can be found @ ../bindings/clock/ti/gate.txt.
> 
> Drop the ref to the binding doc and rather add a ref to TRM about the clock
> layout. Also, is the register offset wrong on these? Should be 0x13b8, no, or
> is my TRM version wrong?

Er.. you are right. It should be 0x13b8.

Thanks
Kishon
> 
> -Tero
> 
>>
>> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
>> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/dra7xx-clocks.dtsi |   24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> index 3d8c9c2..a9ff0dc 100644
>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> @@ -1173,6 +1173,14 @@
>>           ti,bit-shift = <8>;
>>       };
>>
>> +    optfclk_pciephy2_32khz: optfclk_pciephy_32khz@4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&sys_32k_ck>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <8>;
>> +    };
>> +
>>       optfclk_pciephy_div: optfclk_pciephy_div@4a00821c {
>>           compatible = "ti,divider-clock";
>>           clocks = <&apll_pcie_ck>;
>> @@ -1191,6 +1199,14 @@
>>           ti,bit-shift = <9>;
>>       };
>>
>> +    optfclk_pciephy2_clk: optfclk_pciephy_clk@4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&apll_pcie_ck>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <9>;
>> +    };
>> +
>>       optfclk_pciephy1_div_clk: optfclk_pciephy_div_clk@4a0093b0 {
>>           compatible = "ti,gate-clock";
>>           clocks = <&optfclk_pciephy_div>;
>> @@ -1199,6 +1215,14 @@
>>           ti,bit-shift = <10>;
>>       };
>>
>> +    optfclk_pciephy2_div_clk: optfclk_pciephy_div_clk@4a0093b4 {
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&optfclk_pciephy_div>;
>> +        #clock-cells = <0>;
>> +        reg = <0x13b4>;
>> +        ti,bit-shift = <10>;
>> +    };
>> +
>>       apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
>>           #clock-cells = <0>;
>>           compatible = "fixed-factor-clock";
>>
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
