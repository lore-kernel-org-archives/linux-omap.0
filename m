From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 00/14] staging: ti-soc-thermal: fixes and trending support
Date: Mon, 1 Apr 2013 12:04:32 -0400
Message-ID: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59101 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758837Ab3DAQFO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 12:05:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Greg,

Here is a new series of patches for ti-soc-thermal. It will contain
a couple of minor fixes, but it has also support for trending,
computed by HW history buffer.

These patches are also available here:
git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/ti-soc-thermal-history-buffer
https://git.gitorious.org/thermal-framework/thermal-framework.git thermal_work/omap/ti-soc-thermal-history-buffer

Eduardo Valentin (4):
  staging: ti-soc-thermal: return error in case power switch is not
    supported
  staging: ti-soc-thermal: expose ti_thermal_report_temperature
  staging: ti-soc-thermal: report alert events on OMAP4 devices
  staging: ti-soc-thermal: report alert events on OMAP5 devices

J Keerthy (9):
  staging: ti-soc-thermal: Add counter_delay_mask field to
    temp_sensor_registers struct
  staging: ti-soc-thermal: Initialise counter_delay field for OMAP5
    sensors
  staging: ti-soc-thermal: Introduce HAS_COUNTER_DELAY feature for
    bandgap
  staging: ti-soc-thermal: Enable COUNTER_DELAY feature for OMAP5
  staging: ti-soc-thermal: Modify update_interval r/w functions to
    incorporate the OMAP5 feature of COUNTER_DELAY.
  staging: ti-soc-thermal: Introduce HAS_HISTORY_BUFFER feature for
    bandgap
  staging: ti-soc-thermal: Enable HISTORY_BUFFER Feature for OMAP5
  staging: ti-soc-thermal:Introduce ti_bandgap_get_trend function for
    OMAP5
  staging: ti-soc-thermal: Add get_trend support

Nishanth Menon (1):
  staging: ti-soc-thermal: remove kernel-doc warnings reported with -v

 .../staging/ti-soc-thermal/omap4-thermal-data.c    |    2 +
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    8 +-
 drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h  |    1 +
 drivers/staging/ti-soc-thermal/ti-bandgap.c        |  298 +++++++++++++++++---
 drivers/staging/ti-soc-thermal/ti-bandgap.h        |   11 +
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |   27 ++-
 drivers/staging/ti-soc-thermal/ti-thermal.h        |    7 +
 7 files changed, 319 insertions(+), 35 deletions(-)

-- 
1.7.7.1.488.ge8e1c

