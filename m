From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 00/35] ARM: OMAP2+: PRCM / SCM cleanups against 4.0-rc1
Date: Wed, 18 Mar 2015 16:43:45 +0200
Message-ID: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56452 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107AbbCROom (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:44:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes in this set compared to v3:

- Changed the SCM module DT node layout based on comments from Tony;
  basically the wkup / core are split into their own nodes now. This
  applies for omap3, omap4, omap5 and dra7, rest of the SoCs have their
  control module integrated as one instance (Patch 26, 30, 33, 34)
- Changed the tisyscon node name to scm_conf. This name is more
  descriptive for the purpose being used, scm_conf was already used
  as an alias (Patch 24, 25, 27, 29)
- Rest of the patches have no changes compared to v3.

Testing done:
- am335x-evm      : boot
- am335x-evmsk    : boot
- am3517-evm      : boot
- am43x-epos-evm  : boot
- am437x-gp-evm   : boot
- omap3-beagle-xm : boot
- omap3-beagle    : boot, suspend-resume (ret/off), cpuidle (ret/off)
- am335x-boneblack: boot
- am335x-bone     : boot
- dra7xx-evm      : boot
- omap3-n900      : boot
- omap5-uevm      : boot
- omap4-panda-es  : boot, suspend-resume (ret), cpuidle (ret)
- omap4-panda     : boot
- omap2430-sdp    : boot
- omap3430-sdp    : boot
- omap4-sdp-es23plus: boot

Test branch pushed at:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: 4.0-rc1-prcm-cleanup-v4

-Tero

