From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Sat, 8 Jan 2011 11:59:55 +0100
Message-ID: <012DC19D-D4D1-4DE4-B709-F2E535485B73@dominion.thruhere.net>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57780 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1AHK77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 05:59:59 -0500
Received: by wyb28 with SMTP id 28so18147907wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 08 Jan 2011 02:59:57 -0800 (PST)
In-Reply-To: <1294421217-18730-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o List <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Sanjeev Premi <premi@ti.com>

Op 7 jan 2011, om 18:26 heeft Sanjeev Premi het volgende geschreven:

> The eFuse registers do not contain the nValue to be used
> with 720MHz (OPP6). This patch implements procedure to
> calculate the nValue(OPP6) based on the nValue(OPP5).

[..]

> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -258,6 +258,7 @@ static struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
> 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
> 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
> 	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
> +	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP6_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
> 	VOLT_DATA_DEFINE(0, 0, 0, 0),
> };

When using the 720MHz patches on top of Thara's DVFS patches it highlights some bugs in the voltage code. When testing on an USRP-E100 with an Gumstix Overo Tide inside:

root@usrp-e1xx:~# uname -a
Linux usrp-e1xx 2.6.37-rc8+ #87 PREEMPT Sat Jan 8 09:58:26 CET 2011 armv7l GNU/Linux
root@usrp-e1xx:~# cat /proc/cmdline 
console=ttyO2,115200n8 mpurate=720 [..] root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

root@usrp-e1xx:~# cat /proc/cpuinfo  | grep MIPS
BogoMIPS	: 717.37

So right after boot it's running at 720MHz, good.

root@usrp-e1xx:~# cpufreq-set -g ondemand ; sleep 1 ; cpufreq-set -g performance
root@usrp-e1xx:~# dmesg | grep -e platform -e omap
[ 5281.306762] cpufreq-omap: transition: 720000 --> 125000
[ 5282.017913] cpufreq-omap: transition: 125000 --> 720000
[ 5282.019409] cpufreq-omap: transition: 720000 --> 720000
[ 5282.019439] platform iva.0: omap_voltage_scale: Already at the requestedrate 430000000
[ 5282.029998] platform mpu.0: omap_voltage_scale: Already at the requestedrate 600000000
root@usrp-e1xx:~# cpufreq-info 
cpufrequtils 006: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  driver: omap
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 300 us.
  hardware limits: 125 MHz - 720 MHz
  available frequency steps: 125 MHz, 250 MHz, 500 MHz, 550 MHz, 600 MHz, 720 MHz
  available cpufreq governors: conservative, ondemand, userspace, powersave, performance
  current policy: frequency should be within 125 MHz and 720 MHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency is 600 MHz (asserted by call to hardware).
  cpufreq stats: 125 MHz:0.13%, 250 MHz:0.00%, 500 MHz:0.00%, 550 MHz:0.00%, 600 MHz:0.00%, 720 MHz:99.87%  (10)

It seems that because the voltages are the same for OPP5 and OPP6 it doesn't want to switch back to 720MHz.  But the strange this is:

root@usrp-e1xx:~# cat /proc/cpuinfo  | grep MIPS
BogoMIPS	: 717.37

I haven't run any benchmarks yet to see what the actual frequency is, but the above should demonstrate that things don't work quite right. 

regards,

Koen