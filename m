From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] thermal: Use emergency_poweroff instead of orderly_poweroff for shutdown scenario
Date: Thu, 28 Jan 2016 18:36:29 +0530
Message-ID: <1453986389-15887-3-git-send-email-j-keerthy@ti.com>
References: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, oleg@redhat.com, toshi.kani@hp.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-patch-review@list.ti.com
Cc: j-keerthy@ti.com, nm@ti.com, grygorii.strashko@ti.com, mingo@kernel.org, josh@joshtriplett.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-omap@vger.kernel.org

Currently when the system reaches dangerously high temperatures we are
calling orderly_poweroff function to gracefully shutdown the user space
and then power off the system. In the probe phase the orderly_poweroff
might fail leaving the system running at dangerously high temperatures.
Hence calling the emergency_poweroff function which shuts down the
system after a configurable period of time.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0a8fd1..220fc94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -446,7 +446,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		dev_emerg(&tz->device,
 			  "critical temperature reached(%d C),shutting down\n",
 			  tz->temperature / 1000);
-		orderly_poweroff(true);
+		emergency_poweroff();
 	}
 }
 
-- 
1.9.1

