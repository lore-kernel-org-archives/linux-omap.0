From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from driver
Date: Tue, 08 Mar 2011 11:07:17 +0000
Message-ID: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52226 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1CHLHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:07:23 -0500
Received: by wwa36 with SMTP id 36so951436wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:07:22 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following series removes cpu_...() usage completely from the
omap-i2c driver by having decisions about functional implementation
choices in the SoC held in cpu-specific hwmod tables that are
already established, or for OMAP1 where there is no hwmod, set at
OMAP1-specific i2c bus addition time.

Along the way it solves two issues with the existing implementation,
that only 16-bit accesses are documented to be allowed to the I2C
peripheral unit, and that due to a confusion in the existing driver
about whether it is faced with a newer IP version on OMAP3530, currently
it writes to a random non-existent I2C register at times on that
platform.

The patch series is quite extended from the first try thanks to
comments from Benoit Cousson.

Patches are tested on OMAP3530 and OMAP4430 I have but will need
confirming they don't break anything on OMAP1xxx and OMAP2xxx as
agreed with Benoit.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>

---

Andy Green (18):
      I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info
      I2C: OMAP2+: Convert omap I2C driver to use feature implementation flags from platform data
      I2C: OMAP1: set i2c unit feature implementation flags in platform data
      I2C: OMAP2+: add correct functionality flags to all omap2plus i2c dev_attr
      I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test
      I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
      I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
      I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
      I2C: OMAP2+: address confused probed version naming
      I2C: OMAP2+: Solve array bounds overflow error on i2c idle
      I2C: OMAP2+: use platform_data ip revision to select register map
      I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c bus added
      I2C: OMAP1: set IP revision in platform data
      I2C: OMAP: add rev to omap i2c platform data
      I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
      I2C: OMAP2+:  Introduce I2C IP versioning constants
      I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
      I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c


 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    8 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   18 ++++-
 arch/arm/plat-omap/i2c.c                   |   27 ++++++++
 arch/arm/plat-omap/include/plat/i2c.h      |    3 +
 drivers/i2c/busses/i2c-omap.c              |   98 +++++++++++++++-------------
 include/linux/i2c-omap.h                   |   29 ++++++++
 8 files changed, 151 insertions(+), 51 deletions(-)

-- 
Signature
