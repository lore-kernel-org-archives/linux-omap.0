From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 0/3] PCI: dra7xx: Support PCIe x2 lane mode
Date: Thu, 31 Jan 2019 17:28:30 +0000
Message-ID: <20190131172830.GA31110@e107981-ln.cambridge.arm.com>
References: <20190124082957.29077-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 24, 2019 at 01:59:54PM +0530, Kishon Vijay Abraham I wrote:
> Previous version of the patch series can be found here [1]
> 
> Patch series adds support to enable x2 lane mode in dra74/dra76 and
> dra72 based boards in pci-dra7xx driver. It introduces new compatible
> strings in order to enable x2 lane mode support.
> 
> Changes from v2:
> *) Have a single syscon dt property for configuring x2 lanes
> *) Fix minor comments given by Lorenzo (falling back to 1 lane mode,
>    remove unused structure member).
> 
> Changes from v1:
> *) Added ti prefix to syscon-lane-conf and syscon-lane-sel as
>    suggested to Rob
> *) Merged "PCI: dwc: dra7xx: Add support for SoC specific compatible
>    strings" and "PCI: dwc: pci-dra7xx: Enable x2 mode support" into
>    a single patch.
> *) Fixed $subject as suggested by Bjorn
> *) Added x2 lane mode support for DRA72x
> 
> The dts changes and phy changes will be sent as a separate series.
> 
> [1] ->  https://lkml.org/lkml/2017/12/19/175
> 
> Kishon Vijay Abraham I (3):
>   dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
>   dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
>   PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x
> 
>  .../devicetree/bindings/pci/ti-pci.txt        | 11 ++-
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 77 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)

I have applied the series to pci/dwc for v5.1, thanks.

Lorenzo
