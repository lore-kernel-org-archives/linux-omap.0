From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RESEND PATCHv4 01/14] dt-bindings: remoteproc: Add OMAP
 remoteproc bindings
Date: Thu, 16 Jan 2020 16:00:09 +0200
Message-ID: <47ece31c-53d5-2ec8-8047-86f6ad532c37@ti.com>
References: <20200102131845.12992-2-t-kristo@ti.com>
 <20200102132512.13248-1-t-kristo@ti.com>
 <f4ac066a-e5ee-f888-42bb-3f6d444747ee@ti.com>
 <1d4597f7-9e28-8b16-7679-c8abd291346d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36926 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAPOAP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jan 2020 09:00:15 -0500
In-Reply-To: <1d4597f7-9e28-8b16-7679-c8abd291346d@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

On 16/01/2020 09:51, Tero Kristo wrote:
> On 08/01/2020 18:49, Suman Anna wrote:
>> Hi Tero,
>>
>> On 1/2/20 7:25 AM, Tero Kristo wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> Add the device tree bindings document for the IPU and DSP
>>> remote processor devices on OMAP4+ SoCs.
>>>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> [t-kristo@ti.com: converted to schema]
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>> v4: added ti,bootreg-shift and ti,autosuspend-delay properties
>>
>> You missed out on my v3 comment on the firmware-name on Example 2. Can
>> you please address it when you post the next version?
> 
> I don't think I missed it, but you never told what is the actual name to 
> use there. Firmware name generally does not matter, as user can provide 
> whatever he wants via DT now.

Just to close on this, so the issue was file extension for the firmware 
name being .xem when it should have been .xem4. Fixed in v5 now.

-Tero

> 
>>
>>>
>>>   .../remoteproc/ti,omap-remoteproc.yaml        | 329 ++++++++++++++++++
>>>   1 file changed, 329 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml 
>>>
>>> new file mode 100644
>>> index 000000000000..f53d58efaae3
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
>>
>> [snip]
>>
>>> +  - |+
>>> +
>>> +    //Example 2: OMAP5 IPU
>>> +
>>> +    /* IPU Reserved Memory node */
>>> +    #include <dt-bindings/clock/omap5.h>
>>> +    reserved-memory {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        ipu_memory_region: ipu-memory@95800000 {
>>> +            compatible = "shared-dma-pool";
>>> +            reg = <0 0x95800000 0 0x3800000>;
>>> +            reusable;
>>> +        };
>>> +    };
>>> +
>>> +    /* IPU node */
>>> +    ocp {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        ipu: ipu@55020000 {
>>> +            compatible = "ti,omap5-ipu";
>>> +            reg = <0x55020000 0x10000>;
>>> +            reg-names = "l2ram";
>>> +            iommus = <&mmu_ipu>;
>>> +            mboxes = <&mailbox &mbox_ipu>;
>>> +            memory-region = <&ipu_memory_region>;
>>> +            ti,timers = <&timer3>, <&timer4>;
>>> +            ti,watchdog-timers = <&timer9>, <&timer11>;
>>> +            clocks = <&ipu_clkctrl OMAP5_MMU_IPU_CLKCTRL 0>;
>>> +            resets = <&prm_core 2>;
>>> +            firmware-name = "omap5-ipu-fw.xem";
>>> +        };
>>> +    };
>>
>> regards
>> Suman
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
