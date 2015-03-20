From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/35] ARM: OMAP2+: PRCM/SCM cleanups against 4.0-rc
Date: Fri, 20 Mar 2015 20:44:11 +0200
Message-ID: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbbCTSpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 14:45:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

Hi,

v5 contains the following changes still:

- re-ordered patches a bit, the single clock driver fix moved to beginning
  of the set, waiting for a separate merge from Mike
- Changed patch #23 to fix the slightly misleading logic (removed the extra +1)
- Changed patches #16 and #18 to fix OMAP2/3/4 etc. only builds
- Fixed ti81xx boot issues (hopefully, I don't have access to hardware
  to test it)
- Changed control module DTS layout based on discussions with Tony, this
  includes addition of minimal l4 bus (patch #25+)

Testing done for v5:
 1: am335x-evm      : boot
 2: am335x-evmsk    : boot
 3: am3517-evm      : boot
 4: am43x-epos-evm  : boot
 5: am437x-gp-evm   : boot
 6: omap3-beagle-xm : boot
 7: omap3-beagle    : boot, suspend (ret/off), cpuidle (ret/off)
 8: am335x-boneblack: boot
 9: am335x-bone     : boot
10: dra7xx-evm      : boot
11: omap3-n900      : boot
12: omap5-uevm      : boot
13: omap4-panda-es  : boot, suspend (ret), cpuidle (ret)
14: omap4-panda     : boot
15: omap2430-sdp    : boot
16: omap3430-sdp    : boot
17: omap4-sdp-es23plus: boot

Branch available at:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: 4.0-rc1-prcm-cleanup-v5

-Tero

