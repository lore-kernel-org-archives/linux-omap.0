From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 14/26] PCI: keystone: Add support for PCIe RC in
 AM654x Platforms
Date: Sat, 13 Apr 2019 10:26:33 -0500
Message-ID: <20190413152633.GF126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-15-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-15-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:35PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for AM654x Platforms in pci-keystone.c

> +static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +
> +	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");

Drive-by nit: this is the first occurrence of dev_vdbg() in
drivers/pci, and while dev_vdbg() might be useful somewhere, I'm not
sure this is the place.

It took me 10 minutes of archaeology to figure out what it is and how
to use it.  Apparently it does nothing at all unless you define
VERBOSE_DEBUG, which can be set via Kconfig in a few cases:

  drivers/dma/Makefile:subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
  drivers/usb/dwc2/Makefile:ccflags-$(CONFIG_USB_DWC2_VERBOSE)    += -DVERBOSE_DEBUG
  drivers/usb/gadget/Makefile:subdir-ccflags-$(CONFIG_USB_GADGET_VERBOSE) += -DVERBOSE_DEBUG

but is more commonly set by adding "#define VERBOSE_DEBUG" manually
in a source file.  Neither one applies here, so I don't think this
actually does anything.

Anyway, I suspect this particular message would make a lot of sense as
a *comment*, but maybe not as a mysterious dev_vdbg() that never
actually does anything.

> +	return 0;
> +}
