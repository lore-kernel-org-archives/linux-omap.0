From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Wed, 28 Nov 2018 09:42:19 -0600
Message-ID: <ee02b7d3-e7fd-2f4a-4213-d556d364194b@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
 <5BFD5F83.3070807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BFD5F83.3070807@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/27/18 9:15 AM, Roger Quadros wrote:
> 
> On 26/11/18 23:14, David Lechner wrote:
>> On 11/22/18 5:38 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> This patch adds the bindings for the Programmable Real-Time Unit
>>> and Industrial Communication Subsystem (PRU-ICSS) present on various
>>> TI SoCs. The IP is present on multiple TI SoC architecture families
>>> including the OMAP architecture SoCs such as AM33xx, AM437x and
>>> AM57xx; and on a Keystone 2 architecture based 66AK2G SoC. It is
>>> also present on the Davinci based OMAPL138 SoCs and K3 architecture
>>> based AM65x SoCs as well (not covered for now). Details have been
>>> added to include bindings for various core sub-modules like the PRU
>>> Cores, the PRUSS Interrupt Controller, and other sub-modules used
>>> for Industrial Communication purposes, covering the MDIO, MII_RT
>>> and the IEP sub-modules. The binding mostly uses standard DT
>>> properties.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>    .../devicetree/bindings/soc/ti/ti,pruss.txt        | 360 +++++++++++++++++++++
>>>    1 file changed, 360 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>> new file mode 100644
>>> index 0000000..24fedad
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>
>> ...
>>
>>> +
>>> +PRU-ICSS SoC Bus Parent Node
>>> +=============================
>>> +This node represents the integration of the PRU-ICSS IP into a SoC, and is
>>> +required for all SoCs. The PRU-ICSS parent nodes need to be defined as child
>>> +nodes of this node.
>>> +
>>> +Required Properties:
>>> +--------------------
>>> +- compatible     : should be one of,
>>> +                       "ti,am3356-pruss-soc-bus" for AM335x family of SoCs
>>> +                       "ti,am4376-pruss-soc-bus" for AM437x family of SoCs
>>> +                       "ti,am5728-pruss-soc-bus" for AM57xx family of SoCs
>>> +                       "ti,k2g-pruss-soc-bus" for 66AK2G family of SoCs
>>> +- reg            : address and size of the PRUSS CFG sub-module registers
>>> +                   dictating the interconnect configuration
>>
>> I haven't looked into Tony's suggestion of using ti-sysc yet, so this may be a
>> moot point, but how will this work with AM18xx that does not have a PRUSS CFG
>> register? It seems to me that reg here should be the address and size of the
>> entire PRUSS IP block and the CFG register should be a syscon node or something
>> like that.
> 
> The reg property description is incorrect in the patch. It should have been
> 
> reg		: address of SYSCFG register.
> 
> The SYSCFG register is used to enable and reset the module.
> 
> But based on Tony's suggestion this wrapper driver will change to ti,sysc for
> OMAP like SoCs.
> 
> For AM18xx it could be a simple wrapper driver that just populates the children?

I suppose that could work. I will look into it (perhaps after seeing what you
come up with in v2).

> 
>>
>>> +- #address-cells : should be 1
>>> +- #size-cells    : should be 1
>>> +- ranges         : standard ranges definition
>>> +
>>
>> ...
>>
>>> +
>>> +PRUSS INTC Child Node
>>> +======================
>>> +Each PRUSS has a single interrupt controller instance that is common to both
>>> +the PRU cores. Each interrupt controller can detect 64 input events which are
>>> +then mapped to 10 possible output interrupts through two levels of mapping. The
>>> +input events can be triggered by either the PRUs and/or various other PRUSS
>>> +internal and external peripherals. The first 2 output interrupts are fed
>>> +exclusively to the internal PRU cores, with the remaining 8 connected to
>>> +external interrupt controllers including the MPU.
>>
>> FYI, on AM18xx, there is a PRUSSEVTSEL bit in CFGCHIP3[3] (already a syscon node
>> in the device tree) that allows selecting one of two groups of 32 input events
>> out of this group of 64. This is perhaps getting out of the scope of this patch
>> series, but I just want to make sure we end up with something that can be easily
>> extended for this case. For example, I was thinking that this binding could be
>> modified so that #interrupt-cells could be 1 or 2. If it is 2, then the first
>> cell specifies the PRUSSEVTSEL value and the second value is the event number.
>>
> 
> this is da850.dtsi correct?

Yes.

> 
> As PRUSSEVTSEL is not SYSEVENT specific but applies to all the SYSEVENTs at a time.
> I don't think interrupt-cells is the right place to specify this.
> 
> Can it be set in DT in the board file? But this can't change once booted so maybe restrictive.

I guess the way I see this is that it is like specifying the bank and index for
a GPIO. If you only specify the system event number, then it is not clear which
event you mean - it could be one of two events. You have to also specify the
PRUSSEVTSEL value (one could call this the bank or group, I suppose) to fully
describe the system event.

> 
> If runtime change is required it can only be done before a PRU boots.
> 
> How about providing this info in the resource table and/or application DT node?

This seems like this would make it easy to end up with a broken interrupts
if you accidentally try to use interrupts from both groups. Instead this
could be implemented in the irqchip driver such that the first interrupt
(system event) requested gets to select the group. If any interrupts from
the other group are requested later, they can just return an error. Any
interrupts in the same group as the first can be requested successfully.
