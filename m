From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/3] OMAP2+: hwmod: Add support to parse clock info from DT
Date: Thu, 12 Dec 2013 17:08:26 +0530
Message-ID: <1386848309-14076-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53103 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab3LLLjL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 06:39:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, nm@ti.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

v1 of this series was posted a while back [1] but there wasn't much that
was concluded if the approach used in the series was acceptable or if there
are better alternatives. So I am just doing a repost of these to see if we
can conclude this time around.

Needless to say, patches are based off Teros omap-clocks-to-dt v10 series [2]
and I also pulled in Tonys fix to handle DT nodes with multiple 'ti,hwmod'
values [3]. The approach taken in the series *does not* work for cases with
multiple 'ti,hwmod' values and hence [3] helps me skip those instances
for now. But based on some of the recent discussions on multiple 'ti-hwmod'
values [4] it looks like its generally agreed upon that having DT nodes with
multiple 'ti-hwmod' property is wrong and that those instances need to be
fixed up anyway.

[1] http://www.spinics.net/lists/linux-omap/msg95746.html
[2] http://www.spinics.net/lists/devicetree/msg13455.html
[3] http://www.spinics.net/lists/arm-kernel/msg288036.html
[4] http://www.spinics.net/lists/arm-kernel/msg288023.html

Rajendra Nayak (3):
  ARM: OMAP2+: Add support to parse 'main_clk' info from DT
  ARM: OMAP2+: Add support to parse optional clk info from DT
  ARM: OMAP4: dts: Add main and optional clock data into DT

 arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           |   88 ++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  122 ----------------------------
 3 files changed, 180 insertions(+), 130 deletions(-)

-- 
1.7.9.5

