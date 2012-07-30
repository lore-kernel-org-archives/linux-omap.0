From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] OMAP DT fixes
Date: Mon, 30 Jul 2012 18:42:18 +0530
Message-ID: <1343653940-16614-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab2G3NMs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 09:12:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Hi Tony,

These are couple of DT fixes for OMAP, first fixes a lockup
/boot failure on OMAP4 boards (SDP and panda) on mainline,
second is a long pending cleanup.

regards,
Rajendra

Rajendra Nayak (2):
  arm/dts: Mark vcxio, v2v1 and v1v8 regulators as always on
  arm/dts: Cleanup regulator naming and remove @0,1..

 arch/arm/boot/dts/omap3-beagle.dts |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts    |    4 ++--
 arch/arm/boot/dts/twl4030.dtsi     |    6 +++---
 arch/arm/boot/dts/twl6030.dtsi     |   29 ++++++++++++++++-------------
 4 files changed, 22 insertions(+), 19 deletions(-)

