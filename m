From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: dra7: Add syscon-pllreset syscon to
 SATA PHY
Date: Mon, 27 Jul 2015 12:34:00 +0300
Message-ID: <55B5FB08.7060503@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com> <1437140844-6032-3-git-send-email-rogerq@ti.com> <55ACE4B5.7000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55ACE4B5.7000107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/07/15 15:08, Tero Kristo wrote:
> On 07/17/2015 04:47 PM, Roger Quadros wrote:
>> This register is required to be passed to the SATA PHY driver
>> to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 8f1e25b..4a0718c 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -1140,6 +1140,7 @@
>>                   ctrl-module = <&omap_control_sata>;
>>                   clocks = <&sys_clkin1>, <&sata_ref_clk>;
>>                   clock-names = "sysclk", "refclk";
>> +                syscon-pllreset = <&scm_conf 0x3fc>;
>>                   #phy-cells = <0>;
>>               };
>>
>>
> 
> Looks fine to me.
> 
> Make sure you use this register via regmap_update_bits only, seeing there is another potential user for the same register.

Yes. Patch 1 is the user using regmap_update_bits.

cheers,
-roger
