From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Few cpcap charger fixes for v4.12-rc cycle
Date: Wed,  3 May 2017 17:15:28 -0700
Message-ID: <20170504001532.10585-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

While wondering how come the ADC values don't match the charger
values and Android kernel values, I noticed few issues that
would be good to fix for v4.12-rc cycle.

Especially we should stick with the Android kernel name "usb"
for the charger as there's no need to break the compability
there.

The other issues are fixes for misconfigured charger hardware.

Regards,

Tony


Tony Lindgren (4):
  power: supply: cpcap-charger: Fix charger name
  power: supply: cpcap-charger: Fix charge voltage configuration
  power: supply: cpcap-charger: Fix enable for 3.8V charge setting
  power: supply: cpcap-charger: Keep trickle charger bits disabled

 drivers/power/supply/cpcap-charger.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.12.2
