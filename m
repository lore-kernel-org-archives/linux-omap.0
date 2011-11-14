From: Grant Likely <grant.likely@secretlab.ca>
Subject: [GIT PULL] bug fixes for gpio drivers
Date: Mon, 14 Nov 2011 10:46:16 -0700
Message-ID: <CACxGe6sfe5gK7zpLuhT5=neS8-6Y4uPK_hJQYjr8f9xGKq38Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Wolfram Sang <wsa@pengutronix.de>, Linus Walleij <linus.ml.walleij@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Some gpio drivers bug fixes for 3.2.  Nothing exciting here.

Expect further 3.2 gpio bug fix pull requests to come from Linus Walleij.

g.

The following changes since commit 7f80850d3f9fd8fda23a317044aef3a6bafab06b:

  Merge branch 'rmobile-fixes-for-linus' of
git://github.com/pmundt/linux-sh (2011-11-14 06:47:04 -0200)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 gpio/merge

Grant Likely (1):
      Merge branch 'for_3.2/gpio-cleanup' of
git://gitorious.org/khilman/linux-omap-pm into gpio/merge

Kevin Hilman (1):
      gpio/omap: replace MOD_REG_BIT macro with static inline

Todd Poynor (1):
      gpio/omap: check return value from irq_alloc_generic_chip

Wolfram Sang (2):
      gpio: pca953x: remove unneeded check for chip type
      gpio: pca953x: propagate the errno from the chip_init functions

 drivers/gpio/gpio-omap.c    |   59 ++++++++++++++++++++++++------------------
 drivers/gpio/gpio-pca953x.c |   11 +++-----
 2 files changed, 38 insertions(+), 32 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
