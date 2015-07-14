From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: dra7: Add syscon-pllreset syscon to SATA
 PHY
Date: Tue, 14 Jul 2015 13:39:37 +0300
Message-ID: <55A4E6E9.90307@ti.com>
References: <1431446828-5473-1-git-send-email-rogerq@ti.com> <1431446828-5473-4-git-send-email-rogerq@ti.com> <20150714103403.GN17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150714103403.GN17550@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kishon@ti.com, nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 14/07/15 13:34, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150512 09:08]:
>> This register is required to be passed to the SATA PHY driver
>> to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index f03a091..260f300 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -1135,6 +1135,7 @@
>>  				ctrl-module = <&omap_control_sata>;
>>  				clocks = <&sys_clkin1>, <&sata_ref_clk>;
>>  				clock-names = "sysclk", "refclk";
>> +				syscon-pllreset = <&dra7_ctrl_core 0x3fc>;
>>  				#phy-cells = <0>;
>>  			};
>>  
> 
> Looks like this one is still pending driver changes, please
> resend when those are resolved. I'll untag this one for now.

I've sent a v2 of this series here
http://thread.gmane.org/gmane.linux.kernel/1967419

cheers,
-roger
