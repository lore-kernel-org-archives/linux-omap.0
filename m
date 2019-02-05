From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Tue, 5 Feb 2019 17:41:23 +0200
Message-ID: <5C59AEA3.1080400@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Murali Karicheri <m-karicheri2@ti.com>, Tony Lindgren <tony@atomide.com>, s-anna@ti.com
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Murali,

On 05/02/19 17:08, Murali Karicheri wrote:
> Hi Roger,
> 
> On 02/05/2019 04:39 AM, Roger Quadros wrote:
>> Hi Tony & Suman,
>>
>> On 04/02/19 18:33, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Roger Quadros <rogerq@ti.com> [190204 14:23]:
>>>> From: Suman Anna <s-anna@ti.com>
>>> ...
>>>> +Example:
>>>> +========
>>>> +1.    /* AM33xx PRU-ICSS */
>>>> +
>>>> +    pruss: pruss@0 {
>>>> +        compatible = "ti,am3356-pruss";
>>>> +        reg = <0x0 0x2000>,
>>>> +              <0x2000 0x2000>,
>>>> +              <0x10000 0x3000>;
>>>> +        reg-names = "dram0", "dram1",
>>>> +                "shrdram2";
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <1>;
>>>> +        ranges;
>>>
>>> Thanks for fixing up the reg ranges for the top level node.
>>>
>>> Ideally there would not even be a top level node here as
>>> AFAIK the whole PRUSS is a collection of devices on a PRU
>>> internal interconnect. So following that path a bit further..
>>> How about just get rid of the top level node and just do:
>>>
>>> pruss: pruss@0 {
>>>     dram0: memory@0 {
>>>            device_type = "memory";
>>>            reg = <0x0 0x2000>;
>>>     };
>>>
>>>     dram1: memory@2000 {
>>>            device_type = "memory";
>>>            reg = <0x2000 0x2000>;
>>>     };
>>
>> Actually dram0 and dram1 are data memories for PRU0 and PRU1 respectively.
>> Isn't it better if they are moved to the pru node?
>> e.g.
>>
>>     pru0: pru@34000 {
>>         compatible = "ti,am3356-pru";
>>         reg = <0x34000 0x2000>,
>>               <0x22000 0x400>,
>>               <0x22400 0x100>,
>>               <0x0     0x2000>;
>>         reg-names = "iram", "control", "debug", "dram";
>>         ...
>>     };
>>
>>     pru1: pru@38000 {
>>         compatible = "ti,am3356-pru";
>>         reg = <0x38000 0x2000>,
>>               <0x24000 0x400>,
>>               <0x24400 0x100>,
>>               <0x2000  0x2000>;
>>         reg-names = "iram", "control", "debug", "dram";
>>         ...
>>     };
>>
>> I think it is better to place a restriction that firmware on PRU0 cannot use data
>> memory of PRU1 and vice versa.
>>
> That will not work as there are switch firmware cases where PRU access
> DRAM of other PRU and is a valid case to support in the future. So let
> us not do that.

PRU firmware accessing DRAM of other PRU is a design contract and that use case
requires both PRUs to be loaded with matching firmware. That should continue to work.

What I'm suggesting here is that kernel remoteproc driver should have nothing to do
with the other PRU's data RAM.

The application driver if needs both PRUs then it can obviously access both DRAMs
as it has a phandle to both PRUs.

cheers,
-roger

> 
> Murali
>> Application drivers do sometimes need to read/write to data memory. The pru_rproc
>> driver could provide a API for the application drivers to get virtual address of
>> the respective PRU's data memory.
>>
>>>
>>>     shrdram2: memory@10000 {
>>>         device_type = "memory";
>>>         reg = <0x10000 0x3000>;
>>>     };
>>
>> Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
>> might need to read/write here. The area split is decided by firmware design and there
>> is no hardware protection to prevent from stomping on each others toes.
>>
>> We need a carveout based memory allocator at least I think that can do a
>> allocate(base_offset, size); into shared RAM.
>>
>> This could be used by pru_rproc driver at firmware load time and by application drivers
>> at initialization time.
>>
>> Thoughts?
>>
>>>
>>>     pruss_cfg: cfg@26000 {
>>>         ...
>>>     };
>>>     ...
>>> };
>>>
>>> If the device_type = "memory" cannot be used here for
>>> being specific to the top level properties, then
>>> there's probably some other generic property usable
>>> here :)
>>>
>>>> +        pruss_mii_rt: mii_rt@32000 {
>>>> +            reg = <0x32000 0x58>;
>>>> +        };
>>>
>>> The node name should not have underscores so
>>> pruss_mii_rt: mii-rt@32000. Please check the others
>>> too, like app_node.
>>>
>>
>> OK.
>>
>>>> +    app_node: app_node {
>>>> +        prus = <&pru0>, <&pru1>;
>>>> +        firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>>>> +        ti,pruss-gp-mux-sel = <2>, <1>;
>>>> +        /* setup interrupts for prus:
>>>> +           prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>>>> +           prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>>>> +        ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>>>> +    }
>>>
>>> If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
>>> firmware configuration options, maybe leave them out of
>>> the dts completely and make the app-node optional.
>>
>> Yes the app-node is optional. I will mention it.
>>
>> No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
>> But these settings are application/firmware specific.
>>
>> ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
>> controller.
>>
>> ti,pruss-gp-mux-sel is used to configure this register.
>> "Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
>> "29:26 PR1_PRU0_GP_MUX_SEL"
>>
>> It configures how the pins from the PRUSS module are routed internally
>> to the various modules.
>>
>> see "30.2.1 PRU-ICSS I/O Interface"
>> and "Table 30-1. PRU-ICSS1 I/O Signals"
>>
>>>
>>> And have a proper compatible for this node such as
>>> "ti,pruss-app-xyz". And this should be only set if the the
>>> hardware is wired up in such way that things need to be
>>> configured in the dts rather than by the firmware.
>>
>> Yes, compatible is a required property as we need to load
>> the appropriate application (kernel space) driver for it.
>> I will fix the example.
>>
>>>
>>> And then you can just hide mux-sel and interrupt-map
>>> behind the compatible property for that hardware. And
>>> leave them out from the dts and have the handling driver
>>> would set mux-sel and interrupt-map based on the
>>> match->data during probe.
>>
>> To summarize:
>>
>> I'll mark the app node as optional. Only required if a kernel
>> driver is required for the application.
>> Compatible is mandatory for app node.
>> ti,pruss-gp-mux-sel and ti,pru-interrupt-map are optional
>> for app node.
>>
>> cheers,
>> -roger
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
