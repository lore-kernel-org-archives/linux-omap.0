From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/24] dt-bindings: PCI: Document "atu" reg-names
Date: Mon, 21 Jan 2019 18:48:06 -0600
Message-ID: <20190122004806.GA32204@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-10-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-10-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 14, 2019 at 06:54:09PM +0530, Kishon Vijay Abraham I wrote:
> Document "atu" reg-names required to get the register space for ATU in
> Synopsys designware core version >= 4.80.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index c124f9bc11f3..5561a1c060d0 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -4,8 +4,11 @@ Required properties:
>  - compatible:
>  	"snps,dw-pcie" for RC mode;
>  	"snps,dw-pcie-ep" for EP mode;
> -- reg: Should contain the configuration address space.
> -- reg-names: Must be "config" for the PCIe configuration space.
> +- reg: For designware cores version < 4.80 contains the configuration
> +       address space. For designware core version >= 4.80, contains
> +       the configuration and ATU address space
> +- reg-names: Must be "config" for the PCIe configuration space and "atu" for
> +	     the ATU address space.

I'm pretty sure we already have other platforms with an ATU. Those all 
just represent it with the other ctrl registers? So maybe this is TI 
specific that it is separate. Or should have some conditional like 'if 
the ATU space is separate, the reg-name should be atu'.

>      (The old way of getting the configuration address space from "ranges"
>      is deprecated and should be avoided.)
>  - num-lanes: number of lanes to use
> -- 
> 2.17.1
> 
