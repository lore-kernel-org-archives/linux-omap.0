From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/9] ARM: DTS: OMAP: Audio related cleanups for dtsi and dts files
Date: Fri, 24 Jan 2014 10:18:58 +0200
Message-ID: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaAXITg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 03:19:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Benoit,

OMAP: Put the audio nodes to disabled styate by default and board dts files should
enable the nodes which is used on the board.

am335x: correct the audio mclk clock. This patch has been marked to go to 3.13
	stable as well.

Regards,
Peter
---
Peter Ujfalusi (9):
  ARM: DTS: omap4-panda-common: Move audio related pinmux to respective
    nodes
  ARM: DTS: omap4-sdp: Move audio related pinmux to respective nodes
  ARM: DTS: omap4: Set all audio related IP's status to disabled as
    default
  ARM: DTS: omap4-panda-common: No need to disable the unused audio
    nodes
  ARM: DTS: omap4-sdp: No need to disable mcbsp3 node
  ARM: DTS: omap5: Set all audio related IP's status to disabled as
    default
  ARM: DTS: omap3: Set disabled status for McBSP instances as default
    state
  ARM: DTS: omap2: Set disabled status for McBSP instances as default
    state
  ARM: DTS: am335x-evmsk: Correct audio clock frequency

 arch/arm/boot/dts/am335x-evmsk.dts        |  2 +-
 arch/arm/boot/dts/omap2420.dtsi           |  2 ++
 arch/arm/boot/dts/omap2430.dtsi           |  5 +++++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |  4 ++++
 arch/arm/boot/dts/omap3-beagle.dts        |  4 ++++
 arch/arm/boot/dts/omap3-devkit8000.dts    | 16 ++-------------
 arch/arm/boot/dts/omap3-igep.dtsi         |  1 +
 arch/arm/boot/dts/omap3-overo.dtsi        |  4 ++++
 arch/arm/boot/dts/omap3.dtsi              |  5 +++++
 arch/arm/boot/dts/omap4-panda-common.dtsi | 23 ++++++++++-----------
 arch/arm/boot/dts/omap4-sdp.dts           | 33 ++++++++++++++++++++++++-------
 arch/arm/boot/dts/omap4.dtsi              |  6 ++++++
 arch/arm/boot/dts/omap5.dtsi              |  5 +++++
 13 files changed, 77 insertions(+), 33 deletions(-)

-- 
1.8.5.3

