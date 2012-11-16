From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP2+: HDMI: Update platform devices for audio
Date: Thu, 15 Nov 2012 19:36:57 -0600
Message-ID: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47525 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab2KPBiC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 20:38:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Hi Mark, Tomi, Liam, Tony,

This set aims to be the version 2 of my previous submission[1] and aims to
address the potential issues that Mark and Tomi described on such submission.

The creation of the platform device for HDMI audio from the OMAPDSS HDMI driver
that was previously submitted[2] is resubmitted to be complemented with code to
remove the platform device created in /arch/arm/mach-omap2/devices.c in order
to have a complete series that does not break functionality in any patch.

Also, a second patch proposes new names and locations for the ASoC HDMI CPU DAI
and machine drivers. This intends to give to the platform devices more
descriptive names and create them from more relevant locations.

This set of patches requires that

commit 14840b9a83c6a56629db2ba0ec247503e975f143
Author: Ricardo Neri <ricardo.neri@ti.com>
Date:   Tue Nov 6 00:19:17 2012 -0600

    OMAPDSS: HDMI: Create platform device for audio support

is reverted in Tomi's git://gitorious.org/linux-omap-dss2/linux.git master

Changes from v1.
*Put in a single series all the patches related to platform device updates.
*Now HDMI audio works correctly in every patch.
*Remove reference to the TPD12S015 HDMI companion chip as the ASoC drivers
 are not aware of this and other chips could be used in the future.

 BR,

 Ricardo

[1]. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80678.html
[2]. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79795.html

Ricardo Neri (2):
  ARM: OMAP2+: HDMI: Relocate audio platform device creation
  ARM: OMAP4+: HDMI: Rearrange platform devices for ASoC drivers

 arch/arm/mach-omap2/board-4430sdp.c    |    6 +++
 arch/arm/mach-omap2/board-omap4panda.c |    6 +++
 arch/arm/mach-omap2/devices.c          |   31 ----------------
 drivers/video/omap2/dss/hdmi.c         |   62 ++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi-card.c        |    4 +-
 sound/soc/omap/omap-hdmi.c             |    5 +--
 sound/soc/omap/omap-hdmi.h             |    2 -
 7 files changed, 78 insertions(+), 38 deletions(-)

-- 
1.7.5.4

