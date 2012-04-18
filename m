From: jean.pihet@newoldbits.com
Subject: [PATCH 0/2] ARM: OMAP: PM: remove the latency related functions from the API
Date: Wed, 18 Apr 2012 15:55:12 +0200
Message-ID: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45388 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2DRNz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:55:29 -0400
Received: by wibhj6 with SMTP id hj6so727219wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:55:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Remove the following functions from the OMAP PM API and the callers
(currently only I2C driver):
 omap_pm_set_max_mpu_wakeup_lat
 omap_pm_set_max_dev_wakeup_lat
 omap_pm_set_max_sdma_lat
and updated the kernel Documentation accordingly.

The generic per-device PM QoS functions shall be used instead of the
OMAP PM API, cf. include/linux/pm_qos.h and
Documentation/power/pm_qos_interface.txt.

Based on the pm-qos branch of the linux-omap git tree (3.4.0-rc2) [1] with
the changes for the functional power states [2] and the per-device PM
QoS support for OMAP [3].

Tested cpuidle and suspend on OMAP3 Beagleboard (ES2.x) with constraints
on MPU, CORE, PER in RETention and OFF modes.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
[2] http://marc.info/?l=linux-omap&m=133475291911194&w=2
[3] http://marc.info/?l=linux-omap&m=133475685213067&w=2


Jean Pihet (2):
  ARM: OMAP: convert I2C driver to PM QoS for latency constraints
  ARM: OMAP: PM: remove the latency related functions from the API

 Documentation/arm/OMAP/omap_pm            |   68 ++++++--------------
 arch/arm/plat-omap/i2c.c                  |   21 ------
 arch/arm/plat-omap/include/plat/omap-pm.h |   99 -----------------------------
 arch/arm/plat-omap/omap-pm-noop.c         |   88 -------------------------
 drivers/i2c/busses/i2c-omap.c             |   28 +++++---
 include/linux/i2c-omap.h                  |    1 -
 6 files changed, 38 insertions(+), 267 deletions(-)

-- 
1.7.7.6

