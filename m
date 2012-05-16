From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] misc omap fixes for 3.5
Date: Wed, 16 May 2012 12:54:05 +0300
Message-ID: <CAK=Wgbb8rXxGaSuk1VyoXz60Faek0Hd0=9EpqAAGKTt6V0FWQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35732 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759894Ab2EPJy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 05:54:28 -0400
Received: by gglu4 with SMTP id u4so475241ggl.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 02:54:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, "Gutierrez, Juan" <jgutierrez@ti.com>

Hi Tony,

Two important fixes from Juan that are necessary to utilize the DSP on
OMAP4, and a trivial hwspinlock cleanup.

I tried to keep things as simple as possible, but please tell me if
you want this pull request anyway differently (e.g. split to two
separate fixes/cleanups requests, use an annotated signed tag, etc..).

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/linux.git for-tony

Juan Gutierrez (2):
      ARM: OMAP: enable mailbox irq per instance
      ARM: OMAP4: fix irq and clock name for dsp-iommu

Ohad Ben-Cohen (1):
      ARM: OMAP4: hwspinlocks_init() should be static

 arch/arm/mach-omap2/hwspinlock.c |    2 +-
 arch/arm/mach-omap2/mailbox.c    |    2 --
 arch/arm/mach-omap2/omap-iommu.c |    6 ++----
 arch/arm/plat-omap/mailbox.c     |   13 +++++++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

Thanks,
Ohad.
