From: Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH 1/3] Revert "PCI: dwc: Clear MSI interrupt status after
 it is handled, not before"
Date: Fri, 9 Feb 2018 14:46:29 +0100
Message-ID: <20180209134629.GA25931@axis.com>
References: <20180209120415.17590-1-vigneshr@ti.com>
 <20180209120415.17590-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180209120415.17590-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 09, 2018 at 05:34:13PM +0530, Vignesh R wrote:
> Since commit 06e15e6883bed ("PCI: dwc: Clear MSI interrupt status after
> it is handled, not before"), MSI IRQ status in PCIE_MSI_INTR0_STATUS
> register is cleared after calling EP's IRQ handler.

Small nit, the SHA1 is actually:
8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")

Acked-by: Niklas Cassel <niklas.cassel@axis.com>
