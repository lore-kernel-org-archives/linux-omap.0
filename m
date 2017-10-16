From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] thermal: ti-soc-thermal: Fix ti_thermal_unregister_cpu_cooling NULL pointer on unload
Date: Mon, 16 Oct 2017 14:07:14 -0700
Message-ID: <20171016210714.16080-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

While debugging some PM issues and trying to remove all the loaded modules, I ran
across the following when unloading ti-soc-thermal:

Unable to handle kernel NULL pointer dereference at virtual address 000000b4
...
[<c08db340>] (kobject_put) from [<bf28954c>] (ti_thermal_unregister_cpu_cooling+0x20/0x28 [ti_soc_thermal])
[<bf28954c>] (ti_thermal_unregister_cpu_cooling [ti_soc_thermal]) from [<bf287c88>] (ti_bandgap_remove+0x3c/0x104 [ti_soc_thermal])
[<bf287c88>] (ti_bandgap_remove [ti_soc_thermal]) from [<c0610d48>] (platform_drv_remove+0x24/0x3c)
[<c0610d48>] (platform_drv_remove) from [<c060f114>] (device_release_driver_internal+0x160/0x208)
[<c060f114>] (device_release_driver_internal) from [<c060f200>] (driver_detach+0x38/0x6c)
[<c060f200>] (driver_detach) from [<c060e2d4>] (bus_remove_driver+0x4c/0xa0)
[<c060e2d4>] (bus_remove_driver) from [<c01f2370>] (SyS_delete_module+0x168/0x238)
[<c01f2370>] (SyS_delete_module) from [<c0108240>] (ret_fast_syscall+0x0/0x28)

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -278,7 +278,8 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	if (data) {
 		cpufreq_cooling_unregister(data->cool_dev);
-		cpufreq_cpu_put(data->policy);
+		if (data->policy)
+			cpufreq_cpu_put(data->policy);
 	}
 
 	return 0;
-- 
2.14.2
