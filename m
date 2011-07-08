From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP I2C cleanups for v3.1
Date: Fri, 08 Jul 2011 09:22:03 -0700
Message-ID: <87liw8agk4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60636 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab1GHQWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:22:08 -0400
Received: by iyh42 with SMTP id 42so3666470iyh.11
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:22:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Green <andy@warmcat.com>

Tony,

Please pull the I2C cleanup changes below for v3.1.

This is the same series from Andy Green that has been
posted/reviewed/tested many times except the omap_hwmod data patches
have been separated out into a separate series.

This version also has an Ack from Ben Dooks for merge via linux-omap.

Kevin


The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/i2c-andy

Andy Green (15):
      I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
      I2C: OMAP2+: Introduce I2C IP versioning constants
      I2C: OMAP: add rev to omap i2c platform data
      I2C: OMAP1: set IP revision in platform data
      I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c bus added
      I2C: OMAP2+: use platform_data ip revision to select register map
      I2C: OMAP2+: Solve array bounds overflow error on i2c idle
      I2C: OMAP2+: address confused probed version naming
      I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
      I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
      I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
      I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test
      I2C: OMAP1: set i2c unit feature implementation flags in platform data
      I2C: OMAP2+: Convert omap I2C driver to use feature implementation flags from platform data
      I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info

 arch/arm/plat-omap/i2c.c              |   27 +++++++++
 arch/arm/plat-omap/include/plat/i2c.h |    3 +-
 drivers/i2c/busses/i2c-omap.c         |  100 ++++++++++++++++++---------------
 include/linux/i2c-omap.h              |   29 ++++++++++
 4 files changed, 113 insertions(+), 46 deletions(-)
