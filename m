From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2 01/22] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
Date: Fri, 17 Feb 2017 11:39:39 +0000
Message-ID: <03f543b5-ae86-47cc-e3cf-e3b5cfff5ee4@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-2-git-send-email-kishon@ti.com>
 <ece23395-7ebc-c9f3-bd9f-4f24e44d763a@synopsys.com> <58A6E05D.5010803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <58A6E05D.5010803@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Às 11:37 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
> Hi Joao,
> 
> On Friday 17 February 2017 04:56 PM, Joao Pinto wrote:
>>
>> Hi Kishon,
>>
>> Às 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>>> Introduce a new EP core layer in order to support endpoint functions
>>> in linux kernel. This comprises of EPC library
>>> (Endpoint Controller Library) and EPF library (Endpoint
>>> Function Library). EPC library implements functions that is specific
>>> to an endpoint controller and EPF library implements functions
>>> that is specific to an endpoint function.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/Makefile                    |    2 +
>>>  drivers/pci/Kconfig                 |    1 +
>>>  drivers/pci/endpoint/Kconfig        |   21 ++
>>>  drivers/pci/endpoint/Makefile       |    6 +
>>>  drivers/pci/endpoint/pci-epc-core.c |  548 +++++++++++++++++++++++++++++++++++
>>>  drivers/pci/endpoint/pci-epc-mem.c  |  143 +++++++++
>>>  drivers/pci/endpoint/pci-epf-core.c |  347 ++++++++++++++++++++++
>>>  include/linux/mod_devicetable.h     |   10 +
>>>  include/linux/pci-epc.h             |  141 +++++++++
>>>  include/linux/pci-epf.h             |  160 ++++++++++
>>>  10 files changed, 1379 insertions(+)
>>>  create mode 100644 drivers/pci/endpoint/Kconfig
>>>  create mode 100644 drivers/pci/endpoint/Makefile
>>>  create mode 100644 drivers/pci/endpoint/pci-epc-core.c
>>>  create mode 100644 drivers/pci/endpoint/pci-epc-mem.c
>>>  create mode 100644 drivers/pci/endpoint/pci-epf-core.c
>>>  create mode 100644 include/linux/pci-epc.h
>>>  create mode 100644 include/linux/pci-epf.h
>>>
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index f521cb0..a300bb1 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -14,7 +14,9 @@ obj-$(CONFIG_GENERIC_PHY)	+= phy/
>>>  obj-$(CONFIG_PINCTRL)		+= pinctrl/
>>>  obj-$(CONFIG_GPIOLIB)		+= gpio/
>>>  obj-y				+= pwm/
>>> +
>>>  obj-$(CONFIG_PCI)		+= pci/
>>> +obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
>>>  # PCI dwc controller drivers
>>>  obj-y				+= pci/dwc/
>>
>> Any special reason to include pci/endpoint and pci/dwc in drivers/Makefile
>> instead of being inside pci/Makefile? pci/host is still inside pci/Makefile.
> 
> CONFIG_PCI enables all the pcie host support. Endpoint support should be
> enabled independent of the host support. Moving pci/endpoint inside
> pci/Makefile will build endpoint support only if CONFIG_PCI is enabled. For the
> same reason kept pci/dwc in drivers/Makefile since dwc drivers can be used
> either in host mode or device mode (or both).

Good point! Very well.

Acked-By: Joao Pinto <jpinto@synopsys.com>

> 
> Thanks
> Kishon
> 

