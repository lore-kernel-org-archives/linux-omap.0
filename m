From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] OMAP PM core updates for 2.6.35
Date: Mon,  3 May 2010 14:41:08 -0700
Message-ID: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:49929 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0ECVlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:41:14 -0400
Received: by pzk42 with SMTP id 42so395857pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 14:41:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

A small series of OMAP PM core updates for 2.6.35.

Series based on Tony's omap-fixes branch and also availailable here:

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next

Kevin



Ari Kauppi (1):
  OMAP3: PM: Add milliseconds interface to suspend wakeup timer

Kevin Hilman (1):
  OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs

Tero Kristo (1):
  OMAP3: Serial: Improved sleep logic

 arch/arm/mach-omap2/pm-debug.c |    3 ++
 arch/arm/mach-omap2/pm.h       |    1 +
 arch/arm/mach-omap2/pm34xx.c   |   34 ++++++++++++-------
 arch/arm/mach-omap2/serial.c   |   71 ++++++++++++++++++++++++++++++++++------
 4 files changed, 87 insertions(+), 22 deletions(-)

