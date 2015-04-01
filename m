From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/3] ARM: OMAP2+: wkup_m3_rproc support patches
Date: Wed, 1 Apr 2015 14:47:07 -0500
Message-ID: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbbDATrj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 15:47:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

This series adds the mach-omap2 code and DT nodes for v3 of the
wkup_m3_rproc driver submitted here [1]. pdata-quirks patch requires
the pdata added with patch 4 of the aforementioned series. Based on
previous discussion here [2], the wkup_m3 DT node has been moved as a
child of the l4_wkup as is done for l4_wkup components in Tero Kristo's
series "PRCM+SCM cleanup against 4.0-rc1" found here [3]. Because of that,
this series applies cleanly on top of that series in order to leverage the
l4_wkup parent node introduced there.

In addition to the move of the wkup_m3 node for am33xx, a new patch
has been added to introduce the wkup_m3 node in the same fashion for
am43xx as both SoCs use the same configuration. With this change
support was also added to pdata-quirks for passing reset handlers to
the driver for the am43xx binding as was already done for am33xx.

I have pushed a branch containing all patches for am335x suspend
here for a big picture view of how all patches fit together with
these wkup_m3_rproc series [4].

v2->v3:
-Change ti,am3353-wkup-m3 compat to ti,am3352-wkup-m3 to reflect
 binding documentation change
-Add ti,am4372-wkup-m3 node to am4372 SoC dt file
-Add am4372 support to pdata-quirks for reset handlers

Regards,
Dave

[1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg115869.html
[2] http://www.spinics.net/lists/linux-omap/msg116366.html
[3] http://www.spinics.net/lists/arm-kernel/msg409842.html
[4] https://github.com/dgerlach/linux-pm/tree/pm-v4.0-rc5-am335x-suspend

Dave Gerlach (1):
  ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management

Suman Anna (2):
  ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
  ARM: dts: AM4372: Add the wkupm3 rproc node

 arch/arm/boot/dts/am33xx.dtsi      | 17 +++++++++--------
 arch/arm/boot/dts/am4372.dtsi      |  9 +++++++++
 arch/arm/mach-omap2/pdata-quirks.c | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.3.0

