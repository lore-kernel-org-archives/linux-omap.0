From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] pci: host: pci-dra7xx: Enable x2 mode support
Date: Thu, 7 Jan 2016 11:51:33 +0530
Message-ID: <568E03ED.9030207@ti.com>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
 <1452077393-25880-3-git-send-email-kishon@ti.com>
 <20160106141324.GA24713@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160106141324.GA24713@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 06 January 2016 07:43 PM, Rob Herring wrote:
> On Wed, Jan 06, 2016 at 04:19:53PM +0530, Kishon Vijay Abraham I wrote:
>> Perform syscon configurations to get x2 mode to working in DRA74x and
>> DRA72x. Also add a new compatible string to dfferentiate
>> DRA72x and DRA74x, since b1c0 mask is different for both these platforms.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 ++-
>>  drivers/pci/host/pci-dra7xx.c                    |   81 +++++++++++++++++++++-
>>  2 files changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 60e2516..0b10e84 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -1,7 +1,9 @@
>>  TI PCI Controllers
>>  
>>  PCIe Designware Controller
>> - - compatible: Should be "ti,dra7-pcie""
>> + - compatible: "ti,dra7-pcie" is deprecated
>> +	       Should be "ti,dra746-pcie" for DRA74x
>> +	       Should be "ti,dra726-pcie" for DRA72x
>>   - reg : Two register ranges as listed in the reg-names property
>>   - reg-names : The first entry must be "ti-conf" for the TI specific registers
>>  	       The second entry must be "rc-dbics" for the designware pcie
>> @@ -14,6 +16,10 @@ PCIe Designware Controller
>>  	       where <X> is the instance number of the pcie from the HW spec.
>>   - interrupts : Two interrupt entries must be specified. The first one is for
>>  		main interrupt line and the second for MSI interrupt line.
>> + - syscon-lane-conf : phandle/offset pair. Phandle to the system control module and the
>> +   register offset to specify 1 lane or 2 lane.
>> + - syscon-lane-sel : phandle/offset pair. Phandle to the system control module and the
>> +   register offset to specify lane selection.
> 
> These should have a ti prefix.

Okay. Will fix that and post a new version.

Thanks
Kishon
> 
>>   - #address-cells,
>>     #size-cells,
>>     #interrupt-cells,
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
