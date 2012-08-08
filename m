From: Fernando Guzman Lugo <fernando.lugo@ti.com>
Subject: [PATCH 0/3] remoteproc: introduce rproc recovery
Date: Wed,  8 Aug 2012 18:07:41 -0500
Message-ID: <1344467264-5128-1-git-send-email-fernando.lugo@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

These set of patches make possible the remoteproc recover after a crash.
This is a hard recovery, that means the remoteproc is reset and it will
start from the beginning. When a crash happen all the virtio devices are
destroyed. Therefore, both rpmsg drivers and devices are gracefully
removed which also cause rproc users become 0 and the remoteproc is turned
off. After the virtio devices are destroyed the crash handler function
will read the virtio information from the firmware in order to recreate
the virtio devices that will boot the remoteproc and everything will be
functional again.

Fernando Guzman Lugo (3):
  remoteproc: add rproc_report_crash function to notify rproc crashes
  remoteproc: recover a remoteproc when it has crashed
  remoteproc: create debugfs entry to disable/enable recovery
    dynamically

 Documentation/remoteproc.txt             |    7 ++
 drivers/remoteproc/remoteproc_core.c     |  107 ++++++++++++++++++++++++++++--
 drivers/remoteproc/remoteproc_debugfs.c  |   83 +++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h |    1 +
 include/linux/remoteproc.h               |   20 ++++++
 5 files changed, 211 insertions(+), 7 deletions(-)
