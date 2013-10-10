From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/2] ARM: dts: AM4372: Add more nodes
Date: Fri, 11 Oct 2013 00:44:52 +0530
Message-ID: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55908 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757245Ab3JJTPf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 15:15:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mugunthanvnm@ti.com, sourav.poddar@ti.com, linux@arm.linux.org.uk, akpm@linux-foundation.org, rnayak@ti.com, afzal@ti.com, nsekhar@ti.com, r.sricharan@ti.com, balajitk@ti.com, balbi@ti.com, lokeshvutla@ti.com

This patch series add nodes for l2-cache-controller, EDMA, mailbox, mmc, sham,
and updates the properties for cpsw, i2c0, matrix-keypad. 

These patches are applied on top of Benoit's for_3.13/dts branch
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

Testing:
Tested EDMA, mmc, sham, aes, des, i2c0, cpsw, matric-keypad on AM4372 EPOS EVM
with the addition of following two series:
-> Tero's V8 of OMAP DT clock conversion
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96769.html
-> Afzal's V5 of AM43x PRCM basic support
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96275.html

Lokesh Vutla (1):
  ARM: dts: AM4372: Add more nodes

Mugunthan V N (1):
  ARM: dts: AM4372: Update Support for EPOS EVM

 arch/arm/boot/dts/am4372.dtsi        |  210 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts |  168 +++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/am43xx.h |   31 +++++
 3 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/pinctrl/am43xx.h

-- 
1.7.9.5

