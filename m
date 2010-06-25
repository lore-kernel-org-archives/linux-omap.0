From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 0/7] Janitor series 2: cleanups
Date: Fri, 25 Jun 2010 16:46:33 -0500
Message-ID: <1277502400-9915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40636 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab0FYVqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 17:46:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

More misc cleanups for Sr branch including print cleans, checks etc.
This series probably should be squashed with other patches in pm-sr
branch. note some of these patches address few other comments I had
made in an unrelated patch.

Related comments prior to providing patches:

a) I looked close into sr_device.c, I dont think we should
decide in sr_device.c if SR is enabled by default or not. IMHO, this
should be passed on from board files. it is not the sr_device's call
to make. we have boards which are comfortable with SR and which are not.
example some boards may choose to enable SR late in the game, while
some may choose to enable it by default. we need to cater to both.

e.g. currently 3430 es3.1 would have SR enabled by default. N900 as an
example chooses to allow users to decide what to have and is enabled
late in the game (boots up disabled, gets enabled once userspace starts).


b) It assumes that 3630 have ntargets - this is true from ES1.1 onwards.
the older silicon dont have ntargets fused in them.

How do we want to handle these?

This is the second series independent of series 1:
http://marc.info/?l=linux-omap&m=127741497415352&w=2

Nishanth Menon (7):
  omap3: voltage: cleanup pr_xxxx
  omap3: sr: cleanup pr_xxx
  omap3: sr: enable/disable sr only if required
  omap3: sr: device: cleanup pr_xxx
  omap3: sr: device: add unlikely checks
  omap3: sr: device: check for dev_attr
  omap3: sr: device: fail sr_dev_init should return error

 arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++------
 arch/arm/mach-omap2/sr_device.c   |   29 +++++++++++++++++++----------
 arch/arm/mach-omap2/voltage.c     |    7 ++++---
 3 files changed, 41 insertions(+), 19 deletions(-)

Regards,
Nishanth Menon

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>
