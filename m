From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: dra7: Add scm_conf@1c04 node
Date: Tue, 4 Aug 2015 11:10:34 +0300
Message-ID: <55C0737A.7020906@ti.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com> <1437992850-6008-4-git-send-email-rogerq@ti.com> <55BF8DE9.5050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BF8DE9.5050907@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/08/15 18:51, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On Monday 27 July 2015 03:57 PM, Roger Quadros wrote:
>> This region contains CTRL_CORE_SMA_SW2..9 registers which
>> are not specific to any domain and can be reasonably
>> accessed via syscon driver.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 913032b..43b5074 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -149,6 +149,13 @@
>>  					pinctrl-single,register-width = <32>;
>>  					pinctrl-single,function-mask = <0x3fffffff>;
>>  				};
>> +
>> +				scm_conf1: scm_conf@1c04 {
>> +					compatible = "syscon";
>> +					reg = <0x1c04 0x0020>;
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
> 
> Why do you need address-cells and size-cells property here? AFAIK it is usually
> used to decode childs reg property.

Right. I'll remove them.

cheers,
-roger
