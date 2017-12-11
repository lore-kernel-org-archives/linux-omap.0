From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] PCI: dwc: pci-dra7xx: Fix legacy IRQ handling
Date: Mon, 11 Dec 2017 10:12:52 +0530
Message-ID: <f2f05d1d-c3a7-1a27-75ca-3fdc623b07bb@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-5-vigneshr@ti.com>
 <20171208183523.GB1885@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171208183523.GB1885-4tUPXFaYRHv6sAKXYmQ0tx/iLCjYCKR+VpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Saturday 09 December 2017 12:05 AM, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 11:43:11AM +0530, Vignesh R wrote:
>> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
>> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
>> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
>> pci-dra7xx driver following warning is seen:
>>
>>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
>>        error: hwirq 0x4 is too large for dummy
>>
>> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
>> range into the 0-3 as done in other PCIe drivers.
>>
>> Also, iterate over all the INTx bits and call their respective IRQ
>> handlers before clearing the status register.
> 
> It seems to me that you are fixing two bugs with one patch and therefore
> I would ask you to split it in two or explain to me why we should
> consider lumping them together.
> 

Ok, I will split the patch into two in v2.


-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
