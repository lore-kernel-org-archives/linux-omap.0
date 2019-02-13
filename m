From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
Date: Wed, 13 Feb 2019 19:14:24 +0530
Message-ID: <fcfba221-5e68-1e70-8044-de8390d05559@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
 <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
 <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Lorenzo,

On 13/02/19 7:08 PM, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 12/02/19 8:37 PM, Lorenzo Pieralisi wrote:
>> On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:
>>
>> [...]
>>
>>>  static int pci_epf_test_bind(struct pci_epf *epf)
>>>  {
>>>  	int ret;
>>>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>  	struct pci_epf_header *header = epf->header;
>>> +	const struct pci_epc_features *epc_features;
>>> +	enum pci_barno test_reg_bar = BAR_0;
>>>  	struct pci_epc *epc = epf->epc;
>>>  	struct device *dev = &epf->dev;
>>> +	bool linkup_notifier = false;
>>> +	bool msix_capable = false;
>>> +	bool msi_capable = true;
>>>  
>>>  	if (WARN_ON_ONCE(!epc))
>>>  		return -EINVAL;
>>>  
>>> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
>>> -		epf_test->linkup_notifier = false;
>>> -	else
>>> -		epf_test->linkup_notifier = true;
>>> -
>>> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
>>> +	epc_features = pci_epc_get_features(epc, epf->func_no);
>>
>> I think it would work out better if struct pci_epc_features was
>> allocated in the caller (stack) and pci_epc_get_features() take a
>> pointer parameter to it rather than the callee and the callee would just
>> have to fill it out, this also removes data in the driver that is not
>> really useful.
>>
>> Is there any other reason behind the current design choice ?
> 
> Some drivers are used by multiple platforms each with different features. In
> such cases it's cleaner to have separate epc_feature table for each platform.
> 
> I think the driver should maintain some sort of data to even populate
> pci_epc_features allocated by EP function driver.

Btw I found some issues in the v1 of this series, so I posted v2 [1]. Please
review that.

Thanks
Kishon

[1] -> https://lkml.org/lkml/2019/1/14/288
> 
> Thanks
> Kishon
> 
