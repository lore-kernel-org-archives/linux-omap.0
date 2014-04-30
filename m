From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: AM43xx: Touchscreen support
Date: Wed, 30 Apr 2014 15:43:23 +0300
Message-ID: <1398861805-9229-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932715AbaD3Mna (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 08:43:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Benoit & Tony,

These patches add I2C touch screen support for am43x-epos-evm
and am437x-gp-evm.

Relevant driver side changes are here.
http://thread.gmane.org/gmane.linux.kernel.input/35803

Please queue this for -next (3.16). Thanks.

cheers,
-roger

---
Roger Quadros (1):
  ARM: dts: am43x-epos-evm: Correct Touch controller info

Sekhar Nori (1):
  ARM: dts: AM437x: Add touchscreen support for GP EVM

 arch/arm/boot/dts/am437x-gp-evm.dts  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 12 ++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.8.3.2

