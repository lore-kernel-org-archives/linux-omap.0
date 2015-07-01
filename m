From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] hwspinlock for 4.2
Date: Wed, 1 Jul 2015 16:48:20 +0300
Message-ID: <CAK=WgbbH9SZF-Ysr4--6usvLdv7+H2x7VKs+jg_LD2-UMkRarw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Anna, Suman" <s-anna@ti.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wei Chen <Wei.Chen@csr.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
tags/hwspinlock-4.2

for you to fetch changes up to bd5717a4632cdecafe82d03de7dcb3b1876e2828:

  hwspinlock: qcom: Correct msb in regmap_field (2015-07-01 16:15:05 +0300)

----------------------------------------------------------------
- hwspinlock core DT support from Suman Anna
- OMAP hwspinlock DT support from Suman Anna
- QCOM hwspinlock DT support from Bjorn Andersson
- a new CSR atlas7 hwspinlock driver from Wei Chen
- CSR atlas7 hwspinlock DT binding document from Wei Chen
- a tiny QCOM hwspinlock driver fix from Bjorn Andersson

----------------------------------------------------------------
Bjorn Andersson (3):
      DT: hwspinlock: Add binding documentation for Qualcomm hwmutex
      hwspinlock: qcom: Add support for Qualcomm HW Mutex block
      hwspinlock: qcom: Correct msb in regmap_field

Suman Anna (4):
      Documentation: dt: add common bindings for hwspinlock
      hwspinlock/core: add device tree support
      Documentation: dt: add the omap hwspinlock bindings document
      hwspinlock/omap: add support for dt nodes

Wei Chen (2):
      hwspinlock: add a CSR atlas7 driver
      DT: hwspinlock: add the CSR atlas7 hwspinlock bindings document

 Documentation/devicetree/bindings/hwlock/hwlock.txt          |  59
+++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt |  26
++++++++++++++++
 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.txt |  39
+++++++++++++++++++++++
 Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt |  28
+++++++++++++++++
 Documentation/hwspinlock.txt                                 |  10 ++++++
 MAINTAINERS                                                  |   1 -
 arch/arm/mach-omap2/Makefile                                 |   3 --
 arch/arm/mach-omap2/hwspinlock.c                             |  60
------------------------------------
 drivers/hwspinlock/Kconfig                                   |  24
+++++++++++++++
 drivers/hwspinlock/Makefile                                  |   2 ++
 drivers/hwspinlock/hwspinlock_core.c                         |  79
+++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwspinlock/omap_hwspinlock.c                         |  18 ++++++++---
 drivers/hwspinlock/qcom_hwspinlock.c                         | 181
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwspinlock/sirf_hwspinlock.c                         | 136
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwspinlock.h                                   |   7 +++++
 15 files changed, 605 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt
 delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
 create mode 100644 drivers/hwspinlock/qcom_hwspinlock.c
 create mode 100644 drivers/hwspinlock/sirf_hwspinlock.c
