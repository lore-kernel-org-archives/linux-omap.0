From: Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 11/37] PCI: dwc: Split pcie-designware.c into host and
 core files
Date: Mon, 16 Jan 2017 13:38:07 +0000
Message-ID: <018295b9-00a1-1164-8af1-a01924fa931e@synopsys.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-12-git-send-email-kishon@ti.com>
 <4a89fb45-af84-d660-5ef0-12227b141cda@synopsys.com> <587C586C.6070003@ti.com>
 <0a16c862-312f-655e-3d66-bdb0c1f78584@synopsys.com> <587CAEBD.1010803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <587CAEBD.1010803-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-VrBV9hrLPhE@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Às 11:30 AM de 1/16/2017, Kishon Vijay Abraham I escreveu:
> Hi Joao,
> 
> On Monday 16 January 2017 03:57 PM, Joao Pinto wrote:
>>
>> Hi,
>>
>> Às 5:21 AM de 1/16/2017, Kishon Vijay Abraham I escreveu:
>>> Hi Joao,
>>>
>>> On Friday 13 January 2017 10:19 PM, Joao Pinto wrote:
>>>> Às 10:26 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
>>>>> Split pcie-designware.c into pcie-designware-host.c that contains
>>>>> the host specific parts of the driver and pcie-designware.c that
>>>>> contains the parts used by both host driver and endpoint driver.
>>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>  drivers/pci/dwc/Makefile               |    2 +-
>>>>>  drivers/pci/dwc/pcie-designware-host.c |  619 ++++++++++++++++++++++++++++++++
>>>>>  drivers/pci/dwc/pcie-designware.c      |  613 +------------------------------
>>>>>  drivers/pci/dwc/pcie-designware.h      |    8 +
>>>>>  4 files changed, 634 insertions(+), 608 deletions(-)
>>>>>  create mode 100644 drivers/pci/dwc/pcie-designware-host.c
>>>>>
>>>>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>>>>> index 7d27c14..3b57e55 100644
>>>>> --- a/drivers/pci/dwc/Makefile
>>>>> +++ b/drivers/pci/dwc/Makefile
>>>>> @@ -1,4 +1,4 @@
>>>>
>>>> (snip...)
>>>>
>>>>> -static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>>>> -				      int type, u64 cpu_addr, u64 pci_addr,
>>>>> -				      u32 size)
>>>>> +void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>>>>> +			       u64 cpu_addr, u64 pci_addr, u32 size)
>>>>>  {
>>>>>  	u32 retries, val;
>>>>>  
>>>>> @@ -186,220 +151,6 @@ static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>>>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>>>>  }
>>>>
>>>> Kishon, iATU only makes sense in The Root Complex (host), so it should be inside
>>>> the pcie-designware-host.
>>>
>>> That is not true. Outbound ATU should be programmed to access host side buffers
>>> and inbound ATU should be programmed for the host to access EP mem space.
>>
>> Sorry, I was not clear enough. What I was trying to suggest is, since the ATU
>> programming is done by the host, wouldn't be better to include it in the
>> pcie-designware-host? It is just an architectural detail.
> 
> ATU programming is required in EP mode. See "[PATCH 24/37] PCI: dwc:
> designware: Add EP mode support" in this patch series.
> 
> Anything that's required by both EP mode and RC mode, I've placed in
> pcie-designware.c

Agreed!

> 
> Thanks
> Kishon
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
