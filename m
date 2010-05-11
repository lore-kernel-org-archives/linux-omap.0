From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/6] OMAP PM core updates for 2.6.35 [updated]
Date: Tue, 11 May 2010 16:47:05 -0700
Message-ID: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0EKXrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:15 -0400
Received: by vws17 with SMTP id 17so1655954vws.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

A small series of OMAP PM core updates for 2.6.35.

Applies on v2.6.34-rc6.

Also available here in my pm-next branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git pm-next

Ari Kauppi (1):
  OMAP3: PM: Add milliseconds interface to suspend wakeup timer

Kevin Hilman (1):
  OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs

Mike Chan (2):
  OMAP3: PM: Enable IO / IO-CHAIN wakeups for PER
  OMAP3: PM: Remove PER wakeup dependency on CORE.

Ranjith Lohithakshan (2):
  OMAP3EVM: Update pad configuration for wakeup enabled pads
  OMAP3: PM: Enable wakeup from ads7846 touchscreen

 arch/arm/mach-omap2/board-3430sdp.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c |    6 ++--
 arch/arm/mach-omap2/pm-debug.c       |    3 ++
 arch/arm/mach-omap2/pm.h             |    1 +
 arch/arm/mach-omap2/pm34xx.c         |   58 +++++++++++++++++++--------------
 5 files changed, 41 insertions(+), 28 deletions(-)

