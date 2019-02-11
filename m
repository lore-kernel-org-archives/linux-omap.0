From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
Date: Mon, 11 Feb 2019 17:37:32 +0000
Message-ID: <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114111513.21618-9-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
> Base Address Register irrespective of the size. Fix it here to indicate
> 64-bit BAR if the size is > 2GB.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This looks like a fix and should me marked as such. Does it work
as as standalone patch if it gets backported ?

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 825fa24427a3..8bfdcd291196 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -131,7 +131,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>  	epf->bar[bar].phys_addr = phys_addr;
>  	epf->bar[bar].size = size;
>  	epf->bar[bar].barno = bar;
> -	epf->bar[bar].flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
> +	epf->bar[bar].flags |= upper_32_bits(size) ?
> +				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +				PCI_BASE_ADDRESS_MEM_TYPE_32;
>  
>  	return space;
>  }
> -- 
> 2.17.1
> 
