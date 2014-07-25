From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Fri, 25 Jul 2014 19:14:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com> <20140707080238.GF28884@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37823 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaGYTOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 15:14:21 -0400
In-Reply-To: <20140707080238.GF28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 7 Jul 2014, Tony Lindgren wrote:

> With v3.16-rc4 the PM features for omap3 should be working
> finally for device tree based booting. At lest beaglexm and
> 3xxevm should work.

Just to follow up briefly on this: there was indeed a bug in the OMAP3 
test scripts here that resulted in the UART wakeup not being enabled.

Once that was fixed, system suspend-based chip-retention and chip-off 
modes work.

However, scheduler-idle based chip-retention and chip-off still are not
working.  Looking at the logs, it appears that some domains are not 
dynamically going idle.  For example, looking at:

http://www.pwsan.com/omap/testlogs/test_v3.16-rc6/20140724142225/pm/37xxevm/37xxevm_log.txt

it can be seen that core_pwrdm's retention count doesn't increase between 
the two PM debug dumps.  The important lines are:

core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

and 

core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

That's why the test reports mark the dynamic PM modes as failing.

...

Here's an example where things worked:

http://www.pwsan.com/omap/testlogs/test_v3.10/20130717134228/pm/3530es3beagle/3530es3beagle_log.txt

In this one, it can be seen that the CORE counts transitioned from:

core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

to

core_pwrdm (ON),OFF:0,RET:10,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

between the retention suspend/resume test ending and the dynamic 
retention idle test ending.


- Paul



# # cat /debug/pm_debug/count



usbhost_pwrdm (ON),OFF:0,RET:333,INA:0,ON:334,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:333,INA:0,ON:334,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:297,INA:36,ON:334,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:297,INA:36,ON:334,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (15)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (22)
core_l3_clkdm->core_pwrdm (1)
neon_clkdm->neon_pwrdm (0)
# # # # ./test_rootfs_access_nonexistent_file__ret_susp

/bin/sh: 32: ./test_rootfs_access_nonexistent_file__ret_susp: not found
# # 
%% End retention double suspend/resume UART wakeup test


%% Start retention dynamic idle UART wakeup test

for u in `ls -1d /sys/bus/platform/drivers/omap_uart/*.serial | paste -s 
-d' '`; do echo 3000 >  $u/power/autosuspend_delay_ms; done

# # 

# # 

# # cat /debug/pm_debug/count

usbhost_pwrdm (ON),OFF:0,RET:433,INA:0,ON:434,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:23,INA:0,ON:24,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:433,INA:0,ON:434,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:393,INA:40,ON:434,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:393,INA:40,ON:434,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (13)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (21)
core_l3_clkdm->core_pwrdm (1)
neon_clkdm->neon_pwrdm (0)
# # 

# # ./test_rootfs_access_nonexistent_file__ret_dyn

/bin/sh: 44: ./test_rootfs_access_nonexistent_file__ret_dyn: not found
# # for u in `ls -1d /sys/bus/platform/drivers/omap_uart/*.serial | paste 
-s -d' '`; do echo -1 >  $u/power/autosuspend_delay_ms; done

# # 
%% End retention dynamic idle UART wakeup test

