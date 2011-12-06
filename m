From: Benoit Cousson <b-cousson@ti.com>
Subject: OMAP2+: Devicetree cleanup
Date: Tue, 6 Dec 2011 17:49:06 +0100
Message-ID: <1323190149-6492-1-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59494 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1LFQtY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Dec 2011 11:49:24 -0500
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

This is a trivial cleanup series the removed some useless stuff inside
DTS and force DT by default in an omap2plus_config build.

Patches are based 3.2-rc4 and are available here:
git://gitorious.org/omap-pm/linux.git for_3.3/1_dt_base

Regards,
Benoit


Benoit Cousson (3):
  ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems
  arm/dts: OMAP: Remove bootargs node from board files
  ARM: OMAP2+: board-generic: Replace #if defined by #ifdef for consistency

 arch/arm/boot/dts/omap3-beagle.dts  |    9 ---------
 arch/arm/boot/dts/omap4-panda.dts   |    9 ---------
 arch/arm/boot/dts/omap4-sdp.dts     |    9 ---------
 arch/arm/mach-omap2/Kconfig         |    1 -
 arch/arm/mach-omap2/board-generic.c |    8 ++++----
 arch/arm/plat-omap/Kconfig          |    4 ++++
 6 files changed, 8 insertions(+), 32 deletions(-)

