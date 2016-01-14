From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Thu, 14 Jan 2016 18:58:25 +0530
Message-ID: <5697A279.3020506@ti.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
 <1452667666-17533-4-git-send-email-kishon@ti.com> <56968EA6.2060408@ti.com>
 <56975E5D.50603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56975E5D.50603@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 14 January 2016 02:07 PM, Kishon Vijay Abraham I wrote:
> Hi Suman,
> 
> On Wednesday 13 January 2016 11:21 PM, Suman Anna wrote:
>> On 01/13/2016 12:47 AM, Kishon Vijay Abraham I wrote:
>>> Use platform populated reset assert and deassert
>>> callbacks to perform reset of PCIe.
>>>
>>> Use these callbacks until a reset interface using drivers/reset
>>> is available for the purpose.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>>  drivers/pci/host/pci-dra7xx.c |   32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>>> index 8c36880..049083d 100644
>>> --- a/drivers/pci/host/pci-dra7xx.c
>>> +++ b/drivers/pci/host/pci-dra7xx.c
>>> @@ -25,6 +25,8 @@
>>>  #include <linux/resource.h>
>>>  #include <linux/types.h>
>>>  
>>> +#include <linux/platform_data/pci-dra7xx.h>
>>> +
>>>  #include "pcie-designware.h"
>>>  
>>>  /* PCIe controller wrapper DRA7XX configuration registers */
>>> @@ -329,6 +331,32 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>>  	return 0;
>>>  }
>>>  
>>> +static int dra7xx_pcie_reset(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct pci_dra7xx_platform_data *pdata = pdev->dev.platform_data;
>>> +
>>> +	if (!(pdata && pdata->deassert_reset && pdata->assert_reset)) {
>>> +		dev_err(dev, "platform data for reset not found!\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = pdata->assert_reset(pdev, pdata->reset_name);
>>> +	if (ret) {
>>> +		dev_err(dev, "assert_reset failed: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = pdata->deassert_reset(pdev, pdata->reset_name);
>>> +	if (ret) {
>>> +		dev_err(dev, "deassert_reset failed: %d\n", ret);
>>> +		return ret;
>>> +	}
>>
>> The only comment I have on this is the symmetry (assert_reset invocation
>> in driver remove). If you install and remove the module once, then the
>> reset stays deasserted. On Power-On-Reset, the resets by default will be
>> in asserted state.
> 
> hmm.. not sure of the benefits of leaving the reset lines de-asserted during
> remove. The idea is irrespective of the initial sate or power-on state, during
> probe the driver should assert and de-assert the reset lines.

Also right now the pci-dra7xx can't be inserted as a module. However since that
might be added in the future, I'll add assert_reset in the remove path of this
driver.

Thanks
Kishon
