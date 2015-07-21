From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: dra7: Add scm_conf1 node and remove
 redundant nodes
Date: Tue, 21 Jul 2015 10:41:16 +0530
Message-ID: <55ADD474.6080709@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com> <1437140844-6032-4-git-send-email-rogerq@ti.com> <55ACE3DC.7070806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55ACE3DC.7070806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 20 July 2015 05:34 PM, Tero Kristo wrote:
> On 07/17/2015 04:47 PM, Roger Quadros wrote:
>> scm_conf1 maps the control register address space after the
>> padconf till the end.
>>
>> Fix the scm_conf and pmx_core resource lengths. We need to add
>> 4 bytes to include the last 32-bit register space.
>>
>> Remove the redundant dra7_ctrl_core and dra7_ctrl_general nodes.
>> They are not used by anyone and no longer needed as they are
>> covered by scm_conf and scm_conf1.
> 
> Looks like you are doing three things in this patch, maybe split it up 
> as such?
> 
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 4a0718c..d07c34c 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -141,7 +141,7 @@
>>   				dra7_pmx_core: pinmux@1400 {
>>   					compatible = "ti,dra7-padconf",
>>   						     "pinctrl-single";
>> -					reg = <0x1400 0x0464>;
>> +					reg = <0x1400 0x0468>;
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   					#interrupt-cells = <1>;
>> @@ -149,6 +149,13 @@
>>   					pinctrl-single,register-width = <32>;
>>   					pinctrl-single,function-mask = <0x3fffffff>;
>>   				};
>> +
>> +				scm_conf1: scm_conf@1 {
> 
> Should be ... scm_conf@1868?
> 
> Are there any users for this area anyway? I don't think we should map 
> this area just for fun of it. Mostly it looks like this contains efuse 
> values for OPPs, which should be mapped from the OPP layer, not as a 
> generic syscon.

The last few registers are used for PCIe PHY and I'll be needing it for the
next version of my patch series.

Thanks
Kishon
