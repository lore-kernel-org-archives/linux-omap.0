From: jean.pihet@newoldbits.com
Subject: [PATCH 0/5] ARM: OMAP2+: PM: implement a caching mechanism on the power domains state registers
Date: Tue,  1 May 2012 15:07:38 +0200
Message-ID: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45236 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab2EANIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:10 -0400
Received: by wgbdr13 with SMTP id dr13so1464892wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The OMAP3 PRCM registers accesses are known to be slow, with a PRCM register
read taking up to 12-14us depending on the OPP.

This patch adds a caching mechanism on the power domains state registers.
When the cache is cold or has been invalidated a register access is
performed, otherwise the register value is retrieved from the registers
cache.
The API is made of read and write functions for fields in the cache, as well
as an invalidate and helper functions to invalidate parts of the cache
contents (i.e. previous, current power states and all fields in the cache).
The power domain code is converted to use the API to read and write the
previous, current and next states for the power domains states, logical
and memory states.
The PM debug code also uses the caching API instead of the internal
pwrdm->state variable.

Using the caching mechanism optimizes the performance of the system in the
transitions to and from the low power states.

Tested on Beagleboard using cpuidle in RET and OFF modes.

Based on the linux-omap git tree (3.4.0-rc2) [1] with the changes for the
functional power states [2] and the per-device PM QoS support for OMAP [3].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
[2] http://marc.info/?l=linux-omap&m=133475291911194&w=2
[3] http://marc.info/?l=linux-omap&m=133475685213067&w=2


Jean Pihet (5):
  ARM: OMAP2+: PM: implement a caching mechanism on the power domains
    state registers
  ARM: OMAP2+: PM: use the power domains registers cache for the power
    states
  ARM: OMAP2+: PM: use the power domains registers cache for the logic
    and mem states
  ARM: OMAP2+: PM: use the power domains registers cache invalidate API
  ARM: OMAP2+: PM debug: use the power domains registers caching API

 arch/arm/mach-omap2/pm-debug.c    |   16 ++-
 arch/arm/mach-omap2/pm34xx.c      |    6 +
 arch/arm/mach-omap2/powerdomain.c |  272 ++++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/powerdomain.h |   45 ++++++-
 4 files changed, 297 insertions(+), 42 deletions(-)

-- 
1.7.7.6

