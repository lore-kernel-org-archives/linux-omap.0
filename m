From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node
 and add ranges
Date: Wed, 11 Mar 2015 12:18:13 -0500
Message-ID: <550078D5.7080700@ti.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com> <1425528742-3087-3-git-send-email-d-gerlach@ti.com> <20150305154039.GD13520@atomide.com> <54F88849.1090708@ti.com> <20150305165727.GE13520@atomide.com> <54FE33CA.4090709@ti.com> <20150310160919.GQ5264@atomide.com> <54FF4C32.5070106@ti.com> <20150311162635.GZ5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150311162635.GZ5264@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 03/11/2015 11:26 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150310 12:55]:
>> Tony,
>> On 03/10/2015 11:09 AM, Tony Lindgren wrote:
>>> * Suman Anna <s-anna@ti.com> [150309 16:59]:
>>>> On 03/05/2015 10:57 AM, Tony Lindgren wrote:
>>>>> * Suman Anna <s-anna@ti.com> [150305 08:47]:
>>>>>> On 03/05/2015 09:40 AM, Tony Lindgren wrote:
>>>>>>> * Dave Gerlach <d-gerlach@ti.com> [150304 20:14]:
>>>>>> Dave,
>>>>>>
>>>>>> Looks like the commit message disappeared during your patch preparation.
>>>>>>
>>>>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>>>>>> ---
>>>>>>>>  arch/arm/boot/dts/am33xx.dtsi | 21 +++++++++++++--------
>>>>>>>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>>>>>>> index acd3705..086415c 100644
>>>>>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>>>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>>>>>> @@ -77,10 +77,23 @@
>>>>>>>>  	 */
>>>>>>>>  	soc {
>>>>>>>>  		compatible = "ti,omap-infra";
>>>>>>>> +		#address-cells = <1>;
>>>>>>>> +		#size-cells = <1>;
>>>>>>>> +		ranges = <0x0     0x44d00000 0x4000>,
>>>>>>>> +			 <0x80000 0x44d80000 0x2000>;
>>>>>>>> +
>>>>>>>
>>>>>>> I think putting the ranges here will cause issues for adding
>>>>>>> ranges for anything else.
>>>>>>>
>>>>>>> How about do something like this instead (untested):
>>>>>>>
>>>>>>> ocp {
>>>>>>> 	l4_wkup: l4_wkup@44c00000 {
>>>>>>> 		compatible = "am335-l4-wkup", "simple-bus";
>>>>>>> 		ranges = <0 0x44c00000 0x3fffff>;
>>>>>>>
>>>>>>> 		wkup_m3: wkup_m3@44d00000 {
>>>>>>> 			compatible = "ti,am3353-wkup-m3";
>>>>>>> 			reg = <0x1000000     0x4000>,	/* M3 UMEM */
>>>>>>> 			      <0x180000	     0x2000>;	/* M3 DMEM */
>>>>>>> 			ti,hwmods = "wkup_m3";
>>>>>>> 			ti,pm-firmware = "am335x-pm-firmware.elf";
>>>>>>> 		};
>>>>>>>
>>>>>>> 		...
>>>>>>> 	};
>>>>>>> };
>>>>>>>
>>>>>>> That way we can start moving also the other l4_wkup components there
>>>>>>> eventuallly without having to redo the ranges again for wkup_m3.
>>>>>>>
>>>>>>> You can also look at how the scm_conf was done for dm816x.dtsi for an
>>>>>>> example, and the recent large set of patches posted by Tero.
>>>>
>>>> I have taken a look at both the above. The L4_WKUP range includes the
>>>> PRCM, Control Module, as well as a few peripherals like DMTimer0, UART0
>>>> etc. What all do we want to move here eventually?
>>>
>>> Well eventually all the children of L4_WKUP, but that can be done
>>> slowly as some of the drivers have weird hacks and may not work
>>> properly if moved around.
>>>
>>> For example, anything with reg entries for something like SCM area will
>>> break as that's not going to be in the L4_WKUP area ny longer :p And
>>> that's actually good as it will protect us from spaghetti code
>>> automatically later on for new code.
>>>
>>>> Depending on that, we may have to use 2 address cells like in Tero's
>>>> PRCM cleanup series rather than the single cell translation used by
>>>> you in dm816x.dtsi so that we can retain the relative addresses
>>>> w.r.t the existing node bases in the derivative child nodes.
>>>
>>> Hmm OK, care to paste a dts snippet example for that?
>>
>> Suman and I have been looking at this together, so I can comment here. An
>> implementation like this is what Suman is referring to:
>>
>> +               l4_wkup: l4_wkup@44c00000 {
>> +                       compatible = "am335-l4-wkup", "simple-bus";
>> +                       #address-cells = <2>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0 0           0x44c00000 0x100000>,
>> +                                <1 0x0         0x44d00000 0x4000>,
>> +                                <2 0x80000     0x44d80000 0x2000>;

Actually, this would be slightly different, something like
 +                       ranges = <0 0    0x44c00000 0x100000>,
 +                                <1 0    0x44d00000 0x100000>,
 +                                <2 0    0x44e00000 0x4000>,
 +				  <3 0    0x44e10000 0x2000>;

and the M3 DMEM entry below will be adjusted as <1 0x80000 0x2000>.

>> +
>> +                       wkup_m3: wkup_m3@1,0 {
>> +                               compatible = "ti,am3353-wkup-m3";
>> +                               reg = <1 0x0     0x4000>,       /* M3 UMEM */
>> +                                     <2 0x80000 0x2000>;       /* M3 DMEM */
>> +
>> +                               ti,hwmods = "wkup_m3";
>> +                               ti,pm-firmware = "am335x-pm-firmware.elf";
>> +                       };
>> +               };
>> +
>>
>> The of_* layer automatically translates everything so the pdata-quirks can still
>> match based on wkup_m3@44d00000. The existing wkup_m3_rproc driver works almost
>> entirely as is with this, all cpu addresses are read and mapped correctly but
>> the driver no longer will read the actual device addresses correctly which we
>> need for understanding where to load the firmware sections.
> 
> OK. I still don't quite understand how these additional ranges make sense
> for other drivers connected to the l4_wkup. For wkup_m3, it makes sense if
> it allows you to translate directly to the m3 address space, but is that
> really the case here? Maybe you should have the ranges in wkup_m3 instead
> if you want addresses for the m3?

The idea is to introduce an additional address element (first cell in
ranges) so that the immediate child nodes bus address is referenced as 0
(second cell) for translation for their child nodes. This is the
approach used by the current scm node in Tero's series for OMAP4+. This
will work tomorrow if we move the prcm, scrm node under l4_wkup with
changes only in those nodes, and have their child nodes reg properties
unchanged. I guess you can see the difference between the following two
patches from Tero's PRCM series,
https://patchwork.kernel.org/patch/5882831/ &
https://patchwork.kernel.org/patch/5882841/

regards
Suman

> 
>> These device addresses are being read directly using of_get_address, which reads
>> the first value in the reg entries which is 1 and 2 now for UMEM and DMEM. We
>> would need some sort of change there also to get the proper 0x0 and 0x80000
>> device address values. Just advancing the pointer returned by of_get_address
>> does the trick but this doesn't seem like the cleanest solution.
> 
> I'd assume we have similar uses of range already.. Maybe look at some pcie
> examples and how they use ranges for the bus address translation? 
> 
> Regards,
> 
> Tony
> 
