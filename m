From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/14] arm: omap3: auto-ret / auto-off support
Date: Tue, 21 Feb 2012 16:04:44 +0200
Message-ID: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51337 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab2BUOFv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set applies on top of the pwrdm / clkdm / voltdm usecounting patch
set I sent last week (see:
http://www.spinics.net/lists/linux-omap/msg64670.html):

Following changes done compared to previous version.

- split out the basic usecounting support as its own set (see above)
- added lots of new comments to the code, including kerneldoc style
  function headers
- changed pmic->vp_vddmin / vddmax to simply vddmin / vddmax, these
  are now used as limits for all voltage related operations (both
  vc / vp), pmic limits are checked against the values defined for
  the omap chip itself to select proper voltage levels
- some other minor fixes proposed for the previous version

TBD:
- omap4 support (will work with this once retention works for omap4)
- pmic script support for omap3 (scaling to 0V level)

Tested on omap3 beagle with retention / off, suspend and dynamic idle.
Voltage rails for vdd1 (mpu) and vdd2 (core) measured and seen to scale
correctly to retention / off voltage levels.

-Tero

