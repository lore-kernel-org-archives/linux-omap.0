From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 10:27:43 +0100
Message-ID: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41532 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856Ab2CUJ1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 05:27:53 -0400
Received: by wgbdr13 with SMTP id dr13so526397wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:27:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

This patchset is a proposition to improve a bit the code.
The changes are code cleanup and does not change the behavior of the
driver itself.

A couple a things call my intention. Why the cpuidle device is set for cpu0 only
and why the WFI is not used ?

Daniel Lezcano (7):
  ARM: OMAP4: cpuidle - Remove unused valid field
  ARM: OMAP4: cpuidle - Declare the states with the driver declaration
  ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
  ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
  ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
  ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
  ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
    time

 arch/arm/mach-omap2/cpuidle44xx.c |  126 ++++++++++++++++---------------------
 1 files changed, 54 insertions(+), 72 deletions(-)

-- 
1.7.5.4

