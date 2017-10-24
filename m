From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] of: Devices with pci_epf_bus_type require DMA
 configuration
Date: Tue, 24 Oct 2017 11:13:45 +0530
Message-ID: <64d63468-d28f-8fcd-a6f3-cf2a6401c8cb@ti.com>
References: <20171011080041.12918-1-kishon@ti.com>
 <cae4b8e9-9944-6482-c12c-8ce87aea1487@arm.com>
 <3599d3e2-d496-eac3-7179-2d1795fc059d@ti.com>
 <037082e6-5abe-daf9-47aa-9586a4aead99@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <037082e6-5abe-daf9-47aa-9586a4aead99-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 23 October 2017 06:35 PM, Robin Murphy wrote:
> On 23/10/17 06:43, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 11 October 2017 10:15 PM, Robin Murphy wrote:
>>> On 11/10/17 09:00, Kishon Vijay Abraham I wrote:
>>>> pci-epc-core.c invokes of_dma_configure in order to configure
>>>> the coherent_dma_mask/dma_mask of endpoint function device. This is
>>>> required for dma_alloc_coherent to succeed in pci function driver
>>>> (pci-epf-test.c). However after
>>>> commit 723288836628bc1c08 ("of: restrict DMA configuration"),
>>>> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
>>>> of endpoint function device (since it doesn't have dma-ranges
>>>> property), resulting in dma_alloc_coherent in pci endpoint function
>>>> driver to to fail. Fix it by making sure of_dma_configure configures
>>>> coherent_dma_mask/dma_mask irrespective of whether the node has
>>>> dma-ranges property or not.
>>>
>>> Frankly, what the endpoint stuff is doing looks wrong anyway. As I
>>> understand it, the endpoint functions aren't real devices, just a
>>> partitioning of resources - the only piece of hardware actually doing
>>> DMA is the EPC itself, which should already have been configured
>>> appropriately as a platform device.
>>
>> EPF devices use EPC devices which in turn use the actual platform device for
>> configuring the hardware. IMO the devices in one layer shouldn't have to
>> explicitly use devices in another layer other than using clearly defined API's.
>> Here platform_device is the bottom later, above which is epc_device and on top
>> is epf_device.
> 
> Note that the "sysdev"-type model that I'm implying already has
> precedent elsewhere, e.g. in the USB layer. Since you already have
> things abstracted behind the pci_epf_{alloc,free}_space() API, this
> seems like a simple change to make.

I got your point. The device in struct pci_epc is also a virtual device (it
doesn't have a driver associated with it). So we'll have to use something like
epf->epc->dev.parent to actually use the platform device.

It has a couple of indirections but it should be okay to change a couple of
API's I think. With that of_dma_configure can also be removed from
pci-epc-core.c. I'll send a patch fixing those.
> 
>> The idea is just by doing the initial setup in the framework, the epf driver be
>> able to use APIs like dma_alloc_coherent using it's own *device* rather than
>> the EPC's "device".
> 
> OK, but when would that actually happen? Please correct me if I've got
> it wrong, but as best I understand it, the hardware extent of the EPF is
> some registers controlling the config space that the EPC exposes to the
> other end of the PCI link - the only actual DMA happening will be in
> response to PCI traffic in and out of the EPF's BARs, between the EPC
> and the memory backing those BAR regions which is already controlled by
> your API. Sure, the EPF *driver* is free to access whatever memory it

That's correct. The allocated memory is used only using BARs.
> feels like, but as a software construct that doesn't constitute DMA.
> 
> To put it another way, if an endpoint driver *does* call
> dma_alloc_coherent(epf_device, ...), what does it then do with the
> resulting DMA address?
> 
>>> It seems to me that the EPF BAR allocations should just be using the EPC
>>> device directly, rather than trying to pretend the EPFs are distinct DMA
>>> masters.
>>>
>>> Furthermore, now that I've looked:
>>>
>>>> 	dma_addr_t phys_addr;
>>>
>>> please no :(
>>>
>>> (I can easily think of more than one system with an EP-capable DWC PCIe
>>> block integrated behind an IOMMU)
>>
>> hmm.. haven't used IOMMU but won't setting up parent-child relationship between
>> EPC and EPF help in the case of IOMMU?
> 
> I was merely referring to the characterisation throughout this code that
> a DMA address is a physical address; it isn't, for any number of reasons
> (IOMMUs are just the most obvious). Fortunately it's only a cosmetic
> naming problem, the actual usage looks OK.

right, that was named incorrectly.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
