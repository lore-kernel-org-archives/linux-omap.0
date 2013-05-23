From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] ARM: dts: updates for omap3-overo
Date: Thu, 23 May 2013 10:09:10 +0200
Message-ID: <1369296552-22281-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:34945 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755390Ab3EWIJo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 04:09:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

This series adds support to omap3-overo for the onboard NAND memory, and
restore the default trigger for the pwm-led provided by TWL4030.

Best regards,

Florian

Florian Vaussard (2):
  ARM: dts: Add omap3-overo NAND flash memory binding
  ARM: dts: omap3-overo: add default trigger for TWL4030 LED

 arch/arm/boot/dts/omap3-overo.dtsi |   51 ++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

-- 
1.7.5.4

