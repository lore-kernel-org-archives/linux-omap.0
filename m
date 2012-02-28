From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 0/5] trivial remoteproc/rpmsg fixes
Date: Tue, 28 Feb 2012 19:21:06 +0200
Message-ID: <1330449672-18191-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

Five remoteproc/rpmsg fixes.

One was reported by Russell (the Kconfig fixes) and one by Omar (the endpoint
leak).

Ohad Ben-Cohen (5):
  remoteproc: make sure we're parsing a 32bit firmware
  remoteproc/omap: two Kconfig fixes
  rpmsg: fix name service endpoint leak
  rpmsg: validate incoming message length before propagating
  rpmsg: fix published buffer length in rpmsg_recv_done

 drivers/remoteproc/Kconfig           |    3 +-
 drivers/remoteproc/remoteproc_core.c |    8 ++++++
 drivers/rpmsg/virtio_rpmsg_bus.c     |   42 ++++++++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 9 deletions(-)

-- 
1.7.5.4
