From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Date: Tue, 22 Apr 2014 13:52:18 -0500
Message-ID: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaDVSwu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 14:52:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Dave Gerlach <d-gerlach@ti.com>

This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
bootloader configures gpio5_7 to control the DDR3 termination regulator,
the linked patch prevents that gpio bank from being reset and losing
the previously configured state, and this patch binds the gpio to a
regulator so the kernel is aware of the state of the gpio.

[1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg102941.html

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add vtt_fixed regulator

 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
1.9.0

