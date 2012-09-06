From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM/dts: omap4 boards: Enable the use of GPO on twl6040
Date: Thu,  6 Sep 2012 16:06:16 +0300
Message-ID: <1346936778-18303-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39424 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752518Ab2IFNGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:06:05 -0400
Received: by obbuo13 with SMTP id uo13so2390681obb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:06:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hello,

twl6040 has GPO functionality. The driver for it is going via MFD tree.
This series adds the needed properties to twl6040 in the dts files so other
drivers can use the GPO lines.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM/dts: omap4-sdp: Enable GPO functionality for twl6040
  ARM/dts: omap4-panda: Enable GPO functionality for twl6040

 arch/arm/boot/dts/omap4-panda.dts | 3 +++
 arch/arm/boot/dts/omap4-sdp.dts   | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.7.12

