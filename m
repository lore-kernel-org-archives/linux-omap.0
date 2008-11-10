From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/03] OMAP3 PM: CPUFreq driver for OMAP3
Date: Mon, 10 Nov 2008 17:00:06 +0530
Message-ID: <00c701c94327$aec6cee0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50645 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506AbYKJLaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:30:15 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABU8PK028666
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:30:13 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABU7pY013449
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 17:00:07 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set implements the CPUFreq driver for OMAP3 platforms. I have these patches 
validated on 3430SDP using the omap_3430sdp_min_defconfig.

These patches apply on top of pm-20081106 (commit 0994b2df775ac04806ed) 
+ [PATCH 00/08] OMAP3 SRF: OPP and Frequency resources.
"CPUFreq" and "PM layer implemented using SRF" are selected by default now in 
the omap_3430sdp_min_defconfig.

CPUFreq driver now scales only between OPP1 and OPP4 (110% overdrive). 
By default the governor selected is "perforamance" hence the bootup happens at OPP4.
After bootup use this command to switch to ondemand governor
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

The ondemand governor can be tuned for sampling rate (rate at which CPU load samples are taken)
and up threshold using the following 
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold

regards,
Rajendra




  


