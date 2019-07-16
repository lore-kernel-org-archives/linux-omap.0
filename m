From: Bjorn Helgaas <helgaas@kernel.org>
Subject: PCI: dra7xx: PCI_EXP_LNKCTL2 usage
Date: Tue, 16 Jul 2019 08:59:23 -0500
Message-ID: <20190716135923.GA4470@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ab5fe4f4d31e ("PCI: dra7xx: Add support to force RC to work in GEN1 mode")
added this:

  +       dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
  +                        2, &reg);
  +       if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
  +               reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
  +               reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
  +               dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
  +                                 PCI_EXP_LNKCTL2, 2, reg);
  +       }

This probably works as intended, but it *looks* wrong because it uses
LNKCAP_* symbols on LNKCTL2 register values.  We do have
PCI_EXP_LNKCTL2_* symbols, so I think it would be better if we used
used those.

Bjorn
