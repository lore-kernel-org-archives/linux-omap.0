From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 07/24] dt-bindings: PCI: Add dt-binding to configure PCIe
 mode
Date: Mon, 21 Jan 2019 18:32:30 -0600
Message-ID: <20190122003230.GA32048@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-8-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-8-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

On Mon, 14 Jan 2019 18:54:07 +0530, Kishon Vijay Abraham I wrote:
> Add "ti,syscon-pcie-mode" dt-binding to hold phandle to the syscon
> register that should be used to configure PCIe in RC mode or EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
