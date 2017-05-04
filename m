From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Two non-critical cpcap charger fixes
Date: Wed,  3 May 2017 17:26:12 -0700
Message-ID: <20170504002614.11198-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's few more cpcap charger fixes based on newly discovered
documentation for similar hardware for NXP MC13783 PMIC in
MC13783UG.pdf. And with the ADC and charger values now making
sense, let's fix the charge voltage table too based on the ADC
values.

This set depends on the "[PATCH 0/4] Few cpcap charger fixes for
v4.12-rc cycle" set of patches.

Regards,

Tony


Tony Lindgren (2):
  power: supply: cpcap-charger: Update charge current table and add
    comments
  power: supply: cpcap-charger: Fix charger voltages based on ADC values

 drivers/power/supply/cpcap-charger.c | 83 +++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 34 deletions(-)

-- 
2.12.2
