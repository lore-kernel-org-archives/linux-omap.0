From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 12/26] PCI: keystone: Prevent ARM32 specific code to
 be compiled for ARM64
Date: Fri, 12 Apr 2019 10:31:54 +0100
Message-ID: <20190412093154.7wj4dmm3oppvv32m@shell.armlinux.org.uk>
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, devicetree@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Rob Herring <robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>, linux-omap@vger.kernel.org, Roy Zang <roy.zang@nxp.com>, linux-arm-kernel@lists.infradead.org
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
> At least in AM654 platform, I don't see a bus error when PCIe device is not
> connected but returns 0xffffffff. So there is no necessary for hook_fault_code
> in AM654 platform.

... which needs to be explained somewhere, either in the commit
message or comments in the file, so that years later when someone
has to look at this code, they know why it is the way that it is.

When writing commits, please think about whether there is enough
information to understand the change in ten years time.

> 
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
