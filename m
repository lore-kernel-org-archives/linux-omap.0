From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Tue, 3 Sep 2019 16:50:26 +0300
Message-ID: <e6fd5cd6-8176-55f9-5285-d52b84435649@ti.com>
References: <20190830121816.30034-1-t-kristo@ti.com>
 <20190830121816.30034-2-t-kristo@ti.com> <20190902042631.GA22055@bogus>
 <e8d700cd-8f3c-5cea-a022-b20a595fc1e1@ti.com>
 <CAHCN7xKNSj_DW+Gcbpy4ehphBYCbJw9mSATOcWzT7ZcZR81r6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xKNSj_DW+Gcbpy4ehphBYCbJw9mSATOcWzT7ZcZR81r6g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, p.zabel@pengutronix.de, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/09/2019 16:19, Adam Ford wrote:
> On Tue, Sep 3, 2019 at 2:26 AM Tero Kristo <t-kristo@ti.com> wrote:
>>
>> On 02/09/2019 16:39, Rob Herring wrote:
>>> On Fri, Aug 30, 2019 at 03:18:07PM +0300, Tero Kristo wrote:
>>>> Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
>>>> of these will act as a power domain controller and potentially as a reset
>>>> provider.
>>>>
>>>
>>> Converting this to schema would be nice.
>>
>> Do you have documentation about schema somewhere? Basically what I need
>> to do to fix this.
>>
>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/arm/omap/prm-inst.txt | 31 +++++++++++++++++++
>>>
>>> bindings/reset/
>>
>> I did not put this under reset, because this is basically a
>> multi-purpose function. Reset just happens to be the first functionality
>> it is going to provide. It will be followed by power domain support
>> later on.
>>
>> Any thoughts?
>>
>>>
>>>>    1 file changed, 31 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
>>>> new file mode 100644
>>>> index 000000000000..7c7527c37734
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
>>>> @@ -0,0 +1,31 @@
>>>> +OMAP PRM instance bindings
>>>> +
>>>> +Power and Reset Manager is an IP block on OMAP family of devices which
>>>> +handle the power domains and their current state, and provide reset
>>>> +handling for the domains and/or separate IP blocks under the power domain
>>>> +hierarchy.
>>>> +
>>>> +Required properties:
>>>> +- compatible:       Must be one of:
>>>> +            "ti,am3-prm-inst"
> 
> Would it make sense to call it am33 instead of am3?  The AM35xx is
> different than AM33.

Well, am35xx is effectively just a variant of omap3, they just named it 
funnily. Same for dra7 vs. am57xx. Also, bindings of type "ti,am3-*" 
exist for other am33xx functionality already.

-Tero

> 
>>>> +            "ti,am4-prm-inst"
>>>> +            "ti,omap4-prm-inst"
>>>> +            "ti,omap5-prm-inst"
>>>> +            "ti,dra7-prm-inst"
>>>
>>> '-inst' seems a bit redundant.
>>
>> ti,xyz-prm is already reserved by the parent node of all these.
>>
>> The hierarchy is basically like this (omap4 as example):
>>
>> prm: prm@4a306000 {
>>     compatible = "ti,omap4-prm";
>>     ...
>>
>>     prm_dsp: prm@400 {
>>       compatible = "ti,omap4-prm-inst";
>>       ...
>>     };
>>
>>     prm_device: prm@1b00 {
>>       compatible = "ti,omap4-prm-inst";
>>       ...
>>     };
>>
>>     ...
>> };
>>
>>
>>
>>>
>>>> +- reg:              Contains PRM instance register address range
>>>> +            (base address and length)
>>>> +
>>>> +Optional properties:
>>>> +- #reset-cells:     Should be 1 if the PRM instance in question supports resets.
>>>> +- clocks:   Associated clocks for the reset signals if any. Certain reset
>>>> +            signals can't be toggled properly without functional clock
>>>> +            being active for them.
>>>> +
>>>> +Example:
>>>> +
>>>> +prm_dsp2: prm@1b00 {
>>>
>>> reset-controller@...
>>
>> Well, as said, the same node is going to be also power domain provider
>> later on...
>>
>>>
>>>> +    compatible = "ti,dra7-prm-inst";
>>>> +    reg = <0x1b00 0x40>;
>>>> +    #reset-cells = <1>;
>>>> +    clocks = <&dsp2_clkctrl DRA7_DSP2_MMU0_DSP2_CLKCTRL 0>;
>>>> +};
>>>> --
>>>> 2.17.1
>>>>
>>>> --
>>>
>>
> 
> adam
>> --

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
