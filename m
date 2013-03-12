From: Andrew Chew <achew@nvidia.com>
Subject: [PATCH 0/2 v2] Add mandatory regulator for all users of pwm-backlight.
Date: Tue, 12 Mar 2013 15:22:12 -0700
Message-ID: <1363126934-8754-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8759 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab3CLWWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 18:22:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, achew@nvidia.com, linux-omap@vger.kernel.org

Many backlights are enabled via GPIO.  We can generalize the GPIO to a
fixed regulator.

The enable regulator needs to be mandatory because there was no good way
to determine the difference between opting out of the regulator, and probe
deferral.

This series of patches is intended to add a dummy regulator (or a GPIO
regulator) for all users of the pwm-backlight.

The last patch in the series will always be the pwm-backlight change to add
this mandatory regulator.  Patches following up to that patch add the
mandatory regulator on a per mach family basis.  Once all users of
pwm-backlight have been patched, this series can be applied in order to
maintain bisectability.

Andrew Chew (2):
  ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
  pwm_bl: Add mandatory backlight enable regulator

 .../bindings/video/backlight/pwm-backlight.txt     |   14 +++++
 arch/arm/mach-omap2/board-4430sdp.c                |    5 ++
 drivers/video/backlight/pwm_bl.c                   |   55 ++++++++++++++++----
 3 files changed, 64 insertions(+), 10 deletions(-)

-- 
1.7.9.5

