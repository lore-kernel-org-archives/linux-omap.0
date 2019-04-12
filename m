From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 12/26] PCI: keystone: Prevent ARM32 specific code to
 be compiled for ARM64
Date: Fri, 12 Apr 2019 12:11:56 +0100
Message-ID: <20190412111156.GE8113@red-moon>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-13-kishon@ti.com>
 <20190411150332.GC6862@red-moon>
 <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 12, 2019 at 02:20:06PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 11/04/19 8:33 PM, Lorenzo Pieralisi wrote:
> > On Mon, Mar 25, 2019 at 03:09:33PM +0530, Kishon Vijay Abraham I wrote:
> >> hook_fault_code is an ARM32 specific API for hooking into data abort.
> >> Since pci-keystone.c will be used for AM65X platforms which is an
> >> ARM64 platform,
> > 
> > Hi Kishon,
> > 
> > How is the problem plugged by the fault hook fixed on ARM64 ?
> 
> At least in AM654 platform, I don't see a bus error when PCIe device
> is not connected but returns 0xffffffff. So there is no necessary for
> hook_fault_code in AM654 platform.

That can't have much to do with ARM32<->ARM64, it is rather a platform
integration issue AFAICS. Russell has a point, this has to be documented
I can do it for you but I need additional information.

Thanks,
Lorenzo

> Thanks
> Kishon
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >> allow hook_fault_code to be compiled only for ARM32.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index dfe54553d832..93296d434f40 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -710,6 +710,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  	return ret;
> >>  }
> >>  
> >> +#ifdef CONFIG_ARM
> >>  /*
> >>   * When a PCI device does not exist during config cycles, keystone host gets a
> >>   * bus error instead of returning 0xffffffff. This handler always returns 0
> >> @@ -729,6 +730,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
> >>  
> >>  	return 0;
> >>  }
> >> +#endif
> >>  
> >>  static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
> >>  {
> >> @@ -778,12 +780,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
> >>  	if (ret < 0)
> >>  		return ret;
> >>  
> >> +#ifdef CONFIG_ARM
> >>  	/*
> >>  	 * PCIe access errors that result into OCP errors are caught by ARM as
> >>  	 * "External aborts"
> >>  	 */
> >>  	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
> >>  			"Asynchronous external abort");
> >> +#endif
> >>  
> >>  	ks_pcie_start_link(pci);
> >>  	dw_pcie_wait_for_link(pci);
> >> -- 
> >> 2.17.1
> >>
