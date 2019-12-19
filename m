From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Date: Thu, 19 Dec 2019 18:19:07 +0530
Message-ID: <bf31d43f-6a58-c94c-b7d4-8f0ae97e9602@ti.com>
References: <20191217233651.GA3930@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217233651.GA3930@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 18/12/19 5:06 am, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allow only 32-bit register accesses.
>> Add read and write accessors to perform only 32-bit accesses in order to
>> support platfroms like TI's J721E.
> 
> s/platfroms/platforms/
> 
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
>> +{
>> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
>> +	unsigned int offset = (unsigned long)addr & 0x3;
>> +	u32 val = readl(aligned_addr);
>> +
>> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> +		pr_err("Invalid Address in function:%s\n", __func__);
> 
> It might be nice to have a hint about *why* it's invalid, e.g., the
> addr and size values.

Sure.

Thanks
Kishon
