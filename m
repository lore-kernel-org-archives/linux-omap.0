From: jean.pihet@newoldbits.com
Subject: [PATCH 0/2] OMAP: PM: switch from omap_pm_ functions to PM QoS
Date: Wed, 19 Oct 2011 16:28:49 +0200
Message-ID: <1319034531-22964-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35313 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab1JSO3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 10:29:08 -0400
Received: by wyg36 with SMTP id 36so1784872wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Oct 2011 07:29:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

. Convert the OMAP I2C driver to the PM QoS API for MPU latency constraints
. Remove the latency related functions from OMAP PM in favor of
  the generic per-device PM QoS API


Apply on top of the OMAP PM QoS patch set [1].
Based on the pm-qos branch of the linux-pm git tree (3.1.0-rc3), cf. [2].

Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PER in
RETention and OFF modes.

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/65971
[2] git://github.com/rjwysocki/linux-pm.git


Jean Pihet (2):
  OMAP: convert I2C driver to PM QoS for latency constraints
  OMAP: PM: remove the latency related functions from the API

 Documentation/arm/OMAP/omap_pm            |   55 +++-------------
 arch/arm/plat-omap/i2c.c                  |   20 ------
 arch/arm/plat-omap/include/plat/omap-pm.h |   99 -----------------------------
 arch/arm/plat-omap/omap-pm-noop.c         |   88 -------------------------
 drivers/i2c/busses/i2c-omap.c             |   30 +++++-----
 include/linux/i2c-omap.h                  |    1 -
 6 files changed, 24 insertions(+), 269 deletions(-)

-- 
1.7.4.1

