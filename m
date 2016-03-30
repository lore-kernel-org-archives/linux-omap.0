From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Wed, 30 Mar 2016 16:52:13 +0300
Message-ID: <56FBDA0D.4030507@ti.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
 <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
 <87mvpgi02f.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mvpgi02f.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>, "Thang Q. Nguyen" <tqnguyen@apm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

On 03/30/2016 04:10 PM, Felipe Balbi wrote:
> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
> 
>> [ text/plain ]
>> From: "Thang Q. Nguyen" <tqnguyen@apm.com>
>>
>> The xhci-hcd child node needs to inherit archdata attribute to use
>> dma_ops functions and attributes. This patch enables the USB DWC3
>> driver to pass archdata attributes to its xhci-hcd child node.
>>
>> Changes from v2:
>> 	- None
>>
>> Changes from v1:
>> 	- None
> 
> changes should be between tearline and diffstat.
> 

uh. This become a real problem :(, especially with LPAE enabled.
DMA properties need to be inherited not only here, but also in
usb_add_gadget_udc_release(). And probably in other places
 where devices are created manually - the worst case : device is created
manually but doesn't belong to any bus.

And DMA configuration must include dma_pfn_offset also!
And how about iommu staff?

FYI. Solution used for PCI
c49b8fc of/pci: Add of_pci_dma_configure() to update DMA configuration

Rejected: introduce dma_init_dev_from_parent() or smth. like this
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/378317
https://lkml.org/lkml/2014/11/4/519


-- 
regards,
-grygorii
