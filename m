From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/3] ARM: OMAP3: PM: optimize cpuidle C1 state latency
Date: Fri,  1 Jun 2012 17:11:05 +0200
Message-ID: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60568 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab2FAPLU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 11:11:20 -0400
Received: by weyu7 with SMTP id u7so1434676wey.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 08:11:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

The C1 state latency can be improved by optimizing the cpuidle low
level code.

The first patch is a precaution fix for patch 2.
Patches 2 & 3 are optimization changes.

Rebased on top of the for_3.6/pm/performance branch of
khilman's tree [1].

Tested on Beagleboard using a DMA-enabled copy from NAND flash
to /dev/null.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Jean Pihet (3):
  ARM: OMAP3: PM: cpuidle: default to C1 in next_valid_state
  ARM: OMAP3: PM: cpuidle: optimize the PER latency in C1 state
  ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state

 arch/arm/mach-omap2/cpuidle34xx.c |   71 ++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 44 deletions(-)

-- 
1.7.7.6

