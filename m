From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in
 dra7xx_pcie_init_irq_domain()
Date: Fri, 11 Nov 2016 15:38:06 -0600
Message-ID: <20161111213806.GI9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 17, 2016 at 02:54:37PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> This node pointer is returned by of_get_next_child() with refcount
> incremented in this function. of_node_put() on it before exitting
> this function on error.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Kishon, this looks correct to me, so I applied it to pci/host-dra7xx for
v4.10.  Let me know if you have any issue with it.

> ---
>  drivers/pci/host/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 9595fad..79297e9 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>  					       &intx_domain_ops, pp);
>  	if (!pp->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		of_node_put(pcie_intc_node);
>  		return -ENODEV;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
