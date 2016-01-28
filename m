From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] reboot: Introduce emergency_poweroff function
Date: Thu, 28 Jan 2016 18:36:27 +0530
Message-ID: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, oleg@redhat.com, toshi.kani@hp.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-patch-review@list.ti.com
Cc: j-keerthy@ti.com, nm@ti.com, grygorii.strashko@ti.com, mingo@kernel.org, josh@joshtriplett.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-omap@vger.kernel.org

The series introduces a new function emergency_poweroff which shuts
down the system after a configurable period of time. emergency_poweroff
is appropriate in case of thermal shutdown scenario.

Tested on DRA7-EVM.

Keerthy (2):
  reboot: Introduce emergency poweroff function
  thermal: Use emergency_poweroff instead of orderly_poweroff for
    shutdown scenario

 arch/Kconfig                   |  9 +++++++++
 drivers/thermal/thermal_core.c |  2 +-
 include/linux/reboot.h         |  1 +
 kernel/reboot.c                | 31 +++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
1.9.1
