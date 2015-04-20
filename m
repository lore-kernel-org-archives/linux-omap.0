From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc for 4.1
Date: Mon, 20 Apr 2015 22:15:54 +0300
Message-ID: <CAK=Wgba5=MsiH+OiN=XyHbbaws_ZRte8KwOGANchA2PpxBBEqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37603 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbDTTQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2015 15:16:15 -0400
Received: by igblo3 with SMTP id lo3so69029015igb.0
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2015 12:16:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-4.1-next

for you to fetch changes up to 315491e5d6ee66838a18a8ca0c14e6ffb376e48c:

  remoteproc: add IOMMU hardware capability flag (2015-03-12 10:43:26 +0200)

----------------------------------------------------------------
Suman Anna is adding remoteproc support for processors not behind IOMMUs.

----------------------------------------------------------------
Suman Anna (1):
      remoteproc: add IOMMU hardware capability flag

 drivers/remoteproc/da8xx_remoteproc.c |  1 +
 drivers/remoteproc/omap_remoteproc.c  |  2 ++
 drivers/remoteproc/remoteproc_core.c  | 15 ++-------------
 drivers/remoteproc/ste_modem_rproc.c  |  1 +
 include/linux/remoteproc.h            |  2 ++
 5 files changed, 8 insertions(+), 13 deletions(-)
