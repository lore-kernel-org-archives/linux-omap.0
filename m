From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: Re: [PATCH v2 2/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Tue, 3 May 2016 08:31:11 -0500
Message-ID: <5728A81F.4050906@garmin.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
 <1462209123-7332-3-git-send-email-Linux.HWI@garmin.com>
 <57285E66.2000708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57285E66.2000708@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jay.schroeder@garmin.com
List-Id: linux-omap@vger.kernel.org

On 05/03/2016 03:16 AM, Tero Kristo wrote:
> On 02/05/16 20:12, J.D. Schroeder wrote:
>> From: "J.D. Schroeder" <jay.schroeder@garmin.com>
>>
>> This commit updates the OSC_32K_CLK (secure_32k_clk_src_ck) frequency
>> from the precise 32kHz frequency (i.e., 32.768 kHz) to a more
>> accurate frequency of ~34.6 kHz. Actual measured frequencies of the
>> clock vary from processor to processor anywhere from 34.4 kHz up to
>> 34.8 kHz. Note that the ~34 kHz frequency clock is generated
>> internally by the processor, not an input to the processor. This
>> change makes it more clear that the consumer of the
>> secure_32k_clk_src_ck will not get a precise 32.768 kHz frequency
>> output.
>>
>> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
>> Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
>> ---
>>   arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> index 3f0c61d..f7ec976 100644
>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> @@ -95,7 +95,7 @@
>>       secure_32k_clk_src_ck: secure_32k_clk_src_ck {
>>           #clock-cells = <0>;
>>           compatible = "fixed-clock";
>> -        clock-frequency = <32768>;
>> +        clock-frequency = <34600>; /* approximate frequency */
>>       };
>>
>>       sys_clk32_crystal_ck: sys_clk32_crystal_ck {
>>
> 
> I still don't agree with this patch. The actual frequency can drift much more,
> you are just seeing this number at your setup.

Yes, it can drift significantly from processor to processor. Do you agree that
this frequency is closer to what can be expected than 32768 Hz?

Like I said, I would have renamed the clock also but I opted to go the less
obtrusive route while still helping others that might think they can
reasonably use this clock in their design as a 32768 Hz clock source. Perhaps
my comment and selection of the approximate frequency is not the best (I'm
open for suggestions). However, I do think this change is an improvement and
clarifying change to what is currently present in the clock description.

-JD
