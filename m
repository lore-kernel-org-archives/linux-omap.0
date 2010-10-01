From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] OMAP: couple more PM fixes for 2.6.37
Date: Fri,  1 Oct 2010 14:01:18 -0700
Message-ID: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab0JAVBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:01:23 -0400
Received: by iwn5 with SMTP id 5so4265595iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:01:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Tony,

Here are a couple more PM related fixes for 2.6.37.  The one from Lo=C3=
=AFc
fixes one of the compile errors that's been reported a couple times
now.

This branch is based on my pm-next branch which is already pulled into
your omap-for-linus branch, so should merge smoothly

Kevin


The following changes since commit 0aed043517ad4135cb458a46e9e99e21cbb5=
9c69:

  OMAP: GPIO: ensure debounce clocks are disabled during idle/suspend (=
2010-09-23 17:14:17 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-p=
m.git pm-next-2

Kevin Hilman (1):
      OMAP3: CPUidle: remove redundant setting of PER next power state

Lo=C3=AFc Minier (1):
      OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set

 arch/arm/mach-omap2/cpuidle34xx.c |    4 +---
 arch/arm/mach-omap2/pm.h          |    7 ++++---
 2 files changed, 5 insertions(+), 6 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
