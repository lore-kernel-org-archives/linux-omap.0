From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/3] OMAP2+: hwmod: Add support to parse clock info from DT
Date: Tue, 23 Jul 2013 11:54:36 +0530
Message-ID: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab3GWGZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 02:25:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

With all of OMAP clock data now moving to DT, its possible to pass the
main or functional clock and all optional clocks information for a
device from DT instead of having these as part of hwmod static data
in the kernel.

This patch series is based on 'v3' of omap4 clock movement to DT
patches [1] and is boot tested on a omap4 panda es.

The series does leave all the interface clocks as part of hwmod (and
main and optional clocks for devices which are missing DT drivers).

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100117

Rajendra Nayak (3):
  ARM: OMAP2+: Add support to parse 'main_clk' info from DT
  ARM: OMAP2+: Add support to parse optional clk info from DT
  ARM: OMAP4: dts: Add main and optional clock data into DT

 arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           |  100 +++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
 3 files changed, 185 insertions(+), 127 deletions(-)

-- 
1.7.9.5

