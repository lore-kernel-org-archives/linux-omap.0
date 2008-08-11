From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Mon, 11 Aug 2008 18:41:38 +0530 (IST)
Message-ID: <52895.192.168.10.89.1218460298.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:39700 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbYHKNLo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 09:11:44 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7BDBd0Z009145
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:11:44 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7BDBZPG024634
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:11:37 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The patch which follows implements the CPUFreq driver for OMAP3, tested on
3430sdp.
The driver uses API's defined as part of the OMAP-PM layer.

Performance Governor is selected by default in the defconfig.
After bootup, to switch to ondemand or any other governor use the following
sysfs interface
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

The following patches posted on the l-o list are a pre-requisite for these
patches to apply.
[PATCH 0/2] Add clock post-rate-change notifier
[PATCH 00/10] OMAP3 SRF: OMAP PM interface implemented using Shared resource
Framework

regards,
Rajendra



