From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7x-evm: DCAN pinmux fixes
Date: Thu, 5 Mar 2015 15:32:41 +0200
Message-ID: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40329 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbbCENcs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:32:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Tony,

These are some fixes to the DCAN pinmux.

cheers,
-roger

Roger Quadros (2):
  ARM: dts: dra7x-evm: Don't use dcan1_rx.gpio1_15 in DCAN pinctrl
  ARM: dts: dra7x-evm: avoid possible contention while muxing on CAN
    lines

 arch/arm/boot/dts/dra7-evm.dts  | 10 ++++------
 arch/arm/boot/dts/dra72-evm.dts | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.1.0

