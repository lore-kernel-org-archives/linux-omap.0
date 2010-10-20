From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/PATCH 0/2] OMAP: PM: add "early" idle notifier chain
Date: Wed, 20 Oct 2010 16:38:44 -0700
Message-ID: <1287617926-24308-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35827 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab0JTXit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 19:38:49 -0400
Received: by pzk3 with SMTP id 3so845464pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 16:38:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Based on previous idle notification series, starting at:

      [PATCH 1/3] OMAP: PM: formalize idle notifications

This series adds an additional "early" idle notifier chain triggered
early in the CPUidle path with interrupts enabled.

This allows users of "early" notifiers to use blocking calls.  While
in general, use of blocking calls in idle notifiers should be avoided,
the current runtime PM API can sleep/schedule so cannot be done from
atomic context.  Use of "early" notifiers allows driver/device code to
use the runtime PM API in their idle notifier callbacks.

RFC: note that patch 2 enables interrupts in the CPUidle path, causing
interrupts to be enabled during the governor state selection and
device idle detection.  What could go wrong here?

Kevin Hilman (2):
  OMAP: PM: add "early" idle notifications
  OMAP3: CPUidle: trigger early idle notification call chain

 arch/arm/mach-omap2/cpuidle34xx.c        |   27 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm.c                 |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    6 ++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

-- 
1.7.2.1

