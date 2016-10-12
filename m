From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/7] PCI: dra7xx: Cleanups
Date: Wed, 12 Oct 2016 08:32:31 -0500
Message-ID: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove redundant struct members.

  - Use generic DesignWare accessors when possible.

  - Pass device-specific struct to internal functions for consistency.

  - Move struct pcie_port setup to probe function for consistency.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: dra7xx: Rename accessors
    PCI: dra7xx: Name private struct pointer "dra7xx" consistently

---

Bjorn Helgaas (7):
      PCI: dra7xx: Add local struct device pointers
      PCI: dra7xx: Remove redundant struct device pointer from dra7xx_pcie
      PCI: dra7xx: Set drvdata at end of probe function
      PCI: dra7xx: Use generic DesignWare accessors
      PCI: dra7xx: Pass device-specific struct to internal functions
      PCI: dra7xx: Move struct pcie_port setup to probe function
      PCI: dra7xx: Reorder struct dra7xx_pcie


 drivers/pci/host/pci-dra7xx.c |  103 ++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 58 deletions(-)
