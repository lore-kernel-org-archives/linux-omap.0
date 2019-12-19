From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Date: Thu, 19 Dec 2019 17:26:05 +0530
Message-ID: <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 16/12/19 8:19 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allow only 32-bit register accesses.
> 
> When I first read this I thought you meant only 32-bit accesses are allowed
> and not other sizes (such as 64-bit). However the limitation you address
> here is that the J721E allows only 32-bit *aligned* register accesses.

It's both, it allows only 32-bit aligned accesses and the size should be
only 32 bits. That's why I always use "readl" in the APIs below.
> 
> It would be helpful to make this clearer in the commit message.
> 
> You can also shorten the commit subject to 'PCI: cadence: Add read/write
> accessors for 32-bit aligned accesses' or similar.
> 
>> Add read and write accessors to perform only 32-bit accesses in order to
>> support platfroms like TI's J721E.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>> index cd795f6fc1e2..de5b3b06f2d0 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -7,6 +7,46 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> +u32 cdns_pcie_read32(void __iomem *addr, int size)
> 
> Given there is already a cdns_pcie_readl in pcie-cadence.h it may help
> to name this in a way that doesn't cause confusion. Here 32 is perhaps
> being used to suggest the size of the actual read performed, the
> maximum size of 'size' or the alignment.
> 
> 
>> +{
>> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
>> +	unsigned int offset = (unsigned long)addr & 0x3;
>> +	u32 val = readl(aligned_addr);
>> +
>> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> +		pr_err("Invalid Address in function:%s\n", __func__);
> 
> Would this be better as a BUG? Without a BUG this error could get ignored
> and yet the device may not behave as expected.

yeah.
> 
> 
>> +		return 0;
>> +	}
>> +
>> +	if (size > 2)
>> +		return val;
> 
> I think you make the assumption here that if size > 2 then it's 4. It could
> be 3 (though unlikely) in which case you'd want to fall through to the next
> line.

This assumption is used elsewhere too (e.g drivers/pci/access.c). I
generally don't prefer adding handlers for non-occurring error
scenarios, but If you insist I can fix that.

Thanks
Kishon
