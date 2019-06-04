From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC PATCH 26/30] MAINTAINERS: Add MAINTAINER entry for PCIe on
 TI's J721E SoC
Date: Tue, 4 Jun 2019 14:45:57 -0500
Message-ID: <20190604194557.GB84290@google.com>
References: <20190604131516.13596-1-kishon@ti.com>
 <20190604131516.13596-27-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604131516.13596-27-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Nit: the subject wastes a lot of space in the most valuable part (the
beginning).  Something like this would make "git log --oneline" more
useful:

  MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe

On Tue, Jun 04, 2019 at 06:45:12PM +0530, Kishon Vijay Abraham I wrote:
> Add MAINTAINER entry for PCIe on TI's J721E SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e..8a421949f335 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12122,13 +12122,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>  F:	drivers/pci/controller/dwc/*designware*
>  
> -PCI DRIVER FOR TI DRA7XX
> +PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>  L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
>  F:	drivers/pci/controller/dwc/pci-dra7xx.c
> +F:	drivers/pci/controller/pci-j721e.c
>  
>  PCI DRIVER FOR TI KEYSTONE
>  M:	Murali Karicheri <m-karicheri2@ti.com>
> -- 
> 2.17.1
> 
