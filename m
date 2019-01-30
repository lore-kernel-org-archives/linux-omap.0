From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: dra7xx: Add properties to
 enable x2 lane in dra7
Date: Wed, 30 Jan 2019 10:42:59 -0600
Message-ID: <20190130164259.GA4191@bogus>
References: <20190124082957.29077-1-kishon@ti.com>
 <20190124082957.29077-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124082957.29077-3-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 24 Jan 2019 13:59:56 +0530, Kishon Vijay Abraham I wrote:
> Add syscon properties required for configuring PCIe in x2 lane mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
