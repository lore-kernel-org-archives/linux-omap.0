From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] dts for i2c-omap: fix incorrect adapter id
Date: Fri, 31 Aug 2012 09:52:53 +0200
Message-ID: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:38382 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750840Ab2HaHx1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 03:53:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Benoit Cousson <b-cousson@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>

Hello,

This patchset fixes the i2c adapter id on OMAP3 and OMAP4/AM33xx when booting
from a device tree.

Currently, pdev->id is used, regardless of the boot method. The first patch
checks for of_node, and get the id from the alias if a device tree is found.
The boot message is updated accordingly.

The second patch add the necessary aliases for OMAP3, OMAP4 and AM33xx.

This patchset applies on 3.6-rc3 and has been tested on OMAP3 (Gumstix Overo).

Regards,

Florian


Florian Vaussard (2):
  i2c-omap: Fix incorrect adapter id when booting from a device tree
  arm/dts: Add i2c aliases for OMAP3 and OMAP4/AM33xx

 arch/arm/boot/dts/am33xx.dtsi |    3 +++
 arch/arm/boot/dts/omap3.dtsi  |    3 +++
 arch/arm/boot/dts/omap4.dtsi  |    4 ++++
 drivers/i2c/busses/i2c-omap.c |   19 +++++++++++++++----
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.7.5.4

