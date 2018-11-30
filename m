From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document
 application node bindings
Date: Fri, 30 Nov 2018 13:42:37 +0200
Message-ID: <5C01222D.3060104@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-13-git-send-email-rogerq@ti.com>
 <6a945433-00b2-e0e5-2dc8-2a4d2bf0db6f@lechnology.com> <5BFFBA5F.703@ti.com>
 <377707a9-6ea8-8faf-35dc-0aa1fddda272@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <377707a9-6ea8-8faf-35dc-0aa1fddda272@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 29/11/18 18:33, David Lechner wrote:
> On 11/29/18 4:07 AM, Roger Quadros wrote:
>> On 27/11/18 01:27, David Lechner wrote:
>>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Add documentation for the Texas Instruments PRU application nodes.
>>>> These are used to configure specific user applications for PRU instances.
>>>
>>> Could this be made into a generic remoteproc producer/consumer binding? Or
>>> are there really things that are specific to the TI PRU that need to be
>>> handled?
>>
>> The remoteproc handle and firmware name sound generic enough.
>> But there are TI PRU specific properties as well which we'll discuss if
>> they can be made generic.
>>
>>>
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> [s-anna@ti.com: some binding updates]
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
>>>>    1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>> index 3e5f32f..94c91ee 100644
>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>> @@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
>>>>    Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
>>>>      +Application/User Nodes
>>>> +=======================
>>>
>>> Are these supposed to be stand-alone platform devices?
>>>
>>
>> Yes. The first use case we're going to address is the Ethernet ports on the IDKs.
>> (Industrial development Kit) http://www.ti.com/tool/TMDXIDK437X
>>
>>>> +A PRU application/user node typically uses one or more PRU device nodes to
>>>> +implement a PRU application/functionality. Each application/client node would
>>>> +need a reference to at least a PRU node, and optionally pass some configuration
>>>> +parameters.
>>>
>>> I thought device tree is not supposed to be used for configuration.
>>
>> I think we need to word it properly. It is really a hardware/firmware map.
>>>
>>>> +
>>>> +Required Properties:
>>>> +--------------------
>>>> +- prus                 : phandles to the PRU nodes used
>>>> +
>>>> +Optional Properties:
>>>> +--------------------
>>>> +- firmware-name        : firmwares for the PRU cores, the default firmware
>>>> +                         for the core from the PRU node will be used if not
>>>> +                         provided. The firmware names should correspond to
>>>> +                         the PRU cores listed in the 'prus' property
>>>
>>> Perhaps this should be a "compatible" property instead of "firmware-name"? The
>>> driver that matches the compatible string can then set the firmware names.
>>
>> Compatible property is there to choose the application driver. Should have mentioned
>> it in Required properties.
>>
>> It is tricky for the driver to decipher the firmware-name as it needs to support
>> the same use case on multiple platforms and the firmware name will be different for each.
>> The driver itself is platform agnostic.
>>
>> So providing the firmware-name in the DT is the easiest and scalable solution.
>>>
>>>> +- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
>>>> +                         register for a PRU. This selects the internal muxing
>>>> +                         scheme for the PRU instance. If not provided, the
>>>> +                         default out-of-reset value (0) for the PRU core is
>>>> +                         used. Values should correspond to the PRU cores listed
>>>> +                         in the 'prus' property
>>>
>>> Is this supposed to be a pinmux? So maybe we should be using pinmux bindings?
>>
>> We already have pinmux binding for the PRU pins. This GP mux setting is an odd duck.
>>
>> It provides a way for a set of signals inside the ICSS to be connected to the PRU pins
>> on the SOC, which are again multiplexed with other SOC pins via the regular pinmux.
>>
>> Some of the sets are
>>
>> GPIO mode (0)
>> EnDAT mode (1)
>> SD mode (3)
>> MII2 mode (4)
>>
>> The application node needs to decide which set it wants to use.
>>
>>>
>>>> +- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
>>>> +                         with each entry consisting of 4 cell-values. First one
>>>> +                         is an index towards the "prus" property to identify the
>>>> +                         PRU core for the interrupt map, second is the PRU
>>>> +                         System Event id, third is the PRU interrupt channel id
>>>> +                         and fourth is the PRU host interrupt id. If provided,
>>>> +                         this map will supercede any other configuration
>>>> +                         provided through firmware
>>>
>>> Could this mapping just be cells of the interrupt consumer nodes instead of an
>>> extra property? As I mentioned in a reply to another patch, unless there is a
>>> compelling reason to do otherwise, the channel to host mapping can be required
>>> to be 1:1 as recommended in the TRMs, so that cell can be omitted. Also, since
>>> the interrupt controller is independent of the PRU cores, the cell specifying the
>>> index of the PRU core is not needed in this case. The #interrupt-cells already
>>> includes a cell for the system event number, so this just leaves one cell, the
>>> host channel, to be added to the #interrupt-cells.
>>>
>>> So, instead of:
>>>
>>>      ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>>>
>>> we could have:
>>>
>>>      interrupt-parent = <&pruss_intc>;
>>>      interrupts = <16 7>, <19 3>;
>>>
>>
>> No, interrupts property will be used to provide the actual sysevent IRQs to the
>> application driver. Below is how the ethernet application node looks like.
>>
>>     pruss2_eth {
>>         compatible = "ti,am57-prueth";
>>         prus = <&pru2_0>, <&pru2_1>;
>>         firmware-name = "ti-pruss/am57xx-pru0-prueth-fw.elf",
>>                 "ti-pruss/am57xx-pru1-prueth-fw.elf";
>>         sram = <&ocmcram1>;
>>         interrupt-parent = <&pruss2_intc>;
>>         mii-rt = <&pruss2_mii_rt>;
>>         iep = <&pruss2_iep>;
>>
>>         pruss2_emac0: ethernet-mii0 {
>>             phy-handle = <&pruss2_eth0_phy>;
>>             phy-mode = "mii";
>>             interrupts = <20>, <22>;
>>             interrupt-names = "rx", "tx";
>>         };
>>
>>         pruss2_emac1: ethernet-mii1 {
>>             phy-handle = <&pruss2_eth1_phy>;
>>             phy-mode = "mii";
>>             interrupts = <21>, <23>;
>>             interrupt-names = "rx", "tx";
>>         };
>>     };
>>
>> You can see that interrupts is providing the RX and TX sysevents.
>>
>> There needs to be a different way to provide the internal INTC map.
>>
>> Currently there are 2 ways of providing the INTC map. One is via the
>> resource table and other is via DT.
>>
>>> There are also already alternate interrupt bindings that allow for the case
>>> where there is more than one interrupt-parent.
> 
> Thanks for the insights. On the example above there is not a
> ti,pru-interrupt-map property. Does this mean that the interrupt
> mapping table comes from the firmware/resource-table in this case?
> 

Yes, that's correct.

>>>
>>>> +
>>>>    Example:
>>>>    ========
>>>>    1.    /* AM33xx PRU-ICSS */
>>>> @@ -397,3 +429,14 @@ Example:
>>>>                ...
>>>>            };
>>>>        };
>>>> +
>>>> +3:    /* PRU application node example */
>>>> +    app_node: app_node {
>>>> +        prus = <&pru1_0>, <&pru1_1>;
>>>> +        firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>>>> +        ti,pruss-gp-mux-sel = <2>, <1>;
>>>> +        /* setup interrupts for prus:
>>>> +           prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>>>> +           prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>>>> +        ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>>>> +    }
>>>>
>>>
>>

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
