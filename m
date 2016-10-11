From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] PCI: designware/dra7xx: misc fixes and cleanups
Date: Tue, 11 Oct 2016 18:28:31 +0530
Message-ID: <1476190715-16884-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series was created on 4.8 Kernel after merging "pci/host-designware"
and "pci/host-dra7xx" of Bjorn's PCI tree.

The first patch fixes a compilation warning in designware code.

It is now possible to force the DRA7xx controller to work in GEN1 mode
using a dt property.

It includes a fix in dra7xx driver so that even if CONFIG_PCI_MSI is enabled,
dra7xx driver can service legacy interrupts (provided the device
support only legacy interrupts).

Kishon Vijay Abraham I (4):
  PCI: designware: Fix compiler warning
  PCI: dra7xx: simplify the probe code
  PCI: dra7xx: Add support to force RC to work in GEN1 mode
  PCI: dra7xx: Enable MSI and legacy interrupts simultaneously

 Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
 drivers/pci/host/pci-dra7xx.c                    |   80 +++++++++++++---------
 drivers/pci/host/pcie-designware.c               |   10 +--
 3 files changed, 49 insertions(+), 42 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
