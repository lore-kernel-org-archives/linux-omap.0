From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 00/20] omapfb: Add support for new LCDs / misc fixes
Date: Thu,  4 Jun 2009 20:52:25 +0300
Message-ID: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38206 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZFDRxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:53:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>

Hi,

I'd like to ask for the merging of this patchset into Linus' tree.
It adds support for new LCDs on OMAP based boards (01-12) and fixes
generic parts of the omapfb driver (13-20). The changes have been
staged in the Linux OMAP tree for quite a long time, so they should
be safe to be merged.

Note that this is about the existing "DSS1" FB driver which will
eventually be replaced by Tomi Valkeinen's DSS2 FB driver.

Thanks,
Imre

[PATCH 01/20] omapfb: Add support for the Apollon LCD
[PATCH 02/20] omapfb: Add support for MIPI-DCS compatible LCDs
[PATCH 03/20] N770: Enable LCD MIPI-DCS in Kconfig
[PATCH 04/20] omapfb: Add support for the Amstrad Delta LCD
[PATCH 05/20] omapfb: Add support for the 2430SDP LCD
[PATCH 06/20] omapfb: Add support for the OMAP2EVM LCD
[PATCH 07/20] omapfb: Add support for the 3430SDP LCD
[PATCH 08/20] omapfb: Add support for the OMAP3 EVM LCD
[PATCH 09/20] omapfb: Add support for the OMAP3 Beagle DVI output
[PATCH 10/20] omapfb: Add support for the Gumstix Overo LCD
[PATCH 11/20] omapfb: Add support for the ZOOM MDK LCD
[PATCH 12/20] omapfb: Add support for rotation on the Blizzard LCD ctrl
[PATCH 13/20] omapfb: dispc: Various typo fixes
[PATCH 14/20] omapfb: dispc: Disable iface clocks along with func clocks
[PATCH 15/20] omapfb: dispc: Enable wake up capability
[PATCH 16/20] omapfb: dispc: Allow multiple external IRQ handlers
[PATCH 17/20] omapfb: suspend/resume only if FB device is already initialized
[PATCH 18/20] omapfb: Fix coding style / remove dead line
[PATCH 19/20] omapfb: Add FB manual update option to Kconfig
[PATCH 20/20] omapfb: HWA742: fix pointer to be const
