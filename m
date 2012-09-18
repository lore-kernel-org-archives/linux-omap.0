From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] rpmsg: a fix for 3.6
Date: Tue, 18 Sep 2012 09:56:55 +0300
Message-ID: <CAK=WgbYzUTfMiW5J-5xWHLjy64Gmi44z3iktrr-aY67Pa9Egog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
tags/rpmsg-3.6-fix

for you to fetch changes up to eeb0074f36d1ab0729d06f1c56add9c7799679e2:

  rpmsg: fix dma_free_coherent dev parameter (2012-09-12 12:03:57 +0300)

----------------------------------------------------------------
A quick rpmsg fix from Fernando, fixing two buggy invocations of
dma_free_coherent.

----------------------------------------------------------------
Fernando Guzman Lugo (1):
      rpmsg: fix dma_free_coherent dev parameter

 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
