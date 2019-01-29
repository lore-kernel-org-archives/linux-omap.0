From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 18/24] PCI: dwc: Fix dw_pcie_ep_find_capability to return
 correct capability offset
Date: Tue, 29 Jan 2019 15:49:51 +0530
Message-ID: <a3c7458b-f8e8-1f02-116b-3e9f4fbf00f3@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-19-kishon@ti.com>
 <13501c15-8f3d-604b-c4fc-bde3fb208745@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13501c15-8f3d-604b-c4fc-bde3fb208745@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>
List-Id: linux-omap@vger.kernel.org

Hi Gustavo,

On 29/01/19 2:55 PM, Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 14/01/2019 13:24, Kishon Vijay Abraham I wrote:
>> commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
>> adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
>> __dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.
>>
>> However if MSI or MSIX capability is the last capability (i.e there are
>> no additional items in the capabilities list and the Next Capability
>> Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
>> even though MSI or MSIX capability may be present. This is because of
>> incorrect ordering of "next_cap_ptr" check. Fix it here.
>>
>> Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index d5144781005b..cd51b008858c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>>  	u8 cap_id, next_cap_ptr;
>>  	u16 reg;
>>  
>> +	if (!cap_ptr)
>> +		return 0;
>> +
> 
> Supposedly this was already verified by the function that calls this one.

Right, with with this fix cap_ptr is checked only once. This being a recursive
function, it makes sense to have the check only here instead of once in the
calling function and once here.
> 
>>  	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> -	next_cap_ptr = (reg & 0xff00) >> 8;
>>  	cap_id = (reg & 0x00ff);
>>  
>> -	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>> +	if (cap_id > PCI_CAP_ID_MAX)
>>  		return 0;
>>  
>>  	if (cap_id == cap)
>>  		return cap_ptr;
>>  
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
> 
> This fix seems to be a bit overdone, especially when you only need to swap the
> if blocks order to achieve the desired goal.

No, cap_id > PCI_CAP_ID_MAX is a base error case and it should checked before
returning the offset IMO.
> 
>>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>>  }
>>  
>> @@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>>  	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>>  	next_cap_ptr = (reg & 0x00ff);
>>  
>> -	if (!next_cap_ptr)
>> -		return 0;
>> -
> 
> Why remove it?
> If pointer is null, why to jump to another function to check is the the same
> pointer is null?

so that we check cap_ptr only once.

Thanks
Kishon
