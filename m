From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for 2.6.37-rc1
Date: Mon, 15 Nov 2010 13:06:13 -0800
Message-ID: <20101115210613.GM9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull some trivial omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Felipe Balbi (1):
      arm: omap1: devices: need to return with a value

Janusz Krzysztofik (1):
      OMAP1: camera.h: add missing include

Mathias Nyman (1):
      omap: dma: Add read-back to DMA interrupt handler to avoid spuriousinterrupts

Thomas Weber (1):
      OMAP2: Devkit8000: Fix mmc regulator failure

 arch/arm/mach-omap1/devices.c             |    5 ++---
 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c    |    3 ---
 arch/arm/plat-omap/dma.c                  |    2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)
