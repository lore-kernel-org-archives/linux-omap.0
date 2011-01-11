From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 0/3] OMAP3: beaglexm: GPIO fixes
Date: Tue, 11 Jan 2011 11:13:34 -0600
Message-ID: <1294766017-12182-1-git-send-email-nm@ti.com>
References: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab1AKRNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 12:13:47 -0500
In-Reply-To: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>, Nishanth Menon <nm@ti.com>

Hi,
revision 5 of this series.
As discussed in the threads:
http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
http://marc.info/?t=121540030800004&r=1&w=2

here is the split up series with commit message after discussion:
http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21

Koen Kooi (3):
  omap3: beaglexm: fix EHCI power up GPIO dir
  omap3: beaglexm: fix DVI reset GPIO
  omap3: beaglexm: fix power on of DVI

 arch/arm/mach-omap2/board-omap3beagle.c |   38 ++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 6 deletions(-)

v5:
	review comment incorporation - gpio_direction_output removable.

v4: http://marc.info/?t=129444130100001&r=1&w=2
  no functional change.
  minor cleanups in commit logs incorporating offline feedback

v3: http://marc.info/?t=129434384700006&r=1&w=2
	split up the series, addressed review comments

v2: http://marc.info/?t=129276977900002&r=1&w=2
	Reenable the PMU stat LED
v1: http://marc.info/?t=129172571000001&r=1&w=2

Regards,
Nishanth Menon
