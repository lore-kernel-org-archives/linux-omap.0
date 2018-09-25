From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 0/2] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Date: Tue, 25 Sep 2018 10:59:29 +0100
Message-ID: <20180925095929.GA29304@red-moon>
References: <20180925083024.6960-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925083024.6960-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 25, 2018 at 02:00:22PM +0530, Vignesh R wrote:
> Make workaround for errata i870 applicable in Host mode as
> well(previously it was enabled only for EP mode) as per errata
> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> Driver will continue to work with w/o applying errata in host mode when
> using older DT, to maintain backward compatibility.
> 
> Tested on DRA72 EVM
> 
> Changes since v4:
> Fail driver probe if DT binding is absent for EP(as it is in current
> code)
> 
> Changes since v3:
> Rebase onto latest next
> Drop DT patches from this series. They will be sent separately once
> driver changes in this series is merged.
> 
> Changes since v2:
> Reorder patch 2 to appear at the last.
> Collect all the ACKs
> 
> Changes since v1:
> Drop IRQ handling rework (will be sent out separately)
> 
> 
> Vignesh R (2):
>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>     mode
>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>  drivers/pci/controller/dwc/pci-dra7xx.c          | 11 ++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)

Applied to pci/dwc for v4.20, thanks.

Lorenzo
