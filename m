From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] palmas usb driver
Date: Fri, 24 May 2013 20:01:33 +0530
Message-ID: <1369405896-30246-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, balbi@ti.com, ldewangan@nvidia.com, gg@slimlogic.co.uk, lgirdwood@gmail.com, broonie@kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, george.cherian@ti.com, kishon@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

This patch series adds driver for palmas usb which is used to detect
attach/detach events of usb device and usb host.

[PATCH v5 2/3] extcon: Palmas Extcon Driver which was sent previously
is added in this patch series itself. The revision history is added
in the patch comments section.

A checkpatch warning "WARNING: static const char * array should
probably be static const char * const"is ignored since it introduces a
compilation warning.

Graeme Gregory (2):
  drivers: regulator: palmas: add an API to set/clear the switch bit on
    SMPS10
  extcon: Palmas Extcon Driver

Kishon Vijay Abraham I (1):
  usb: dwc3: use extcon fwrk to receive connect/disconnect notification

 .../devicetree/bindings/extcon/extcon-twl.txt      |  16 +
 drivers/extcon/Kconfig                             |   7 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-palmas.c                     | 341 +++++++++++++++++++++
 drivers/regulator/palmas-regulator.c               |  26 ++
 drivers/usb/dwc3/dwc3-omap.c                       |  80 +++--
 include/linux/mfd/palmas.h                         |  27 +-
 include/linux/usb/dwc3-omap.h                      |  30 --
 8 files changed, 470 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-twl.txt
 create mode 100644 drivers/extcon/extcon-palmas.c
 delete mode 100644 include/linux/usb/dwc3-omap.h

-- 
1.8.1.2
