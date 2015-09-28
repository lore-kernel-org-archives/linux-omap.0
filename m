From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/2] DRA72/DRA74: Add 2 lane support
Date: Mon, 28 Sep 2015 18:27:36 +0530
Message-ID: <1443445058-643-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add driver modifications in pci-dra7xx to get x2 mode working in
DRA72 and DRA74. Certain modifications is needed in PHY driver also
which I'll send as a separate series.

Kishon Vijay Abraham I (2):
  pci: host: pci-dra7xx: use "num-lanes" property to find phy count
  pci: host: pci-dra7xx: Enable x2 mode support

 Documentation/devicetree/bindings/pci/ti-pci.txt |    7 +-
 drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
 2 files changed, 97 insertions(+), 14 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
