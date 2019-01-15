From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
Date: Tue, 15 Jan 2019 09:52:41 +0800
Message-ID: <29d44805-9cfb-450c-e7b3-7556dc36fc40@rock-chips.com>
References: <20190114111513.21618-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 2019/1/14 19:14, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>    *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>       AM654 uses Designware configuration with fixed size BAR). The
>       size of each BARs cannot be passed to the endpoint function
>       driver.
>    *) Too many macros for handling EPC features.
>       (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>        EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>        EPC_FEATURE_GET_BAR)
>    *) Endpoint controllers are directly modifying struct pci_epc
>       members. (I have plans to move struct pci_epc to
>       drivers/pci/endpoint so that pci_epc members are referenced
>       only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Changes from v1:
> *) Fixed helper function to return '0' (or BAR_0) for any incorrect
>     values in reserved BAR.
> *) Do not set_bar or alloc space for BARs if the BARs are reserved
> *) Fix incorrect check of epc_features in pci_epf_test_bind
> 
> Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
> in AM654 platform will be posted shortly.
> 


----8<-----

>   drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
