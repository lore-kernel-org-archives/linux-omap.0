From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/2] pinctrl: dt-bindings: Fix amx3 SLEWCTRL_FAST binding
Date: Fri, 27 Feb 2015 19:10:25 -0600
Message-ID: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59189 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbB1BLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 20:11:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Dave Gerlach <d-gerlach@ti.com>

Currently both am33xx and am43xx have the macro for SLEWCTRL_FAST
in pinctrl dt-bindings reversed so that selecting the macro actually
sets SLEWCTRL_SLOW in the pad control registers. These patches
correct the bindings but leave the pinctrl states that use the binding
*UNMODIFIED*. Previously i2c and mdio on am33xx and i2c, mdio, and
uart on am43xx had been using this macro and selecting SLEWCTRL_FAST
while actually programming SLEWCTRL_SLOW in the pad config registers.

Because the intended selection was SLEWCTRL_FAST the macros are
unchanged. I tested on am335x-gp-evm and am437x-gp-evm with no
difference in functionality seen.

Regards,
Dave

Dave Gerlach (2):
  pinctrl: am33xx: dt-bindings: fix SLEWCTRL_FAST binding
  pinctrl: am43xx: dt-bindings: fix SLEWCTRL_FAST binding

 include/dt-bindings/pinctrl/am33xx.h | 3 ++-
 include/dt-bindings/pinctrl/am43xx.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.3.0

