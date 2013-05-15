From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 0/3] arm: enable TI SoC thermal driver
Date: Wed, 15 May 2013 10:58:45 -0400
Message-ID: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755699Ab3EOO7I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 May 2013 10:59:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello,

Idea is to add the missing bits under arch/arm/*omap* required
to enable by default the ti-soc-thermal driver. I am planing to
move it out of staging tree. It would be interesting to get
feedback from other ppl. By enabling it by default we could reach
more ppl for testing it across the supported chips.

The difference from v1 is just that patch 01 doe snot include the
dts prefix, as it is not supposed to be DTS related.

BR,

Eduardo Valentin (3):
  arm: introduce config HAS_BANDGAP
  arm: dts: add bandgap entry for OMAP443x devices
  arm: dts: add bandgap entry for OMAP4460 devices

 arch/arm/Kconfig                | 3 +++
 arch/arm/boot/dts/omap443x.dtsi | 4 ++++
 arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
 arch/arm/mach-omap2/Kconfig     | 1 +
 4 files changed, 17 insertions(+)

-- 
1.8.2.1.342.gfa7285d

