From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
Date: Wed, 25 Jan 2017 11:10:53 +0530
Message-ID: <58883A65.8020306@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
 <20170124160224.GA23528@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124160224.GA23528-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-VrBV9hrLPhE@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 24 January 2017 09:32 PM, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCI endpoint test driver that can verify base address
>> register, legacy interrupt/MSI interrupt and read/write/copy
>> buffers between host and device. The corresponding pci-epf-test
>> function driver should be used on the EP side.
> 
> Just curious:  what would you think of a text based (e.g. debugfs)
> interface to avoid the need for a userspace tool here?

I felt having a userspace tool gives the flexibility to add more tests
(iterations, sizes etc..) while the driver can just focus on performing simple
tests. Say we'd like to perform infinite read/write tests, it's better if the
userspace tool invokes read/write tests repeatedly instead of that being
implemented in the driver.
> 
>> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
> Also this looks really odd, and dangerous.  Probing for any
> TI device will bind to all kinds of legit devices.  It would
> be good if you could squeeze out a single id for this device

There is actually an id for the device, but I think we'll need an id for every
function right?

Having said that the id for the device is better than PCI_ANY_ID. Will fix it
in my next revision.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
