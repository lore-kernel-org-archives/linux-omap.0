From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH 0/8] staging: tidspbridge - misc fixes
Date: Mon, 25 Oct 2010 19:51:38 -0500
Message-ID: <1288054306-4361-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: felipe.contreras@nokia.com, Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

This set of patches fix some issues found in lastest tree.

Fernando Guzman Lugo (8):
  staging: tidspbridge - remove req_addr from proc_map
  staging: tidspbridge - add kconfig parameter for DMM size
  staging: tidspbridge - change mmufault tasklet to a workqueue
  staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
  staging: tidspbridge - use GTP7 for DSP stack dump
  staging: tidspbridge - remove disabling twl when printing DSP stack
  staging: tidspbridge - fix some issues after iommu patches
  staging: tidspbridge - make sync_wait_on_event interruptible

 drivers/staging/tidspbridge/Kconfig                |    8 +++
 drivers/staging/tidspbridge/core/dsp-clock.c       |   13 +++--
 drivers/staging/tidspbridge/core/dsp-mmu.c         |   55 +++++++++++---------
 drivers/staging/tidspbridge/core/tiomap3430.c      |   20 ++++++-
 .../staging/tidspbridge/include/dspbridge/clk.h    |    4 +-
 .../tidspbridge/include/dspbridge/dsp-mmu.h        |    3 +
 .../tidspbridge/include/dspbridge/dspapi-ioctl.h   |    1 -
 .../staging/tidspbridge/include/dspbridge/proc.h   |    3 -
 .../staging/tidspbridge/include/dspbridge/sync.h   |   13 ++++-
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    2 +-
 drivers/staging/tidspbridge/rmgr/node.c            |    4 +-
 drivers/staging/tidspbridge/rmgr/proc.c            |   25 ++++-----
 12 files changed, 95 insertions(+), 56 deletions(-)
