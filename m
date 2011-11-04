From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/2] PMIC TPS65910 fixes
Date: Fri, 4 Nov 2011 18:17:30 +0530
Message-ID: <1320410850-20237-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series applies over Kyle Manna's v3 patch series,
https://lkml.org/lkml/2011/11/3/257,
with changes as per comments on
his 1/6 "mfd: TPS65910: Handle non-existent devices"

Regards
Afzal

Afzal Mohammed (2):
  mfd: TPS65910: Improvements
  regulator:TPS65910: VDD1/2 voltage selector count

 drivers/mfd/tps65910-irq.c             |   15 +++++++--------
 drivers/mfd/tps65910.c                 |   20 ++------------------
 drivers/regulator/tps65910-regulator.c |    1 +
 include/linux/mfd/tps65910.h           |    8 +-------
 4 files changed, 11 insertions(+), 33 deletions(-)
