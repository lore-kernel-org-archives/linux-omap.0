From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes
Date: Fri,  7 Jan 2011 17:01:19 -0600
Message-ID: <1294441282-17986-1-git-send-email-nm@ti.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42870 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab1AGXBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 18:01:32 -0500
In-Reply-To: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>, Nishanth Menon <nm@ti.com>

Hi,
As discussed in the threads:
http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
http://marc.info/?t=121540030800004&r=1&w=2

here is the split up series with commit message after discussion:
http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21

Koen Kooi (3):
  omap3: beaglexm: fix EHCI power up GPIO dir
  omap3: beaglexm: fix DVI reset GPIO
  omap3: beaglexm: fix power on of DVI

 arch/arm/mach-omap2/board-omap3beagle.c |   37 ++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 5 deletions(-)

v4:
  no functional change.
  minor cleanups in commit logs incorporating offline feedback

v3: http://marc.info/?t=129434384700006&r=1&w=2
	split up the series, addressed review comments

v2: http://marc.info/?t=129276977900002&r=1&w=2
	Reenable the PMU stat LED
v1: http://marc.info/?t=129172571000001&r=1&w=2

Regards,
Nishanth Menon
