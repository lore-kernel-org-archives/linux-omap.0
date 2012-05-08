From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: OMAP4 DTS updates
Date: Tue, 8 May 2012 18:37:24 +0200
Message-ID: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815Ab2EHQhl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 12:37:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

Here is a small series I have done for 3.4 but never posted before.
It adds GPIO node for twl4030 embedded gpio controller and some LEDs data
to be able to get rid of the static init done in board file right now.

It is based on arm-soc/omap/dt-missed-3.4 to get the previous patches not yet
in linus/master.

The patches are available here:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.5/dts/all

Regards,
Benoit


Benoit Cousson (3):
  arm/dts: twl4030: Add twl4030-gpio node
  arm/dts: omap4-sdp: Add LEDs support
  arm/dts: omap4-panda: Add LEDs support

 arch/arm/boot/dts/omap4-panda.dts |   15 +++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   43 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi    |    8 +++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

