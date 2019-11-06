From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add OMAP remoteproc
 bindings
Date: Wed, 6 Nov 2019 15:50:35 +0200
Message-ID: <80d28cf5-1219-fb49-a416-5a879f719ebd@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-2-t-kristo@ti.com> <20191106032727.GA21162@bogus>
 <25d55648-1fad-7de2-0937-5efeee8672eb@ti.com>
 <CAL_JsqJd_wDMVgFkMRZ7_+0hz93zqJFWEQXY-Sn+3tT-urzRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJd_wDMVgFkMRZ7_+0hz93zqJFWEQXY-Sn+3tT-urzRKA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/11/2019 15:27, Rob Herring wrote:
> On Wed, Nov 6, 2019 at 6:44 AM Tero Kristo <t-kristo@ti.com> wrote:
>>
>> On 06/11/2019 05:27, Rob Herring wrote:
>>> On Mon, Oct 28, 2019 at 02:42:22PM +0200, Tero Kristo wrote:
>>>> From: Suman Anna <s-anna@ti.com>
>>>>
>>>> Add the device tree bindings document for the IPU and DSP
>>>> remote processor devices on OMAP4+ SoCs.
>>>>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: devicetree@vger.kernel.org
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>>    .../remoteproc/ti,omap-remoteproc.txt         | 205 ++++++++++++++++++
>>>>    1 file changed, 205 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.txt
>>>>
>>>
>>> Looks to be in pretty good shape, but how about doing a schema.
>>
>> iommu / mailbox is not in schema format, can I just convert this one to
>> schema without considering those? If yes, I can go ahead and do it.
> 
> The client side both have schema (in dt-schema repo).
> 
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.txt
>>>> new file mode 100644
>>>> index 000000000000..e2bcfcab21c1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.txt
>>>> @@ -0,0 +1,205 @@
>>>> +OMAP4+ Remoteproc Devices
>>>> +=========================
>>>> +
>>>> +The OMAP family of SoCs usually have one or more slave processor sub-systems
>>>> +that are used to offload some of the processor-intensive tasks, or to manage
>>>> +other hardware accelerators, for achieving various system level goals.
>>>> +
>>>> +The processor cores in the sub-system are usually behind an IOMMU, and may
>>>> +contain additional sub-modules like Internal RAM and/or ROMs, L1 and/or L2
>>>> +caches, an Interrupt Controller, a Cache Controller etc.
>>>> +
>>>> +The OMAP SoCs usually have a DSP processor sub-system and/or an IPU processor
>>>> +sub-system. The DSP processor sub-system can contain any of the TI's C64x,
>>>> +C66x or C67x family of DSP cores as the main execution unit. The IPU processor
>>>> +sub-system usually contains either a Dual-Core Cortex-M3 or Dual-Core Cortex-M4
>>>> +processors.
>>>> +
>>>> +Remote Processor Node:
>>>> +======================
>>>> +Each remote processor sub-system is represented as a single DT node. Each node
>>>> +has a number of required or optional properties that enable the OS running on
>>>> +the host processor (MPU) to perform the device management of the remote
>>>> +processor and to communicate with the remote processor. The various properties
>>>> +can be classified as constant or variable. The constant properties are dictated
>>>> +by the SoC and does not change from one board to another having the same SoC.
>>>> +Examples of constant properties include 'iommus', 'reg'. The variable properties
>>>> +are dictated by the system integration aspects such as memory on the board, or
>>>> +configuration used within the corresponding firmware image. Examples of variable
>>>> +properties include 'mboxes', 'memory-region', 'timers', 'watchdog-timers' etc.
>>>> +
>>>> +Required properties:
>>>> +--------------------
>>>> +The following are the mandatory properties:
>>>> +
>>>> +- compatible:       Should be one of the following,
>>>> +                "ti,omap4-dsp" for DSPs on OMAP4 SoCs
>>>> +                "ti,omap5-dsp" for DSPs on OMAP5 SoCs
>>>> +                "ti,dra7-dsp" for DSPs on DRA7xx/AM57xx SoCs
>>>> +                "ti,omap4-ipu" for IPUs on OMAP4 SoCs
>>>> +                "ti,omap5-ipu" for IPUs on OMAP5 SoCs
>>>> +                "ti,dra7-ipu" for IPUs on DRA7xx/AM57xx SoCs
>>>> +
>>>> +- iommus:   phandles to OMAP IOMMU nodes, that need to be programmed
>>>> +            for this remote processor to access any external RAM memory or
>>>> +            other peripheral device address spaces. This property usually
>>>> +            has only a single phandle. Multiple phandles are used only in
>>>> +            cases where the sub-system has different ports for different
>>>> +            sub-modules within the processor sub-system (eg: DRA7 DSPs),
>>>> +            and need the same programming in both the MMUs.
>>
>> ^ the target of this is not in schema.
> 
> You mean the OMAP IOMMU binding? That doesn't matter at all.

Yeah, OMAP IOMMU.

Ok, if it does not matter, I will just convert this all. Will send v2 
once I am done.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
