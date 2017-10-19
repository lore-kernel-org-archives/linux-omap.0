From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency
 between PCIe and PHY
Date: Thu, 19 Oct 2017 12:46:27 +0300
Message-ID: <60244e26-474f-7c80-87ef-348861c24406@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
 <20171009090338.26033-2-kishon@ti.com>
 <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
 <ac5b3f42-19a1-3f8d-3bb6-37d63c3574de@ti.com>
 <9dce2e30-a245-460d-a808-a733eaf7ffec@ti.com>
 <2375dfac-b68c-4a94-89ed-fb850ba5579f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2375dfac-b68c-4a94-89ed-fb850ba5579f@ti.com>
Content-Language: en-GB
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 18/10/17 15:12, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 10 October 2017 01:29 PM, Roger Quadros wrote:
>> On 10/10/17 10:42, Kishon Vijay Abraham I wrote:
>>> Roger,
>>>
>>> On Tuesday 10 October 2017 12:49 PM, Roger Quadros wrote:
>>>> On 09/10/17 12:03, Kishon Vijay Abraham I wrote:
>>>>> PCI core access configuration space registers in resume_noirq callbacks.
>>>>> In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
>>>>> enabled before accessing configuration space registers. Since
>>>>> PIPE3 PHY is enabled by only configuring control module registers, no
>>>>> aborts has been observed so far (though during noirq stage, interface
>>>>> clock of PIPE3 PHY is not enabled).
>>>>>
>>>>> With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
>>>>> registers has to be accessed) as well which requires the interface
>>>>> clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
>>>>> derived from OCP2SCP and hence PCIe PHY is modeled as a child of
>>>>> OCP2SCP. Since pm_runtime is not enabled during noirq stage,
>>>>> pm_runtime_get_sync done in phy_init doesn't enable
>>>>> OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
>>>>> accessed.
>>>>
>>>> This could be the case not only with PCIe but even with USB and SATA?
>>>
>>> right, if USB/SATA driver has no_irq callbacks then the same issue might occur.
>>
>> OK. Is this something that we should document in Documentation/phy.txt?
> 
> Yeah it could be but the dependency is not required for a lot of phy consumer
> drivers.

But they could add a no_irq callback in the future and then things break.

> Do you think it makes sense to create functional dependency between phy and
> it's consumers in phy_get?

I think making it generic makes more sense without placing restrictions on users.

> 
> Thanks
> Kishon
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
