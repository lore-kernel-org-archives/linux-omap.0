From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: dra7: Add syscon-pllreset syscon to
 SATA PHY
Date: Wed, 15 Jul 2015 17:59:12 +0300
Message-ID: <55A67540.8090102@ti.com>
References: <1433236242-26172-1-git-send-email-rogerq@ti.com> <1433236242-26172-4-git-send-email-rogerq@ti.com> <55A64253.100@ti.com> <20150715120745.GE17550@atomide.com> <55A66486.9000609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A66486.9000609@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/15/2015 04:47 PM, Roger Quadros wrote:
> Hi,
>
> On 15/07/15 15:07, Tony Lindgren wrote:
>> * Kishon Vijay Abraham I <kishon@ti.com> [150715 04:24]:
>>> Hi Roger,
>>>
>>> On Tuesday 02 June 2015 02:40 PM, Roger Quadros wrote:
>>>> This register is required to be passed to the SATA PHY driver
>>>> to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>> ---
>>>>   arch/arm/boot/dts/dra7.dtsi | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>>> index f03a091..260f300 100644
>>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>>> @@ -1135,6 +1135,7 @@
>>>>   				ctrl-module = <&omap_control_sata>;
>>>>   				clocks = <&sys_clkin1>, <&sata_ref_clk>;
>>>>   				clock-names = "sysclk", "refclk";
>>>> +				syscon-pllreset = <&dra7_ctrl_core 0x3fc>;
>>>
>>> I think all users of syscon should be made child node of scm_conf. Tony and
>>> Tero, is that right?
>
> It can't be child of scm_conf as the address is outside it's range.
> Looks like I have to add a new child to scm node that maps beyond
> the dra7_pmx_core padconf address range.
>
>>>
>>> If so, then we might have to modify the driver too.
>>
>> Yeah there should not be much need to use syscon outside scm_conf
>> area and for I2C devices. If there's some other misc register area
>> in dra7 in addition to scm_conf then it might make sense to use it.
>>
>> But in general, for the SCM registers, just a normal loadable kernel
>> driver module doing of_ioremap on a dedicated range of registers is
>> always a better option :)
>>
>
> Lets take for example this register CTRL_CORE_SMA_SW_0.
> It has the SATA PLL_SOFT_RESET bit, EMIF1/2 gating control bits
> and ISOLATE bit.
>
> I don't see this fitting in any driver except the syscon approach.
>
> cheers,
> -roger
>

Yea I think scm_conf can generally contain lots of weird registers that 
can have multiple users / use-cases. This is the junk-yard of SoC 
features the designers had no idea where to put them; so they put it 
under scm_conf.

I'd say in some cases we are probably forced to map to it from other 
drivers, this is one of the reasons it is a syscon map in the first 
place, and generally speaking, they should not be children of scm_conf 
in the DT layout.

You could probably add a "dummy" node under scm_conf which maps to the 
scm register, and which you would refer to from the sata driver.

-Tero
