From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] rpmsg for 3.10
Date: Tue, 7 May 2013 15:04:54 +0300
Message-ID: <CAK=WgbbuJt4V2c_hqSzcqDwts6J7EQvD5CkoK95QqxoqboS2Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Tivy, Robert" <rtivy@ti.com>, Suman Anna <s-anna@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git tags/rpmsg-3.10

for you to fetch changes up to 397944df3290ddc46dcc6a08cd71fb560700431b:

  rpmsg: fix kconfig dependencies for VIRTIO (2013-04-21 16:32:29 +0300)

----------------------------------------------------------------
A small pull request consisting of:
- Make rpmsg process all pending messages instead of just
  one, from Robert Tivy
- Fix Kconfig dependency on VIRTUALIZATION, from Suman.
  Note: this was submitted late during the 3.9 rc cycle and it
  seemed appropriate to wait with it for the merge window.
- Belated addition of an rpmsg entry to the MAINTAINERS file.
  People seem to look for this.

----------------------------------------------------------------
Ohad Ben-Cohen (1):
      MAINTAINERS: add rpmsg entry

Robert Tivy (1):
      rpmsg: process _all_ pending messages in rpmsg_recv_done

Suman Anna (1):
      rpmsg: fix kconfig dependencies for VIRTIO

 MAINTAINERS                      |  8 +++++++
 drivers/rpmsg/Kconfig            |  1 +
 drivers/rpmsg/virtio_rpmsg_bus.c | 49 ++++++++++++++++++++++++++++------------
 3 files changed, 44 insertions(+), 14 deletions(-)
