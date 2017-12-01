From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] pci-dra7xx: Fix legacy IRQ handling and errata
 handling
Date: Fri, 1 Dec 2017 11:45:55 +0530
Message-ID: <2d17f318-d581-1300-16dc-ea8c2e1a83d0@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171201061311.16691-1-vigneshr-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Chris Welch <Chris.Welch-ojoHHoaXhABCkLs28/y7ANBPR1lH4CV8@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 01 December 2017 11:43 AM, Vignesh R wrote:
> This series contains two fixes:
> 1. Make workaround for errata i870 applicable in Host mode as
> well(previously it was enabled only for EP mode) as per errata
> documentation: http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
> 2. Fix problem with handling of legacy INTD interrupts.
> 
> Tested on 66AK2G EVM and ICE boards
> 

Oops, sorry, I meant tested on DRA74 EVM and AM572 GP EVM here.

> 
> Vignesh R (4):
>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>     mode
>   ARM: dts: dra7: Add DT property to allow unaligned mem access to PCIe
>     RC
>   PCI: dwc: pci-dra7xx: Fix legacy IRQ handling
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>  arch/arm/boot/dts/dra7.dtsi                      |  2 ++
>  drivers/pci/dwc/pci-dra7xx.c                     | 23 ++++++++++++++---------
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
