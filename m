From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] hwmod fixes for MMC module reset on init
Date: Tue,  7 Jul 2009 17:17:35 -0700
Message-ID: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f181.google.com ([209.85.216.181]:39434 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbZGHARk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 20:17:40 -0400
Received: by pxi11 with SMTP id 11so19465pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 17:17:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

I've started to integrate the new hwmod/omapdev into the PM branch for
the next release.

With the new MMC hwmod added, hwmod should do a full reset and idle of
the MMC modules on init, so I decided to remove the patch from the PM
branch which does the same.

To my surprise, the MMC blocks were preventing retention without the
original patch.  In debugging hwmod, I found a couple problems.   One
with the MMC sys[cs]_off values themselves, and another in that
the reset code was not waiting for RESETDONE.

Kevin Hilman (2):
  OMAP2/3: HS-MMC: correct hwmod offsets for SYSCONFIG/SYSSTATUS
  OMAP2/3/4: omap_hwmod: fix reset bug

 arch/arm/mach-omap2/omap_hwmod.c      |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430.h |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_34xx.h |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

