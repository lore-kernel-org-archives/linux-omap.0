From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] hwspinlock fix for 3.5
Date: Sun, 8 Jul 2012 22:22:47 +0300
Message-ID: <CAK=WgbY2-K991tkQ_09=vCEAnuz3N8K2sXU=R1sOQ_Fm1VC_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33132 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2GHTXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jul 2012 15:23:08 -0400
Received: by vbbff1 with SMTP id ff1so6966521vbb.19
        for <linux-omap@vger.kernel.org>; Sun, 08 Jul 2012 12:23:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Hi Linus,

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
tags/hwspinlock-3.5-fixes

for you to fetch changes up to 476a7eeb60e70ddab138e7cb4bc44ef5ac20782e:

  hwspinlock/core: use global ID to register hwspinlocks on multiple
devices (2012-07-07 22:35:30 +0300)

----------------------------------------------------------------
A single hwspinlock core fix for multiple hwspinlock devices scenarios,
from Shinya Kuribayashi.

----------------------------------------------------------------
Shinya Kuribayashi (1):
      hwspinlock/core: use global ID to register hwspinlocks on multiple devices

 drivers/hwspinlock/hwspinlock_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
