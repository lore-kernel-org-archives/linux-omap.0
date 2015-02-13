From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/33] ARM: OMAP2+: PRCM/omap ctrl cleanups against 3.19-rc1
Date: Fri, 13 Feb 2015 18:12:22 +0200
Message-ID: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44866 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbbBMQNk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:13:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Updates since v1:

- fixed omap2/am33xx boot issues
- added regmap support to generic omap clock core
- control module driver converted to use syscon
- dropped patches for removing legacy pad muxing support (this is still
  needed)

Notes:

- patches 4,5 and 8 not posted as these were already queued by Tony
- the above patches still exist in the test branch though
- patches 22-33 are new

Testing done:
- am335x-evm: boot
- am335x-sk: boot
- am3517-evm: boot
- am43x-epos-evm: boot
- am437x-gp-evm: boot
- omap3-beagle-xm: boot
- omap3-beagle: boot, suspend/resume (ret/off), cpuidle (ret/off)
- am335x-bone: boot
- am335x-boneblack: boot
- dra7xx-evm: boot
- omap5-uevm: boot
- omap4-panda: boot
- omap4-panda-es: boot, suspend/resume (ret)
- omap2430-sdp: boot
- omap3430-sdp: boot
- omap4430-sdp-es23plus: boot

Test branch location:

tree: https://github.com/t-kristo/linux-pm.git
branch: 3.19-rc1-prcm-cleanup

-Tero

