From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc fixes for 3.5
Date: Sun, 8 Jul 2012 22:23:13 +0300
Message-ID: <CAK=WgbZsCy7ZaMATbyTtZvP6bHCLfroth0z=wFOZhtmMWBFAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tony Lindgren <tony@atomide.com>, "Grosen, Mark" <mgrosen@ti.com>, linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-3.5-fixes

for you to fetch changes up to e121aefa7d9f10eee5cf26ed47129237a05d940b:

  remoteproc: fix missing CONFIG_FW_LOADER configurations (2012-07-04
11:01:12 +0300)

----------------------------------------------------------------
Two build-related remoteproc fixes for 3.5.

----------------------------------------------------------------
Ohad Ben-Cohen (2):
      remoteproc/omap: fix randconfig unmet direct dependencies
      remoteproc: fix missing CONFIG_FW_LOADER configurations

 drivers/remoteproc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
