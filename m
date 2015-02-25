From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 00/35] ARM: OMAP2+: PRCM / SCM cleanups against 4.0-rc1
Date: Wed, 25 Feb 2015 21:04:10 +0200
Message-ID: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbBYTEr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:04:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes in this set compared to v2:

- Changed the SCM module DT node layout to address Tony's comments;
  only scm-conf area / any other necessary portions are syscon mapped.
  Rest of the IO space is only mapped by the underlying drivers.
- Added patch for changing omap4 display driver to use syscon instead
  of legacy padconf register read/write.
- Changed clock provider infrastructure patches to address some earlier
  comments from Paul; basically the IO mapping for clock drivers is
  always done at the clock provider level and not moved to the clock
  driver (patch 10-12.)
- Changed ordering of patches a bit, the first part of this set should
  be now more trivial for merging purposes (patch 1-9)
- Dropped patches already merged from v2 set
- Some misc fixes added: patch 8-9, patch 28.

Testing done:
- am335x-evm: boot
- am335x-sk: boot
- am43xx-epos: boot
- am43xx-gpevm: boot
- omap3-beagle-xm: boot
- omap3-beagle: boot, suspend-resume ret/off, cpuidle ret/off
- am335x-bone: boot
- am335x-bone-black: boot
- dra7-evm: boot
- omap4-panda-es: boot, suspend-resume ret, cpuidle ret
- omap4-panda: boot
- omap2430-sdp: boot
- omap3430-sdp: boot
- omap4430-sdp: boot

Test branch pushed at:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: 4.0-rc1-prcm-cleanup

-Tero

